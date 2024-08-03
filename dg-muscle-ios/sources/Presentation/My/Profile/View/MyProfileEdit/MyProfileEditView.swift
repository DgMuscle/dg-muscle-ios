//
//  MyProfileEditView.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI

public struct MyProfileEditView: View {
    
    @StateObject var viewModel: MyProfileEditViewModel
    
    public init() {
        _viewModel = .init(wrappedValue: .init())
    }
    
    public var body: some View {
        Text("MyProfileEditView")
    }
}

#Preview {
    MyProfileEditView()
        .preferredColorScheme(.dark)
}
