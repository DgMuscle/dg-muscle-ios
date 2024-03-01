//
//  FullRecordsView_Bottomsheet.swift
//  dg-muscle-workspace
//
//  Created by 신동규 on 3/1/24.
//

import SwiftUI

extension FullRecordsView {
    struct BottomSheet: View {
        let saveAction: () -> ()
        let shareAction: () -> ()
        
        var body: some View {
            VStack(spacing: 20) {
                Button("Save") {
                    saveAction()
                }
                .foregroundStyle(Color(uiColor: .label))
                Divider()
                Button("Share") {
                    shareAction()
                }
            }
        }
    }
}
