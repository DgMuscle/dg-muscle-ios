//
//  EditDisplayNameView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/17/24.
//

import SwiftUI

struct EditDisplayNameView: View {
    
    @State var displayName: String
    @Binding var isPresent: Bool
    let userRepository: UserRepositoryV2
    
    @State private var animate: Bool = false
    @FocusState private var focus: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    focus.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        animate.toggle()
                        isPresent.toggle()
                    }
                }
            
            if animate {
                VStack {
                    TextField("Display Name", text: $displayName)
                        .multilineTextAlignment(.center)
                        .fontWeight(.black)
                        .padding()
                        .focused($focus)
                        .onAppear {
                            focus.toggle()
                        }
                    
                    Divider()
                    
                    Button("SAVE") {
                        focus.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            animate.toggle()
                            Task {
                                try? await userRepository.updateUser(displayName: displayName)
                            }
                            isPresent.toggle()
                        }
                    }
                    .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(uiColor: .secondarySystemBackground))
                )
                .padding(.horizontal, 60)
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            animate.toggle()
        }
    }
}

#Preview {
    ZStack {
        
        Rectangle().fill(.yellow)
            .ignoresSafeArea()
        
        EditDisplayNameView(displayName: "DONG GYU", 
                            isPresent: .constant(true),
                            userRepository: UserRepositoryV2Test())
            .preferredColorScheme(.dark)
    }
}
