import ProjectDescription

let projectName = "dg-muscle-ios"
let bundleName = "com.donggyu.dg-muscle-ios"

let project = Project(
    name: projectName,
    settings: .settings(configurations: [
        .debug(name: "debug", xcconfig: "\(projectName)/configs/project.xcconfig"),
        .release(name: "release", xcconfig: "\(projectName)/configs/project.xcconfig")
    ]),
    targets: [
        .target(
            name: "app",
            destinations: .iOS,
            product: .app,
            bundleId: bundleName,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["\(projectName)/sources/app/**"],
            resources: ["\(projectName)/resources/**"],
            dependencies: [],
            settings: .settings(configurations: [
                .debug(name: "debug", xcconfig: "\(projectName)/configs/app.xcconfig"),
                .release(name: "release", xcconfig: "\(projectName)/configs/app.xcconfig"),
            ])
        )
    ]
)
