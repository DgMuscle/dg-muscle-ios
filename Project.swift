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
                .target(name: "Data", condition: nil),
                .target(name: "Domain", condition: nil),
                .target(name: "Auth", condition: nil)
            ],
            settings: .settings(configurations: [
                .debug(name: "debug", xcconfig: "\(projectName)/configs/app.xcconfig"),
                .release(name: "release", xcconfig: "\(projectName)/configs/app.xcconfig"),
            ]),
            environmentVariables: ["IDEPreferLogStreaming":"YES"]
        ),
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: bundleId + ".data",
            sources: ["\(projectName)/sources/Data/**"],
            resources: ["\(projectName)/resources/**"],
            dependencies: [
                .target(name: "Domain", condition: nil),
                .package(product: "FirebaseAuth", type: .runtime, condition: nil),
                .package(product: "FirebaseMessaging", type: .runtime, condition: nil)
            ]
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
            name: "Auth",
            destinations: .iOS,
            product: .framework,
            bundleId: bundleId + ".presentation.auth",
            sources: ["\(projectName)/sources/Presentation/Auth/**"],
            resources: ["\(projectName)/resources/**"],
            dependencies: [
                .target(name: "Data", condition: nil)
            ]
        ),
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
    ]
)
