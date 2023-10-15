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
    func tapSave(displayName: String, height: Double, weight: Double)
}

struct BodyProfileView: View {
    let dependency: BodyProfileViewDependency
    private let profileImageSize: CGFloat = 40
    
    
    @StateObject private var userStore: UserStore = store.user
    
    @State var displayName = store.user.displayName ?? ""
    
    @State var height: Double = store.user.recentProfileSpec?.height ?? 0
    @State var weight: Double = store.user.recentProfileSpec?.weight ?? 0 
    
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
            
            Section("body profile") {
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
                dependency.tapSave(displayName: displayName, height: height, weight: weight)
            } label: {
                Text("Save")
            }
        }
    }
}
