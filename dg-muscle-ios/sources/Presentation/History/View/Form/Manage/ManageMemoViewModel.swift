//
//  ManageMemoViewModel.swift
//  History
//
//  Created by 신동규 on 6/30/24.
//

import Foundation
import Combine
import SwiftUI

final class ManageMemoViewModel: ObservableObject {
    
    @Published var stateMemo: String
    @Binding private var memo: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(memo: Binding<String>) {
        _memo = memo
        stateMemo = memo.wrappedValue
        bind()
    }
    
    private func bind() {
        $stateMemo
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] memo in
                self?.memo = memo
            }
            .store(in: &cancellables)
    }
}
