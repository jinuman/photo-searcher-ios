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
        "API_BASE_URL": "https://api.flickr.com"
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
    name: "PhotoSearcher",
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
    ],
    additionalFiles: [
        "\(projectName)/Resources/R.generated.swift",
    ]
)
