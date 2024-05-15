import ProjectDescription

let projectName = "dg-muscle-ios"
let bundleId = "com.donggyu.dg-muscle-ios"

enum Layer: String, CaseIterable {
    case Domain
    case Data
    case Presentation
}

enum Presentation: String, CaseIterable {
    case Auth
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
        dependencies:  Layer.allCases.map({ .target(name: $0.rawValue, condition: nil) }) ,
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
            .target(name: Layer.Domain.rawValue, condition: nil)
        ],
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(projectName)/configs/test.xcconfig"),
            .release(name: "release", xcconfig: "\(projectName)/configs/test.xcconfig"),
        ])
    )
}

func createLayers() -> [Target] {
    let commonDependency: TargetDependency = .target(name: Layer.Domain.rawValue, condition: nil)
    
    return Layer.allCases.map({
        switch $0 {
        case .Domain:
            return Target.target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\($0.rawValue)/**"],
                resources: ["\(projectName)/resources/**"]
            )
        case .Data:
            var dependencies: [TargetDependency] = [commonDependency]
            
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
                resources: ["\(projectName)/resources/**"],
                dependencies: dependencies
            )
        case .Presentation:
            var dependencies: [TargetDependency] = [commonDependency]
            
            Presentation.allCases.forEach({
                dependencies.append(.target(name: $0.rawValue, condition: nil))
            })
            
            return Target.target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\($0.rawValue)".lowercased(),
                dependencies: dependencies
            )
        }
    })
}

func createPresentations() -> [Target] {
    
    let commonDependency: TargetDependency = .target(name: Layer.Domain.rawValue, condition: nil)
    
    return Presentation.allCases.map({
        switch $0 {
        case .Auth:
            return .target(
                name: $0.rawValue,
                destinations: .iOS,
                product: .framework,
                bundleId: bundleId + ".\(Layer.Presentation.rawValue).\($0.rawValue)".lowercased(),
                sources: ["\(projectName)/sources/\(Layer.Presentation.rawValue)/\($0.rawValue)/**"],
                resources: ["\(projectName)/resources/**"],
                dependencies: [commonDependency]
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
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0"))
    ],
    settings: .settings(configurations: [
        .debug(name: "debug", xcconfig: "\(projectName)/configs/project.xcconfig"),
        .release(name: "release", xcconfig: "\(projectName)/configs/project.xcconfig")
    ]),
    targets: targets
)
