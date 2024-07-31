//
//  FullScreenImageView.swift
//  Common
//
//  Created by 신동규 on 7/31/24.
//

import SwiftUI
import Kingfisher
import MockData

public struct FullScreenImageView: View {
    
    @Binding var isPresent: Bool
    
    @State private var viewOffset: CGFloat = 0
    
    private let url: URL
    
    public init(
        isPresent: Binding<Bool>,
        url: URL
    ) {
        self._isPresent = isPresent
        self.url = url
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.clear)
                .background {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                }
                
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .offset(y: viewOffset)
        .gesture(
            DragGesture(minimumDistance: 15)
                .onChanged { gesture in
                    guard gesture.translation.height > 0 else { return }
                    viewOffset = gesture.translation.height
                }
                .onEnded { gesture in
                    let dismissableLocation = gesture.translation.height > 150
                    let dismissableVolocity = gesture.velocity.height > 150
                    if dismissableLocation || dismissableVolocity {
                        dismiss()
                    } else {
                        dragViewUp()
                    }
                }
        )
    }
    
    private func dismiss() {
        withAnimation {
            viewOffset = 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPresent = false
            }
        }
    }
    
    private func dragViewUp() {
        withAnimation {
            viewOffset = 0
        }
    }
}

#Preview {
    FullScreenImageView(isPresent: .constant(true), url: USER_DG.photoURL!)
        .preferredColorScheme(.dark)
}
