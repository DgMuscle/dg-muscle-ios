//
//  BodyProfileView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/3/23.
//

import SwiftUI
import Kingfisher

protocol BodyProfileViewDependency {
    func tapProfileImage()
    func tapSave(displayName: String)
    func openHealthApp()
}

struct BodyProfileView: View {
    let dependency: BodyProfileViewDependency
    private let profileImageSize: CGFloat = 40
    
    
    @StateObject private var userStore = store.user
    @StateObject private var healthStore = store.health
    
    @State var displayName = store.user.displayName ?? ""
    
    var body: some View {
        Form {
            Section("dg-muscle profile") {
                HStack {
                    KFImage(userStore.photoURL)
                        .placeholder {
                            Circle().fill(Color(uiColor: .secondarySystemBackground).gradient)
                        }
                        .resizable()
                        .frame(width: profileImageSize, height: profileImageSize)
                        .scaledToFit()
                        .clipShape(.circle)
                        .onTapGesture {
                            dependency.tapProfileImage()
                        }
                    
                    TextField("display name", text: $displayName).font(.footnote).italic()
                }
            }
            
            Section {
                HStack {
                    Image(systemName: "figure.stand").foregroundStyle(.purple)
                    Text("heights").foregroundStyle(.purple).font(.caption).bold()
                    Spacer()
                    if let height = healthStore.recentHeight {
                        Text(String(format: "%.1f", height.value)).bold()
                        switch height.unit {
                        case .centi:
                            Text("cm").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        }
                    } else {
                        openHealthAppLabel
                    }
                }
                
                HStack {
                    Image(systemName: "figure.stand").foregroundStyle(.purple)
                    Text("weights").foregroundStyle(.purple).font(.caption).bold()
                    Spacer()
                    
                    if let weight = healthStore.recentBodyMass {
                        Text(String(format: "%.1f", weight.value)).bold()
                        
                        switch weight.unit {
                        case .kg:
                            Text("kg").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .lbs:
                            Text("lbs").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        }
                    } else {
                        openHealthAppLabel
                    }
                }
                
                HStack {
                    Image(systemName: "person").foregroundStyle(.purple)
                    Text("birth").foregroundStyle(.purple).font(.caption).bold()
                    Spacer()
                    
                    if let dateString = getDateString(components: healthStore.birthDateComponents) {
                        Text(dateString).foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                    } else {
                        openHealthAppLabel
                    }
                }
                
                HStack {
                    Image(systemName: "person").foregroundStyle(.purple)
                    Text("sex").foregroundStyle(.purple).font(.caption).bold()
                    Spacer()
                    
                    if let sex = healthStore.sex {
                        switch sex {
                        case .female:
                            Text("female").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .male:
                            Text("male").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        default:
                            openHealthAppLabel
                        }
                    } else {
                        openHealthAppLabel
                    }
                }
                
                HStack {
                    Image(systemName: "person").foregroundStyle(.purple)
                    Text("blood type").foregroundStyle(.purple).font(.caption).bold()
                    Spacer()
                    
                    if let bloodType = healthStore.bloodType {
                        
                        switch bloodType {
                        case .notSet:
                            openHealthAppLabel
                        case .aPositive:
                            Text("A+").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .aNegative:
                            Text("A-").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .bPositive:
                            Text("B+").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .bNegative:
                            Text("B-").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .abPositive:
                            Text("AB+").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .abNegative:
                            Text("AB-").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .oPositive:
                            Text("O+").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        case .oNegative:
                            Text("O-").foregroundStyle(Color(uiColor: .secondaryLabel)).font(.caption)
                        default:
                            openHealthAppLabel
                        }
                    } else {
                        openHealthAppLabel
                    }
                }
                
            } header: {
                Text("health profile")
            }
            
            Button {
                dependency.tapSave(displayName: displayName)
            } label: {
                Text("Save")
            }
        }
    }
    
    private func getDateString(components: DateComponents?) -> String? {
        guard let components else { return nil }
        guard let date = Calendar.current.date(from: components) else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    var openHealthAppLabel: some View {
        Button {
            dependency.openHealthApp()
        } label: {
            HStack {
                Text("Enter profile in the Health app").font(.caption2)
                Image(systemName: "arrowshape.turn.up.right").font(.caption2)
            }
            .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
    }
}
