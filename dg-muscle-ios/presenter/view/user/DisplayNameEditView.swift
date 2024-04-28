//
//  DisplayNameEditView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct DisplayNameEditView: View {
    @State var displayName: String
    let enterName: ((String) -> ())?
    let tapBackground: (() -> ())?
    
    @State private var presentTextField: Bool = false
    @FocusState private var focus: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    focus = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        tapBackground?()
                    }
                }
            
            if presentTextField {
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
                        focus = false
                        presentTextField.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            enterName?(displayName)
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
        .animation(.default, value: presentTextField)
        .onAppear {
            presentTextField.toggle()
        }
    }
}

#Preview {
    return DisplayNameEditView(displayName: "DG",
                        enterName: nil,
                        tapBackground: nil)
    .preferredColorScheme(.dark)
}
