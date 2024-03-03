//
//  FullRecordsView_BottomSheet.swift
//  dg-muscle-workspace
//
//  Created by 신동규 on 3/3/24.
//

import SwiftUI

extension FullRecordsView {
    struct BottomSheet: View {
        @Binding var show: Bool
        let saveAction: () -> ()
        let image: Image
        
        var body: some View {
            VStack {
                Button(action: {
                    show = false
                    saveAction()
                }, label: {
                    HStack {
                        Text("Save")
                        Spacer()
                    }
                })
                .padding()
                
                ShareLink(item: image, preview: SharePreview("Shared", image: image)) {
                    HStack {
                        Text("Share")
                        Spacer()
                    }   
                }
                .padding()
            }
        }
    }
}

#Preview {
    FullRecordsView.BottomSheet(show: .constant(true), saveAction: {
        print("save")
    }, image: .init(uiImage: UIImage()))
    .preferredColorScheme(.dark)
}
