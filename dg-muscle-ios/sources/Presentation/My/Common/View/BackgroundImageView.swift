//
//  BackgroundImageView.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI
import Kingfisher

struct BackgroundImageView: View {
    
    let url: URL?
    let tapImage: ((URL) -> ())?
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .background {
                ZStack {
                    Rectangle()
                        .fill(.gray)
                    
                    if let url {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .onTapGesture {
                                tapImage?(url)
                            }
                    }
                }
            }
            .ignoresSafeArea()
    }
}
