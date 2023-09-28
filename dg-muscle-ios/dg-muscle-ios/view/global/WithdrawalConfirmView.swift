//
//  WithdrawalConfirmView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/29.
//

import SwiftUI

protocol WithdrawalConfirmDependency {
    func delete()
}

struct WithdrawalConfirmView: View {
    
    @State var animation1 = false
    @State var animation2 = false
    @State var text = ""
    @State var errorMessage: String?
    
    @Binding var isPresented: Bool
    
    let dependency: WithdrawalConfirmDependency
    
    var body: some View {
        Form {
            Section {
                Text("Are you sure want to remove your account?")
                
                
            } footer: {
                if animation1 {
                    Text("You can't undo this behavior")
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                TextField("Type your display name", text: $text)
            } footer: {
                if animation2 {
                    Text("If you don't have display name, just press continue")
                        .italic()
                }
            }
            
            Section {
                Button("continue") {
                    checkDisplayName()
                }
            } footer: {
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    self.errorMessage = nil
                                }
                            }
                        }
                }
            }

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    animation1.toggle()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    animation2.toggle()
                }
            }
        }
    }
    
    private func checkDisplayName() {
        let displayName = store.user.displayName ?? ""
        
        if text != displayName {
            withAnimation {
                errorMessage = "Not correct. Check your display name"
            }
            return
        }
        
        dependency.delete()
        isPresented.toggle()
    }
}

