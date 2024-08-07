//
//  MyProfileView.swift
//  My
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import SwiftUI
import Domain
import MockData
import Common
import Kingfisher

public struct MyProfileView: View {

    struct IdentifiableURL: Identifiable {
        let id = UUID().uuidString
        let url: URL
    }

    @Binding var shows: Bool

    @State private var viewOffset: CGFloat = 0
    @State private var selectedImageURL: URL? = nil
    @State private var opacity: CGFloat = 0

    @StateObject var viewModel: MyProfileViewModel

    private let myProfileEditFactory: (Binding<Bool>) -> MyProfileEditView

    public init(
        shows: Binding<Bool>,
        userRepository: UserRepository,
        myProfileEditFactory: @escaping (Binding<Bool>) -> MyProfileEditView
    ) {
        _shows = shows
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
        self.myProfileEditFactory = myProfileEditFactory
    }

    public var body: some View {
        ZStack {
            BackgroundImageView(url: viewModel.user?.backgroundImageURL) { url in
                selectedImageURL = url
            }
            VStack {
                xButton
                Spacer()
                profileView
                if let user = viewModel.user {
                    Text((user.displayName?.isEmpty == false) ? user.displayName! : user.uid)
                        .foregroundStyle((user.displayName?.isEmpty == false) ? .white : .gray)
                }

                whiteLine
                    .padding(.top, 30)
                bottomSection
                    .padding(.top)
            }

            if selectedImageURL != nil {
                FullScreenImageView(url: $selectedImageURL)
            }

            if viewModel.isEditing {
                myProfileEditFactory($viewModel.isEditing)
            }
        }
        .opacity(opacity)
        .offset(y: viewOffset)
        .gesture (
            DragGesture(minimumDistance: 15)
                .onChanged { gesture in
                    guard gesture.translation.height > 0 else { return }
                    viewOffset = gesture.translation.height
                }
                .onEnded { gesture in
                    let dismissableLocation = gesture.translation.height > 150
                    let dismissableVolocity = gesture.velocity.height > 150
                    if dismissableLocation || dismissableVolocity {
                        dismiss()
                    } else {
                        dragViewUp()
                    }
                }
        )
        .onAppear {
            withAnimation {
                opacity = 1
            }
        }
    }

    private func dismiss() {
        withAnimation {
            viewOffset = 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                shows = false
            }
        }
    }

    private func dragViewUp() {
        withAnimation {
            viewOffset = 0
        }
    }

    var xButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .font(.title)
            }

            Spacer()
        }
        .padding(.horizontal)
    }

    var profileView: some View {
        RoundedRectangle(cornerRadius: 40, style: .continuous)
            .stroke(.white.opacity(0.6))
            .fill(.clear)
            .frame(width: 100, height: 100)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(.gray)

                    Image(systemName: "person")
                        .font(.title)
                        .foregroundStyle(.white)

                    if let url = viewModel.user?.photoURL {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .onTapGesture {
                                if selectedImageURL == nil {
                                    selectedImageURL = url
                                }
                            }
                    }
                }
            }
    }

    var whiteLine: some View {
        Rectangle()
            .fill(.white.opacity(0.7))
            .frame(height: 1)
    }

    var bottomSection: some View {
        HStack(spacing: 40) {

            if let link = viewModel.user?.link {
                Button {
                    URLManager.shared.open(url: link)
                } label: {
                    VStack(spacing: 12) {
                        Image(systemName: "link")
                        Text("Link")
                    }
                }
                .foregroundStyle(.white)
            }

            Button {
                viewModel.isEditing = true
            } label: {
                VStack(spacing: 12) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    return MyProfileView(
        shows: .constant(true),
        userRepository: UserRepositoryMock(),
        myProfileEditFactory: { _ in
            MyProfileEditView(
                userRepository: UserRepositoryMock(),
                isEditing: .constant(true)
            )
        }
    )
        .preferredColorScheme(.dark)
}
