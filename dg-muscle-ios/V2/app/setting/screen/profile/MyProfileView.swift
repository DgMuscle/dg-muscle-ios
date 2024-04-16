//
//  MyProfileView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/16/24.
//

import SwiftUI

struct MyProfileView: View {
    
    @StateObject var viewModel: MyProfileViewModel
    
    var body: some View {
        VStack {
            
            if let user = viewModel.user {
                MyProfileUserView(user: user) {
                    print("tap photo")
                } tapDisplayName: {
                    print("tap displayname")
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
                    
                    Text("OPEN").fontWeight(.black)
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
        }
        .padding()
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
    
    return MyProfileView(viewModel: viewModel).preferredColorScheme(.dark)
}
