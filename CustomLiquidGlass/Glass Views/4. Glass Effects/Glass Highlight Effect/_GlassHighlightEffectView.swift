// Created by kieraj_mumick on 7/26/25.
// Copyright © 2025 Airbnb Inc. All rights reserved.

import UIKit

/// A UIView that wraps `_GlassHighlightEffectLayer`
class _GlassHighlightEffectView: UIView {

  // MARK: Internal

  var ovalization: CGFloat {
    get { castedLayer.ovalization }
    set { castedLayer.ovalization = newValue }
  }

  var cornerRadius: CGFloat {
    get { castedLayer.cornerRadius }
    set { castedLayer.cornerRadius = newValue }
  }

  var height: CGFloat {
    get { castedLayer.height }
    set { castedLayer.height = newValue }
  }

  var curvature: CGFloat {
    get { castedLayer.curvature }
    set { castedLayer.curvature = newValue }
  }

  var angle: CGFloat {
    get { castedLayer.angle }
    set { castedLayer.angle = newValue }
  }

  var spread: CGFloat {
    get { castedLayer.spread }
    set { castedLayer.spread = newValue }
  }

  var amount: CGFloat {
    get { castedLayer.amount }
    set { castedLayer.amount = newValue }
  }

  override class var layerClass: AnyClass { _GlassHighlightEffectLayer.self }

  // MARK: Private

  private var castedLayer: _GlassHighlightEffectLayer {
    layer as! _GlassHighlightEffectLayer
  }
}
