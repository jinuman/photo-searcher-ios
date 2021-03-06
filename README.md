Photo Searcher iOS
==================

[![Tuist Badge](https://img.shields.io/badge/powered%20by-Tuist-green.svg?longCache=true)](https://github.com/tuist)

## Introduction

Search photos with keywords from couple of APIs (e.g.Flickr) and able to save into your Photos application.

This is useful when downloading pictures to the simulator.

## Demo

| searching with keyword | scroll and go to detail |
|:-:|:-:|
| ![search-keyword](https://user-images.githubusercontent.com/26243835/110215884-70390280-7eef-11eb-9f47-4f0f09d1b0da.gif) | ![scroll-detail](https://user-images.githubusercontent.com/26243835/110215886-729b5c80-7eef-11eb-894c-47e138bc864d.gif) |


| save into Photos | pinch detail image |
|:-:|:-:|
| ![save](https://user-images.githubusercontent.com/26243835/110215887-73cc8980-7eef-11eb-9f33-02b31cbd1b62.gif) | ![pinch](https://user-images.githubusercontent.com/26243835/110215889-75964d00-7eef-11eb-9361-d6bb78bb25c7.gif)
 |


## Environment

- macOS Big Sur
- Xcode 12
- Swift 5
- iOS 11+
- Flickr API
	- https://www.flickr.com/services/api/

### Optimizations

- [bundler](https://github.com/rubygems/bundler)
- [tuist](https://github.com/tuist/tuist)
- [cocoapods-binary-cache](https://github.com/grab/cocoapods-binary-cache)

### 3rd parties

- RxSwift
- ReactorKit
- SnapKit
- Moya
- Pure and Swinject
- R.swift
- Quick and Nimble

## Installation

```
1. Execute command `make project`

2. Build project and put R.generated.swift file into project.

3. Run the application
```

## License
`photo-searcher-ios` is available under the `MIT license`.  
See the `LICENSE` file for more detail.
