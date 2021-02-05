import ProjectDescription

let targetActions = [
    TargetAction.pre(
        path: "Scripts/SwiftLintRunScript.sh",
        arguments: [],
        name: "SwiftLint"
    ),
    TargetAction.pre(
        path: "Scripts/RSwiftRunScript.sh",
        arguments: [],
        name: "R.Swift",
        inputPaths: [Path.init("$TEMP_DIR/rswift-lastrun")],
        inputFileListPaths: [],
        outputPaths: [Path.init("$SRCROOT/TuistSample/Sources/R.generated.swift")],
        outputFileListPaths: []
    )
]

let targetSettings = Settings(
    base: [
        "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon-PhotoSearcher"
    ]
)

let project = Project(
    name: "PhotoSearcher",
    targets: [
        Target(
            name: "PhotoSearcher",
            platform: .iOS,
            product: .app,
            bundleId: "com.jinuman.PhotoSearcher",
            infoPlist: "PhotoSearcher/Supporting Files/PhotoSearcher-Info.plist",
            sources: ["PhotoSearcher/Sources/**"],
            resources: ["PhotoSearcher/Resources/**"],
            dependencies: [
                .cocoapods(path: ".")
            ],
            settings: targetSettings
        ),
        Target(
            name: "PhotoSearcherTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.PhotoSearcherTests",
            infoPlist: "PhotoSearcherTests/Info.plist",
            sources: ["PhotoSearcherTests/**"],
            dependencies: [
                .target(name: "PhotoSearcher")
            ]
        )
    ],
    additionalFiles: [
        "PhotoSearcher/Resources/R.generated.swift"
    ]
)
