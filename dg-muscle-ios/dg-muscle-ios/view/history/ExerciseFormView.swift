//
//  ExerciseFormView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/1/23.
//

import SwiftUI

protocol ExerciseFormDependency {
    func tapSave(data: Exercise)
}

struct ExerciseFormView: View {
    let dependency: ExerciseFormDependency
    @State var name = ""
    @State var selectedParts: [Exercise.Part] = []
    @State var favorite = false
    
    @State var saveButtonVisible = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Exercise Form").font(.largeTitle)
                Spacer()
            }
            .padding()
            
            Form {
                Section("name") {
                    TextField("name", text: $name)
                }
                
                Section("parts") {
                    ForEach(Exercise.Part.allCases, id: \.self) { part in
                        HStack {
                            Text(part.rawValue)
                            Spacer()
                            if selectedParts.contains(part) {
                                Image(systemName: "checkmark").foregroundStyle(.blue)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                if let index = selectedParts.firstIndex(of: part) {
                                    selectedParts.remove(at: index)
                                } else {
                                    selectedParts.append(part)
                                }
                            }
                        }
                    }
                }
                
                Toggle("Favorite", isOn: $favorite)
            }
            
            if saveButtonVisible {
                Button {
                    let largestOrder = store.exercise.exercises.sorted(by: { $0.order < $1.order }).last?.order ?? 0
                    
                    let data = Exercise(id: UUID().uuidString, name: name, parts: selectedParts, favorite: favorite, order: largestOrder + 1, createdAt: nil)
                    dependency.tapSave(data: data)
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10).fill(.blue)
                        }
                        .padding()
                }
            }
        }
        .onChange(of: name) { _, newValue in
            withAnimation {
                saveButtonVisible = !newValue.isEmpty
            }
        }
    }
}

