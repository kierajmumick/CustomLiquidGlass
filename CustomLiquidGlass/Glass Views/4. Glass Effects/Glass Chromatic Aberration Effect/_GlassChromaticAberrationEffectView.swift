// Created by kieraj_mumick on 7/26/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import UIKit

class _GlassChromaticAberrationEffectView: UIView {

  var intensity: CGFloat {
    get { castedLayer.intensity }
    set { castedLayer.intensity = newValue }
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

  var cornerRadius: CGFloat {
    get { castedLayer.cornerRadius }
    set { castedLayer.cornerRadius = newValue }
  }

  var ovalization: CGFloat {
    get { castedLayer.ovalization }
    set { castedLayer.ovalization = newValue }
  }

  override class var layerClass: AnyClass { _GlassChromaticAberrationEffectLayer.self }

  private var castedLayer: _GlassChromaticAberrationEffectLayer {
    layer as! _GlassChromaticAberrationEffectLayer
  }
}

