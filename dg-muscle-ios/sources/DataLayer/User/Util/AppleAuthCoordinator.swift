//
//  AppleAuthCoordinator.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import AuthenticationServices
import CryptoKit
import FirebaseAuth
import Domain

public class AppleAuthCoordinatorImpl: NSObject, AppleAuthCoordinator {
    public weak var delegate: (any Domain.AppleAuthCoordinatorDelegate)?
    
    var currentNonce: String?
    let window: UIWindow?
    private let postLogUsecase: PostLogUsecase

    public init(
        window: UIWindow?,
        logRepository: LogRepository,
        userRepository: UserRepository
    ) {
        self.window = window
        self.postLogUsecase = .init(logRepository: logRepository, userRepository: userRepository)
    }

    public func startAppleLogin() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    postLogUsecase.implement(message: "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)", category: .error)
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }
}

extension AppleAuthCoordinatorImpl: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                postLogUsecase.implement(
                    message: "Invalid state: A login callback was received, but no login request was sent.",
                    category: .error
                )
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                delegate?.error(message: "Unable to fetch identity token")
                postLogUsecase.implement(
                    message: "Unable to fetch identity token",
                    category: .error
                )
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                postLogUsecase.implement(
                    message: "Unable to serialize token string from data: \(appleIDToken.debugDescription)",
                    category: .error
                )
                delegate?.error(message: "Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)

            //Firebase 작업
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    self.postLogUsecase.implement(message: error.localizedDescription, category: .error)
                    self.delegate?.error(message: error.localizedDescription)
                    return
                } else {
                    self.postLogUsecase.implement(message: "login success", category: .log)
                }
                // User is signed in to Firebase with Apple.
                // ...
            }
        }
    }
}

extension AppleAuthCoordinatorImpl: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        window!
    }
}
