import ProjectDescription

let projectName = "dg-muscle-ios"
let bundleId = "com.donggyu.dg-muscle-ios"

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
        dependencies: [
            .target(name: "Data", condition: nil),
            .target(name: "Domain", condition: nil),
            .target(name: "Auth", condition: nil)
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
        name: "Test",
        destinations: .iOS,
        product: .unitTests,
        bundleId: bundleId + ".test",
        sources: ["\(projectName)/sources/Test/**"],
        dependencies: [
            .target(name: "Domain", condition: nil)
        ],
        settings: .settings(configurations: [
            .debug(name: "debug", xcconfig: "\(projectName)/configs/test.xcconfig"),
            .release(name: "release", xcconfig: "\(projectName)/configs/test.xcconfig"),
        ])
    )
}

func createLayer(layerName: String, dependencies: [TargetDependency]) -> Target {
    .target(
        name: layerName,
        destinations: .iOS,
        product: .framework,
        bundleId: bundleId + ".\(layerName)".lowercased(),
        sources: ["\(projectName)/sources/\(layerName)/**"],
        resources: ["\(projectName)/resources/**"],
        dependencies: dependencies
    )
}

func createPresentation(name: String, dependencies: [TargetDependency]) -> Target {
    .target(
        name: "\(name)",
        destinations: .iOS,
        product: .framework,
        bundleId: bundleId + ".presentation.\(name.lowercased())",
        sources: ["\(projectName)/sources/Presentation/\(name)/**"],
        resources: ["\(projectName)/resources/**"],
        dependencies: dependencies
    )
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
    targets: [
        createApp(),
        createLayer(layerName: "Domain", dependencies: []),
        createLayer(layerName: "Data", dependencies: [
            .target(name: "Domain", condition: nil),
            .package(product: "FirebaseAuth", type: .runtime, condition: nil),
            .package(product: "FirebaseMessaging", type: .runtime, condition: nil)
        ]),
        createPresentation(name: "Auth", dependencies: [
            .target(name: "Domain", condition: nil)
        ]),
        createTest()
    ]
)
