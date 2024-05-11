//
//  HealthInfoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HealthInfoView: View {
    
    @StateObject var viewModel: HealthInfoViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.items, id: \.self) { item in
                HealthInfoItemView(systemImageName: item.image, iconBackgroundColor: item.color, label: item.left, value: item.right)
            }
            Button {
                openUrl(urlString: "x-apple-health://")
            } label: {
                RoundedGradationText(text: "Can Update from Health App")
            }
            .padding(.top, 40)
        }
    }
    
    private func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

#Preview {
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    let viewModel: HealthInfoViewModel = .init(getHealthInfoUsecase: .init(healthRepository: healthRepository))
    return HealthInfoView(viewModel: viewModel).preferredColorScheme(.dark)
}
