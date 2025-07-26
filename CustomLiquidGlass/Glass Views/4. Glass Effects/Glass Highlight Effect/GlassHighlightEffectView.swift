// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI
import UIKit

struct GlassHighlightEffectView: UIViewRepresentable {
  let ovalization: CGFloat
  let height: CGFloat
  let curvature: CGFloat
  let angle: CGFloat
  let spread: CGFloat
  let amount: CGFloat
  let cornerRadius: CGFloat

  func makeUIView(context: Context) -> _GlassHighlightEffectView {
    _GlassHighlightEffectView(frame: .zero)
  }

  func updateUIView(_ uiView: _GlassHighlightEffectView, context: Context) {
    uiView.ovalization = ovalization
    uiView.cornerRadius = cornerRadius

    uiView.height = height
    uiView.curvature = curvature
    uiView.angle = angle
    uiView.spread = spread
    uiView.amount = amount
  }
}
