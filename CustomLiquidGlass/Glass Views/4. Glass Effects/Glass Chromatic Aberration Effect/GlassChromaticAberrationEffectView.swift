// Created by kieraj_mumick on 7/25/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

/// A SwiftUI View that creates a chromatic aberration effect from the view behind it.
///
/// In the implementation of Liquid Glass, this is responsible for some of the chromatic aberration
/// effects that can be seen in some places.
struct GlassChromaticAberrationEffectView: UIViewRepresentable {
  /// The ovalization of the SDF Element Layer
  let ovalization: CGFloat

  /// The height of the glass that we're mimicing.
  let height: CGFloat

  /// The curvature of the glass that we're mimicing. This value must be between 0 and 1, where
  /// 0 represents no curvature (i.e., a perfect bezel), and 1 represents perfect curvature (i.e.,
  /// perfectly rounded edges).
  let curvature: CGFloat

  /// The angle that the user is looking at the glass.
  let angle: CGFloat

  /// The intensity of the chromatic aberration effect.
  let intensity: CGFloat

  /// The corner radius of the view as viewed by the user.
  let cornerRadius: CGFloat

  func makeUIView(context: Context) -> _GlassChromaticAberrationEffectView {
    _GlassChromaticAberrationEffectView(frame: .zero)
  }

  func updateUIView(_ uiView: _GlassChromaticAberrationEffectView, context: Context) {
    context.animate {
      uiView.cornerRadius = cornerRadius
      uiView.ovalization = ovalization
      uiView.curvature = curvature
      uiView.angle = angle
      uiView.intensity = intensity
      uiView.height = height
    }
  }
}
