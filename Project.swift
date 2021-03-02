import ProjectDescription

let targetActions = [
    TargetAction.pre(
        path: "Scripts/RswiftRunScript.sh",
        arguments: [],
        name: "R.Swift",
        inputPaths: [Path("$TEMP_DIR/rswift-lastrun")],
        inputFileListPaths: [],
        outputPaths: [Path("$SRCROOT/PhotoSearcher/Resources/R.generated.swift")],
        outputFileListPaths: []
    ),
    TargetAction.post(
        path: "Scripts/SwiftlintRunScript.sh",
        arguments: [],
        name: "SwiftLint"
    ),
//    TargetAction.post(
//        path: "Scripts/SwiftformatRunScript.sh",
//        arguments: [],
//        name: "SwiftFormat"
//    ),
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

let projectName: String = "PhotoSearcher"

let project = Project(
    name: "\(projectName)",
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "com.jinuman.\(projectName)",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone),
            infoPlist: InfoPlist(stringLiteral: "\(projectName)/Supporting Files/\(projectName)-Info.plist"),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"],
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
            sources: ["\(projectName)/Tests/**"],
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
            sources: ["\(projectName)Foundation/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)FoundationTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)FoundationTests",
            infoPlist: .default,
            sources: ["\(projectName)Foundation/Tests/**"],
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
            sources: ["\(projectName)UI/Sources/**"],
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
            sources: ["\(projectName)UI/Tests/**"],
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
            sources: ["\(projectName)Reactive/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)ReactiveTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)ReactiveTests",
            infoPlist: .default,
            sources: ["\(projectName)Reactive/Tests/**"],
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
            sources: ["\(projectName)Networking/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)NetworkingTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)NetworkingTests",
            infoPlist: .default,
            sources: ["\(projectName)Networking/Tests/**"],
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
            sources: ["\(projectName)Test/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)TestTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)TestTests",
            infoPlist: .default,
            sources: ["\(projectName)Test/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Test"),
            ],
            settings: testsTargetSettings
        ),
    ],
    additionalFiles: [
        "\(projectName)/Resources/R.generated.swift",
    ]
)
