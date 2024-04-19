//
//  MyProfileView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/16/24.
//

import SwiftUI

struct MyProfileView: View {
    
    @StateObject var viewModel: MyProfileViewModel
    @State var isPresentEditDisplayNameView: Bool = false
    @Binding var paths: NavigationPath
    
    var body: some View {
        ZStack {
            VStack {
                if let user = viewModel.user {
                    MyProfileUserView(user: user) {
                        paths.append(MainNavigation(name: .editProfilePhoto))
                    } tapDisplayName: {
                        isPresentEditDisplayNameView.toggle()
                    }
                    .padding(.bottom, 40)
                } else {
                    HStack {
                        Text("Can't find user info")
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                        Spacer()
                    }
                    .fontWeight(.heavy)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .secondarySystemBackground))
                    )
                    .padding(.bottom, 40)
                }
                
                VStack(spacing: 16) {
                    if let bodyMass = viewModel.bodyMass {
                        MyProfileListItemView(systemImageName: "figure",
                                              iconBackgroundColor: .green,
                                              label: "Weight(\(bodyMass.unit == .kg ? "kg" : "lb"))",
                                              value: String(bodyMass.value))
                    } else {
                        MyProfileListItemView(systemImageName: "figure",
                                              iconBackgroundColor: .green,
                                              label: "Weight",
                                              value: "Need Input")
                    }
                    
                    if let height = viewModel.height {
                        MyProfileListItemView(systemImageName: "figure.walk",
                                              iconBackgroundColor: .blue,
                                              label: "Height",
                                              value: String(height.value))
                    } else {
                        MyProfileListItemView(systemImageName: "figure.walk",
                                              iconBackgroundColor: .blue,
                                              label: "Height",
                                              value: "Need Input")
                    }
                    
                    MyProfileListItemView(systemImageName: "figure.dress.line.vertical.figure",
                                          iconBackgroundColor: .cyan,
                                          label: "Sex",
                                          value: viewModel.sexString)
                    
                    MyProfileListItemView(systemImageName: "birthday.cake",
                                          iconBackgroundColor: .purple,
                                          label: "Birth",
                                          value: viewModel.birthDateString)
                    
                    MyProfileListItemView(systemImageName: "drop",
                                          iconBackgroundColor: .red,
                                          label: "BloodType",
                                          value: viewModel.bloodTypeString)
                    
                }
                
                Button {
                    openUrl(urlString: "x-apple-health://")
                } label: {
                    HStack {
                        Text("You can update your health data in Apple Health").fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 20)
                        
                        Text("OPEN")
                            .foregroundStyle(.white)
                            .fontWeight(.black)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8).fill(
                                    LinearGradient(colors: [.green, .red], startPoint: .leading, endPoint: .trailing)
                                )
                            )
                    }
                    .padding(.top, 60)
                    .foregroundStyle(Color(uiColor: .label))
                }
                Spacer()
            }
            .padding()
            
            if isPresentEditDisplayNameView {
                EditDisplayNameView(displayName: viewModel.user?.displayName ?? "",
                                    isPresent: $isPresentEditDisplayNameView,
                                    userRepository: viewModel.userRepository)
            }
        }
        .navigationTitle("Profile")
        .animation(.default, value: isPresentEditDisplayNameView)
    }
    
    private func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

#Preview {
    let viewModel: MyProfileViewModel = .init(userRepository: UserRepositoryV2Test(),
                                              healthRepository: HealthRepositoryTest())
    
    return MyProfileView(viewModel: viewModel, 
                         paths: .constant(.init()))
    .preferredColorScheme(.dark)
}
