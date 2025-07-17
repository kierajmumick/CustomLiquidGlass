// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import UIKit
import SwiftUI

/// A view that can be used in SwiftUI that presents an `SDFElementLayer`.
struct SDFElementView: UIViewRepresentable {
  /// The ovalization of the SDF Element Layer.
  ///
  /// This value must be between 0 and 1.
  ///
  /// Apple has this set to 0.5 by default.
  let gradientOvalization: CGFloat

  /// The corner radius of the SDF Element. This value must be set here, not through the normal
  /// `.cornerRadius` view modifier.
  let cornerRadius: CGFloat

  func makeUIView(context: Context) -> _SDFElementView {
    .init()
  }

  func updateUIView(_ uiView: _SDFElementView, context: Context) {
    guard let layer = uiView.layer as? CASDFElementLayer else { return }

    layer.setValue(gradientOvalization, forKey: "gradientOvalization")
    layer.cornerRadius = cornerRadius
    layer.isOpaque = true
    layer.allowsEdgeAntialiasing = true
  }
}

/// A UIView that is backed by the `SDFElementLayer`.
class _SDFElementView: UIView {
  override class var layerClass: AnyClass { CASDFElementLayer.self }
}
