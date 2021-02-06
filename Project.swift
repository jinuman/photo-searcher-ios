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
    path: "Scripts/SwiftformatRunScript.sh",
    arguments: [],
    name: "SwiftFormat"
  ),
  TargetAction.post(
    path: "Scripts/SwiftlintRunScript.sh",
    arguments: [],
    name: "SwiftLint"
  ),
]

let targetSettings = Settings(
  base: [
    "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon-PhotoSearcher",
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
      actions: targetActions,
      dependencies: [
        .cocoapods(path: "."),
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
        .target(name: "PhotoSearcher"),
      ]
    ),
  ],
  additionalFiles: [
    "PhotoSearcher/Resources/R.generated.swift",
  ]
)
