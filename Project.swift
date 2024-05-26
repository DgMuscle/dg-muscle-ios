import ProjectDescription

let projectName = "dg-muscle-ios"
let widgetName = "DgWidget"
let bundleId = "com.donggyu.dg-muscle-ios"
let appVersion: String = "2.0.0"

enum Layer: String, CaseIterable {
    case Domain
    case DataLayer
    case Presentation
}

enum Presentation: String, CaseIterable {
    case Auth
    case Common
    case Exercise
    case HistoryHeatMap
    case History
    case MockData
    case My
    case Friend
}

func createApp() -> Target {
    .target(
        name: "App",
        destinations: .iOS,
        product: .app,
        bundleId: bundleId,
        infoPlist: .extendingDefault(
            with: [
                "UILaunchStoryboardName": "LaunchScreen.storyboard",
                "FirebaseAppDelegateProxyEnabled": false,
                "UIBackgroundModes": [
                    "remote-notification"
                ],
                "CFBundleShortVersionString": "\(appVersion)",
                "CFBundleURLTypes": [
                    .dictionary([
                        "CFBundleTypeRole": "Editor",
                        "CFBundleURLName": "com.donggyu.dg-muscle-ios",
                        "CFBundleURLSchemes": [
                            "dgmuscle"
                        ]
                    ])
                ],
                "UILaunchScreen": .dictionary([
                    "UIImageName": "LaunchScreen"
                ]),
                "CFBundleDisplayName": "DgMuscle",
                "NSHealthShareUsageDescription": "We will sync your data with the Apple Health app to give you better insights",
                "NSHealthUpdateUsageDescription": "We will sync your data with the Apple Health app to give you better insights",
                "ITSAppUsesNonExemptEncryption": false
            ]
        ),
        sources: ["\(projectName)/sources/App/**"],
        resources: ["\(projectName)/resources/**"],
        entitlements: "\(projectName)/dg_muscle_ios.entitlements",
        dependencies: [
            .target(name: Layer.Presentation.rawValue, condition: nil),
            .target(name: Layer.DataLayer.rawValue, condition: nil),
            .target(name: widgetName, condition: nil)
        ],
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(projectName)/configs/app.xcconfig"),
            .release(name: "release", xcconfig: "\(projectName)/configs/app.xcconfig"),
        ]),
        environmentVariables: ["IDEPreferLogStreaming":"YES"]
    )
}

func createTest() -> Target {
    .target(
        name: "AppTests",
        destinations: .iOS,
        product: .unitTests,
        bundleId: bundleId + "Tests",
        infoPlist: .default,
        sources: ["\(projectName)/Tests/**"],
        dependencies: [
            .target(name: "App", condition: nil)
        ],
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(projectName)/configs/test.xcconfig"),
            .release(name: "release", xcconfig: "\(projectName)/configs/test.xcconfig"),
        ])
    )
}

func createWidget() -> Target {
    .target(
        name: widgetName,
        destinations: .iOS,
        product: .appExtension,
        bundleId: "com.donggyu.dg-muscle-ios.dg-muscle-ios-widget",
        infoPlist: .extendingDefault(with: [
            "NSExtension": .dictionary([
                "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
            ]),
            "CFBundleShortVersionString": "\(appVersion)",
            "CFBundleDisplayName": "DgMuscle"
        ]),
        sources: "\(widgetName)/Sources/**",
        resources: "\(widgetName)/Resources/**",
        entitlements: "\(widgetName)/\(widgetName).entitlements",
        dependencies: [
            .target(name: Layer.DataLayer.rawValue, condition: nil),
            .target(name: Presentation.HistoryHeatMap.rawValue, condition: nil)
        ],
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(widgetName)/Configs/widget.xcconfig"),
            .release(name: "release", xcconfig: "\(widgetName)/Configs/widget.xcconfig")
        ])
    )
}

func createLayers() -> [Target] {
    
    return Layer.allCases.map({
        switch $0 {
        case .Domain:
            return Target.target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\($0.rawValue)/**"]
            )
        case .DataLayer:
            var dependencies: [TargetDependency] = [
                .target(name: Layer.Domain.rawValue, condition: nil)
            ]
            
            dependencies.append(contentsOf: [
                .package(product: "FirebaseAuth", type: .runtime, condition: nil),
                .package(product: "FirebaseMessaging", type: .runtime, condition: nil),
                .package(product: "FirebaseStorage", type: .runtime, condition: nil)
            ])
            
            return Target.target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\($0.rawValue)/**"],
                dependencies: dependencies
            )
        case .Presentation:
            var dependencies: [TargetDependency] = []
            
            Presentation.allCases.forEach({
                dependencies.append(.target(name: $0.rawValue, condition: nil))
            })
            
            return Target.target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\($0.rawValue)/Parent/**"],
                dependencies: dependencies
            )
        }
    })
}

func createPresentations() -> [Target] {
    func createPresentation(_ presentation: Presentation, dependencies: [TargetDependency]) -> Target {
        let commonDependency: TargetDependency = .target(name: Presentation.Common.rawValue, condition: nil)
        var dependencies = dependencies
        dependencies.append(commonDependency)
        
        return .target(
            name: presentation.rawValue,
            destinations: .iOS,
            product: .framework,
            bundleId: bundleId + ".\(Layer.Presentation.rawValue).\(presentation.rawValue)".lowercased(),
            sources: ["\(projectName)/sources/\(Layer.Presentation.rawValue)/\(presentation.rawValue)/**"],
            dependencies: dependencies
        )
    }
    
    return Presentation.allCases.map({
        switch $0 {
        case .Auth, .HistoryHeatMap, .Exercise, .My, .Friend:
            return createPresentation($0, dependencies: [])
        case .History:
            return createPresentation($0, dependencies: [
                .target(name: Presentation.HistoryHeatMap.rawValue, condition: nil)
            ])
        case .MockData:
            return .target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\(Layer.Presentation.rawValue).\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\(Layer.Presentation.rawValue)/\($0.rawValue)/**"],
                dependencies: [
                    .target(name: Layer.Domain.rawValue, condition: nil)
                ]
            )
        case .Common:
            return .target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\(Layer.Presentation.rawValue).\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\(Layer.Presentation.rawValue)/\($0.rawValue)/**"],
                dependencies: [
                    .target(name: Presentation.MockData.rawValue, condition: nil),
                    .target(name: Layer.Domain.rawValue, condition: nil),
                    .package(product: "Kingfisher", type: .runtime, condition: nil),
                    .package(product: "SnapKit", type: .runtime, condition: nil)
                ]
            )
        }
    })
}

var targets: [Target] {
    var targets: [Target] = []
    targets.append(createApp())
    targets.append(contentsOf: createLayers())
    targets.append(contentsOf: createPresentations())
    targets.append(createTest())
    targets.append(createWidget())
    return targets
}

let project = Project(
    name: projectName,
    packages: [
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.11.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.7.1"))
    ],
    settings: .settings(configurations: [
        .debug(name: "debug", xcconfig: "\(projectName)/configs/project.xcconfig"),
        .release(name: "release", xcconfig: "\(projectName)/configs/project.xcconfig")
    ]),
    targets: targets
)
