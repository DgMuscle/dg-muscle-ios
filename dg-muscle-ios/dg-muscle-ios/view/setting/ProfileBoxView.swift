//
//  ProfileBoxView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI

struct ProfileBoxView: View {
    
    let dependency: SettingViewDependency
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color(uiColor: .systemBackground).opacity(0.9))
                .onTapGesture {
                    withAnimation {
                        isShowing.toggle()
                    }
                }
            
            VStack {
                VStack(spacing: 10) {
                    Image(systemName: "person").font(.title)
                    Text("profile")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                
                VStack(alignment: .trailing, spacing: 0) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("display name")
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        dependency.tapDisplayName()
                    }
                    
                    
                    Divider()
                    HStack {
                        Image(systemName: "photo")
                        Text("profile photo")
                        Spacer()
                    }.padding()
                        .onTapGesture {
                            dependency.tapProfileImage()
                        }
                }
                .background(Color(uiColor: .systemBackground))
                .padding(.bottom, 25)
            }
            .background {
                RoundedRectangle(cornerRadius: 25.0).fill(Color(uiColor: .secondarySystemGroupedBackground))
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

