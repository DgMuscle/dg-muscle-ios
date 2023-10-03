//
//  BodyProfileView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/3/23.
//

import SwiftUI
import Kingfisher

protocol BodyProfileViewDependency {
    func tapProfileImage()
}

struct BodyProfileView: View {
    let dependency: BodyProfileViewDependency
    private let profileImageSize: CGFloat = 40
    
    
    @StateObject private var userStore: UserStore = store.user
    
    @State var displayName = store.user.displayName ?? ""
    
    @State var height: Double = 0.0
    @State var weight: Double = 0.0
    
    var body: some View {
        Form {
            
            Section("basic profile") {
                KFImage(userStore.photoURL)
                    .placeholder {
                        Circle().fill(Color(uiColor: .secondarySystemBackground).gradient)
                    }
                    .resizable()
                    .frame(width: profileImageSize, height: profileImageSize)
                    .scaledToFit()
                    .clipShape(.circle)
                    .onTapGesture {
                        dependency.tapProfileImage()
                    }
                
                TextField("display name", text: $displayName)
            }
            
            Section("body profile(preparing)") {
                HStack {
                    TextField("height", value: $height, format: .number)
                        .keyboardType(.decimalPad)
                    Text("cm")
                }
                
                HStack {
                    TextField("weight", value: $weight, format: .number)
                        .keyboardType(.decimalPad)
                    Text("kg")
                }
            }
            
            Button {
                print("tap save")
            } label: {
                Text("Save")
            }
        }
    }
}
