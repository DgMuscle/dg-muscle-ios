import ProjectDescription

let projectName = "dg-muscle-ios"
let bundleId = "com.donggyu.dg-muscle-ios"

enum Layer: String, CaseIterable {
    case Domain
    case DataLayer
    case Presentation
}

enum Presentation: String, CaseIterable {
    case Auth
    case Common
    case Exercise
    case HeatMap
    case History
    case MockData
    case My
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
                "UIBackgroundModes": [
                    "remote-notification"
                ],
                "FirebaseAppDelegateProxyEnabled": false,
                "CFBundleShortVersionString": "2.0.0"
            ]
        ),
        sources: ["\(projectName)/sources/App/**"],
        resources: ["\(projectName)/resources/**"],
        dependencies:  Layer
            .allCases
            .filter({ $0 != .Domain })
            .map({ .target(name: $0.rawValue, condition: nil) }) ,
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(projectName)/configs/app.xcconfig"),
            .release(name: "release", xcconfig: "\(projectName)/configs/app.xcconfig"),
        ]),
        environmentVariables: ["IDEPreferLogStreaming":"YES"]
    )
}

func createTest() -> Target {
    .target(
        name: "Test",
        destinations: .iOS,
        product: .unitTests,
        bundleId: bundleId + ".test",
        sources: ["\(projectName)/sources/Test/**"],
        dependencies: [
            .target(name: Presentation.Common.rawValue, condition: nil)
        ],
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(projectName)/configs/test.xcconfig"),
            .release(name: "release", xcconfig: "\(projectName)/configs/test.xcconfig"),
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
                .package(product: "FirebaseMessaging", type: .runtime, condition: nil)
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
        case .Auth, .HeatMap, .Exercise, .My:
            return createPresentation($0, dependencies: [])
        case .History:
            return createPresentation($0, dependencies: [
                .target(name: Presentation.HeatMap.rawValue, condition: nil)
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
    return targets
}

let project = Project(
    name: projectName,
    packages: [
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.11.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.7.1"))
    ],
    settings: .settings(configurations: [
        .debug(name: "debug", xcconfig: "\(projectName)/configs/project.xcconfig"),
        .release(name: "release", xcconfig: "\(projectName)/configs/project.xcconfig")
    ]),
    targets: targets
)
