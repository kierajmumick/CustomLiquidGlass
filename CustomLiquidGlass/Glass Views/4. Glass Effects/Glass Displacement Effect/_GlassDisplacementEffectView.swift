// Created by kieraj_mumick on 7/26/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import UIKit

class _GlassDisplacementEffectView: UIView {
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

  var blur: CGFloat {
    get { castedLayer.blur }
    set { castedLayer.blur = newValue }
  }

  var brightness: CGFloat {
    get { castedLayer.brightness }
    set { castedLayer.brightness = newValue }
  }

  var cornerRadius: CGFloat {
    get { castedLayer.cornerRadius }
    set { castedLayer.cornerRadius = newValue }
  }

  var displacement: CGFloat {
    get { castedLayer.displacement }
    set { castedLayer.displacement = newValue }
  }

  var ovalization: CGFloat {
    get { castedLayer.ovalization }
    set { castedLayer.ovalization = newValue }
  }

  override class var layerClass: AnyClass { _GlassDisplacementEffectLayer.self }

  // MARK: Private

  private var castedLayer: _GlassDisplacementEffectLayer {
    layer as! _GlassDisplacementEffectLayer
  }
}
