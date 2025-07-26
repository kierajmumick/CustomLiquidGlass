// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import UIKit
import SwiftUI

/// A SwiftUI View that warps the content below it using a glass displacement filter.
///
/// In the implementation of Liquid Glass, this is responsible for the warping of the content
/// behind the glass.
///
/// In addition to the glass effect, a blur filter and a brightness filter are also modifiable
/// in this layer.
struct GlassDisplacementEffectView: UIViewRepresentable {
  let ovalization: CGFloat
  let height: CGFloat
  let curvature: CGFloat
  let angle: CGFloat
  let inputAmount: CGFloat
  let blur: CGFloat
  let brightness: CGFloat
  let cornerRadius: CGFloat

  func makeUIView(context: Context) -> _GlassDisplacementEffectView {
    _GlassDisplacementEffectView(frame: .zero)
  }

  func updateUIView(_ uiView: _GlassDisplacementEffectView, context: Context) {
    context.animate {
      uiView.cornerRadius = cornerRadius
      uiView.blur = blur
      uiView.brightness = brightness
      uiView.displacement = inputAmount
      uiView.ovalization = ovalization
      uiView.height = height
      uiView.angle = angle
      uiView.curvature = curvature
    }
  }
}
