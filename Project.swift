import ProjectDescription

let projectName = "dg-muscle-ios"
let bundleId = "com.donggyu.dg-muscle-ios"

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
                    ]
                ]
            ),
            sources: ["\(projectName)/sources/App/**"],
            resources: ["\(projectName)/resources/**"],
            dependencies: [
                .package(product: "FirebaseMessaging", type: .runtime, condition: nil),
                .target(name: "Domain", condition: nil)
            ],
            settings: .settings(configurations: [
                .debug(name: "debug", xcconfig: "\(projectName)/configs/app.xcconfig"),
                .release(name: "release", xcconfig: "\(projectName)/configs/app.xcconfig"),
            ]),
            environmentVariables: ["IDEPreferLogStreaming":"YES"]
        ),
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: bundleId + ".domain",
            sources: ["\(projectName)/sources/Domain/**"],
            resources: ["\(projectName)/resources/**"]
        ),
        .target(
            name: "Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: bundleId + ".test",
            sources: ["\(projectName)/sources/Test/**"],
            dependencies: [
                .target(name: "App")
            ],
            settings: .settings(configurations: [
                .debug(name: "debug", xcconfig: "\(projectName)/configs/test.xcconfig"),
                .release(name: "release", xcconfig: "\(projectName)/configs/test.xcconfig"),
            ])
        )
    ]
)
