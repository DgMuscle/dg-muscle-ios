//
//  MyProfileView.swift
//  My
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import SwiftUI
import Domain
import MockData
import Common

public struct MyProfileView: View {
    
    public init() { }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(uiColor: .systemBackground))
            
            Text("MyProfileView")
        }
    }
}

#Preview {
    return MyProfileView()
        .preferredColorScheme(.dark)
}
