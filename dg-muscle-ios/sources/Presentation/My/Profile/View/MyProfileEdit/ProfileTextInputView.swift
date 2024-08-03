//
//  ProfileTextInputView.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI

struct ProfileTextInputView: View {
    
    @State var text: String {
        didSet {
            if text.count > maxLength {
                text = String(text.prefix(maxLength))
            }
        }
    }
    @State var opacity: CGFloat = 0
    
    @Binding var showing: Bool
    
    @FocusState var focus
    
    let enter: ((String) -> ())?
    let maxLength: Int
    
    init(
        text: String,
        showing: Binding<Bool>,
        maxLength: Int,
        enter: ((String) -> ())?
    ) {
        self.text = text
        self._showing = showing
        self.enter = enter
        self.maxLength = maxLength
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.7))
                .ignoresSafeArea()
            
            topSection
            
            textInput
                .padding(.horizontal)
        }
        .foregroundStyle(.white)
        .opacity(opacity)
        .onAppear {
            focus = true
            withAnimation {
                opacity = 1
            }
        }
    }
    
    func dismiss() {
        withAnimation {
            opacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            showing = false
        }
    }
    
    var topSection: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    enter?(text)
                    dismiss()
                } label: {
                    Text("OK")
                        .foregroundStyle(text.isEmpty ? .gray : .white)
                }
                .disabled(text.isEmpty)
                
            }
            .overlay {
                Text("Name").fontWeight(.black)
            }
            .padding(.horizontal)
            Spacer()
        }
    }
    
    var textInput: some View {
        VStack(spacing: 12) {
            TextField("", text: $text)
                .focused($focus)
                .multilineTextAlignment(.center)
                .overlay {
                    HStack {
                        Spacer()
                        
                        if text.isEmpty == false {
                            Button {
                                text = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.caption2)
                                    .padding(4)
                                    .background {
                                        Circle()
                                            .fill(.gray)
                                    }
                            }
                        }
                    }
                }
            
            Rectangle()
                .fill(.white.opacity(0.6))
                .frame(height: 1)
            
            Text("\(text.count) / \(maxLength)")
                .font(.caption2)
        }
    }
}

#Preview {
    ProfileTextInputView(text: "동규", showing: .constant(true), maxLength: 20, enter: nil)
}
