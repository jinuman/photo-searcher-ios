import ProjectDescription

let projectName: String = "PhotoSearcher"

let targetActions = [
    TargetAction.pre(
        path: "Scripts/RswiftRunScript.sh",
        arguments: [],
        name: "R.Swift",
        inputPaths: [Path("$TEMP_DIR/rswift-lastrun")],
        inputFileListPaths: [],
        outputPaths: [Path("$SRCROOT/Projects/\(projectName)/Resources/R.generated.swift")],
        outputFileListPaths: []
    ),
    TargetAction.post(
        path: "Scripts/SwiftlintRunScript.sh",
        arguments: [],
        name: "SwiftLint"
    )
]

let appTargetSettings = Settings(
    base: [
        "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon-PhotoSearcher",
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)",
        "FLICKR_BASE_URL": "https://api.flickr.com"
    ]
)
let frameworkTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)",
    ]
)
let testsTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)"
    ]
)

let project = Project(
    name: "\(projectName)",
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "com.jinuman.\(projectName)",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: InfoPlist(stringLiteral: "Projects/\(projectName)/Supporting Files/\(projectName)-Info.plist"),
            sources: ["Projects/\(projectName)/Sources/**"],
            resources: ["Projects/\(projectName)/Resources/**"],
            actions: targetActions,
            dependencies: [
                .cocoapods(path: "."),
                .target(name: "\(projectName)Foundation"),
                .target(name: "\(projectName)UI"),
                .target(name: "\(projectName)Networking"),
                .target(name: "\(projectName)Reactive"),
            ],
            settings: appTargetSettings
        ),
        Target(
            name: "\(projectName)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)Tests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)"),
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Foundation",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Foundation",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Foundation/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)FoundationTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)FoundationTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Foundation/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Foundation"),
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)UI",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)UI",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)UI/Sources/**"],
            dependencies: [
                .target(name: "\(projectName)Foundation"),
            ],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)UITests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)UITests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)UI/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)UI"),
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Reactive",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Reactive",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Reactive/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)ReactiveTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)ReactiveTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Reactive/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Reactive"),
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Networking",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Networking",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Networking/Sources/**"],
            dependencies: [
                .target(name: "\(projectName)Foundation"),
            ],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)NetworkingTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)NetworkingTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Networking/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Networking"),
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Test",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Test",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Test/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)TestTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)TestTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Test/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Test"),
            ],
            settings: testsTargetSettings
        ),
    ],
    additionalFiles: [
        "Projects/\(projectName)/Resources/R.generated.swift",
    ]
)
