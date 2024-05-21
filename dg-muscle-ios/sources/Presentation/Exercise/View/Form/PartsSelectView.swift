//
//  PartsSelectView.swift
//  Exercise
//
//  Created by 신동규 on 5/21/24.
//

import SwiftUI

struct PartsSelectView: View {
    
    let parts: [Exercise.Part] = Exercise.Part.allCases
    @Binding var selectedParts: [Exercise.Part]
    
    init(selectedParts: Binding<[Exercise.Part]>) {
        _selectedParts = selectedParts
    }
    
    var body: some View {
        ForEach(parts, id: \.self) { part in
            if selectedParts.contains(part) {
                Button {
                    tap(part)
                } label: {
                    Text(part.rawValue)
                }
                .foregroundStyle(Color(uiColor: .label))
                .listRowBackground(Color.green.opacity(0.4))
                
            } else {
                Button {
                    tap(part)
                } label: {
                    Text(part.rawValue)
                }
                .foregroundStyle(Color(uiColor: .label))
                
            }
        }
    }
    
    private func tap(_ part: Exercise.Part) {
        if let index = selectedParts.firstIndex(of: part) {
            selectedParts.remove(at: index)
        } else {
            selectedParts.append(part)
        }
    }
}

#Preview {
    List {
        PartsSelectView(selectedParts: .constant([.leg]))
    }
    .preferredColorScheme(.dark)
}
