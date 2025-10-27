// Created by kieraj_mumick on 7/26/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import QuartzCore

/// A CALayer that uses the new glass highlight effect in iOS 26.
///
/// This is the effect that powers the highlights on Apple's Liquid Glass views.
///
/// The layer hierarchy of this layer is:
/// - sdfLayer: CASDFLayer
///   - sdfElementLayer: CASDFElementLayer
class _GlassHighlightEffectLayer: CALayer {
  required init?(coder: NSCoder) {
    preconditionFailure("init?(coder:) is unimplemented.")
  }

  override init() {
    super.init()
    setUpGlassHighlightEffectFilter()
    setUpSDFLayer()
    setUpSDFElementLayer()
    setUpLayer()
  }

  override func layoutSublayers() {
    super.layoutSublayers()
    sdfElementLayer.frame = bounds
    sdfLayer.frame = bounds
  }

  // MARK: Internal

  var height: CGFloat {
    get { value(forKeyPath: "sublayers.highlightSDFLayer.effect.height") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.height") }
  }

  var curvature: CGFloat {
    get { value(forKeyPath: "sublayers.highlightSDFLayer.effect.curvature") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.curvature") }
  }

  var angle: CGFloat {
    get { value(forKeyPath: "sublayers.highlightSDFLayer.effect.angle") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.angle") }
  }

  var spread: CGFloat {
    get { value(forKeyPath: "sublayers.highlightSDFLayer.effect.spread") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.spread") }
  }

  var amount: CGFloat {
    get { value(forKeyPath: "sublayers.highlightSDFLayer.effect.amount") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.amount") }
  }

  override var cornerRadius: CGFloat {
    get { sdfElementLayer.cornerRadius }
    set {
      super.cornerRadius = newValue
      sdfElementLayer.cornerRadius = newValue
    }
  }

  var ovalization: CGFloat {
    get { sdfElementLayer.value(forKey: "gradientOvalization") as? CGFloat ?? 0 }
    set { sdfElementLayer.setValue(newValue, forKey: "gradientOvalization") }
  }

  // MARK: Private

  private let sdfElementLayer = CASDFElementLayer()

  private let sdfLayer = CASDFLayer()

  private let glassHighlightEffect = CASDFGlassHighlightEffect()!

  private func setUpLayer() {
    setValue(true, forKey: "windowServerAware")
  }

  private func setUpGlassHighlightEffectFilter() {
    glassHighlightEffect.setValue(CGColor(gray: 1, alpha: 1), forKey: "color")
    glassHighlightEffect.setValue(20, forKey: "height")
    glassHighlightEffect.setValue(1.0, forKey: "curvature")
    glassHighlightEffect.setValue(Double.pi / 2, forKey: "angle")
    glassHighlightEffect.setValue(Double.pi, forKey: "spread")
    glassHighlightEffect.setValue(0.5, forKey: "amount")
    glassHighlightEffect.setValue(false, forKey: "global")
  }

  private func setUpSDFLayer() {
    sdfLayer.setValue(true, forKey: "windowServerAware")
    sdfLayer.name = "highlightSDFLayer"
    sdfLayer.setValue(glassHighlightEffect, forKey: "effect")
    addSublayer(sdfLayer)
  }

  private func setUpSDFElementLayer() {
    sdfElementLayer.setValue(0.5, forKey: "gradientOvalization")
    sdfElementLayer.isOpaque = true
    sdfElementLayer.allowsEdgeAntialiasing = true
    sdfElementLayer.delegate = sdfLayer
    sdfElementLayer.cornerRadius = 40
    sdfLayer.addSublayer(sdfElementLayer)
  }
}

