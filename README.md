# DraggableScreenCover

A lightweight SwiftUI modifier that presents a full-screen, draggable-style cover using NavigationStack transitions. It supports two presentation styles:

- Simple draggable cover with built-in matched source (no setup required)
- Identifier-based matched transition using your own `matchedTransitionSource(id:in:)`

This package is designed for iOS 18+ and leverages modern SwiftUI navigation transitions. It can be used as a drop-in replacement for some full screen cover or sheet experiences where you want a draggable header affordance and a smooth zoom transition.

## Features

- Two APIs: with and without a matched transition source ID
- Smooth zoom transition powered by `navigationTransition(.zoom)`
- Optional background color customization
- Built-in header drag handle area with tap-to-dismiss
- Works with your own `@Namespace` and `matchedTransitionSource` for source ↔ destination animations

## Requirements

- iOS 18.0+
- Swift 6.2+
- SwiftUI

## Installation

This repository is a Swift Package.

1. In Xcode: File > Add Packages…
2. Enter the repository URL of this package
3. Add the `DraggableScreenCover` product to your app target

Or in `Package.swift`:

```swift
.package(url: "https://github.com/hidaken/DraggableScreenCover.git", from: "1.0.0")
```

## Usage (Reference: DraggableCoverDemoView.swift)

The file `DraggableCoverDemoView.swift` in the project contains examples for both with-ID and without-ID usage, as well as comparison code using `fullScreenCover` and `sheet`. Start by reviewing that file to see the minimal setup and how transitions differ when using `matchedTransitionSource(id:in:)`.

- Simple usage (no ID): `draggableScreenCover(isPresented:){ ... }`
- Matched transition (with ID): `draggableScreenCover(isPresented: sourceId:in:){ ... }`
- For comparison: equivalent UI shown with `fullScreenCover` and `sheet`

```swift
// Simple draggable cover
.draggableScreenCover(isPresented: $showDraggableCover) {
    DemoCoverView()
}

// With matched source
.draggableScreenCover(
    isPresented: $showDraggableCoverWithID,
    sourceId: sourceId, in: namespace
) {
    DemoCoverView()
}

// System baselines for comparison
.fullScreenCover(isPresented: $showFullScreenCover) { DemoCoverView() }
.sheet(isPresented: $showNormalCover) { DemoCoverView() }
