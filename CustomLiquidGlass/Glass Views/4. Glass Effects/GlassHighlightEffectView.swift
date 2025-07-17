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
    uiView.height = height
    uiView.curvature = curvature
    uiView.angle = angle
    uiView.spread = spread
    uiView.amount = amount
    uiView.cornerRadius = cornerRadius
  }
}

class _GlassHighlightEffectView: UIView {

  var height: CGFloat {
    get { layer.value(forKeyPath: "sublayers.highlightSDFLayer.effect.height") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.height") }
  }

  var curvature: CGFloat {
    get { layer.value(forKeyPath: "sublayers.highlightSDFLayer.effect.curvature") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.curvature") }
  }

  var angle: CGFloat {
    get { layer.value(forKeyPath: "sublayers.highlightSDFLayer.effect.angle") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.angle") }
  }

  var spread: CGFloat {
    get { layer.value(forKeyPath: "sublayers.highlightSDFLayer.effect.spread") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.spread") }
  }

  var amount: CGFloat {
    get { layer.value(forKeyPath: "sublayers.highlightSDFLayer.effect.amount") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.highlightSDFLayer.effect.amount") }
  }

  var cornerRadius: CGFloat {
    get { sdfElementLayer.cornerRadius }
    set { sdfElementLayer.cornerRadius = newValue }
  }

  var ovalization: CGFloat {
    get { sdfElementLayer.value(forKey: "gradientOvalization") as? CGFloat ?? 0 }
    set { sdfElementLayer.setValue(newValue, forKey: "gradientOvalization") }
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpGlassHighlightEffectFilter()
    setUpSDFLayer()
    setUpSDFElementLayer()
    setUpLayer()
  }

  required init?(coder: NSCoder) {
    preconditionFailure("Not implemented")
  }

  private let sdfElementLayer = CASDFElementLayer()

  private let sdfLayer = CASDFLayer()

  private let glassHighlightEffect = CASDFGlassHighlightEffect()!

  override class var layerClass: AnyClass { CABackdropLayer.self }

  override func layoutSubviews() {
    super.layoutSubviews()
    sdfLayer.frame = bounds
    sdfElementLayer.frame = bounds
  }

  private func setUpGlassHighlightEffectFilter() {
    glassHighlightEffect.setValue(Color.white.cgColor, forKey: "color")
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
    sdfLayer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    layer.addSublayer(sdfLayer)
  }

  private func setUpSDFElementLayer() {
    sdfElementLayer.setValue(0.5, forKey: "gradientOvalization")
    sdfElementLayer.isOpaque = true
    sdfElementLayer.allowsEdgeAntialiasing = true
    sdfElementLayer.delegate = sdfLayer
    sdfElementLayer.cornerRadius = 40
    sdfElementLayer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    sdfLayer.addSublayer(sdfElementLayer)
  }


  private func setUpLayer() {
    layer.setValue(true, forKey: "windowServerAware")
    layer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    layer.filters = [ ]
  }
}
