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
    
    @StateObject var userStore = store.user
    
    let dependency: WithdrawalConfirmDependency
    
    var body: some View {
        Form {
            Section {
                Text("agree_remove_account")
                
            } footer: {
                if animation1 {
                    Text("agree_remove_account2")
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                TextField("Type your display name", text: $text)
            } footer: {
                if animation2 {
                    Text("agree_remove_account3")
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
        let displayName = userStore.displayName ?? ""
        
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

#Preview {
    struct DP: WithdrawalConfirmDependency {
        func delete() { }
    }
    
    @State var showing = true
    
    return WithdrawalConfirmView(isPresented: $showing, dependency: DP())
}
