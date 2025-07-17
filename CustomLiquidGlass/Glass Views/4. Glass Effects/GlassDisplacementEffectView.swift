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


class _GlassDisplacementEffectView: UIView {
  var height: CGFloat {
    get { layer.value(forKeyPath: "sublayers.sdfLayer.effect.height") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.sdfLayer.effect.height") }
  }

  var curvature: CGFloat {
    get { layer.value(forKeyPath: "sublayers.sdfLayer.effect.curvature") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.sdfLayer.effect.curvature") }
  }

  var angle: CGFloat {
    get { layer.value(forKeyPath: "sublayers.sdfLayer.effect.angle") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "sublayers.sdfLayer.effect.angle") }
  }

  var blur: CGFloat {
    get { layer.value(forKeyPath: "filters.blur.inputRadius") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "filters.blur.inputRadius") }
  }

  var brightness: CGFloat {
    get { layer.value(forKeyPath: "filters.colorBrightness.inputAmount") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "filters.colorBrightness.inputAmount") }
  }

  var cornerRadius: CGFloat = 0 {
    didSet {
      sdfElementLayer.cornerRadius = cornerRadius
      sdfLayer.cornerRadius = cornerRadius
    }
  }

  var displacement: CGFloat {
    get { layer.value(forKeyPath: "filters.displacementMap.inputAmount") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "filters.displacementMap.inputAmount")}
  }

  var ovalization: CGFloat {
    get { sdfElementLayer.value(forKey: "gradientOvalization") as? CGFloat ?? 0 }
    set { sdfElementLayer.setValue(newValue, forKey: "gradientOvalization") }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setUpBlurFilter()
    setUpColorBrightnessFilter()
    setUpGlassDisplacementEffect()
    setUpSDFLayer()
    setUpSDFElementLayer()
    setUpDisplacementFilter()
    setUpLayer()
  }

  required init?(coder: NSCoder) {
    preconditionFailure("init?(coder:) is not supported.")
  }

  override class var layerClass: AnyClass { CABackdropLayer.self }

  override func layoutSubviews() {
    super.layoutSubviews()
    sdfLayer.frame = bounds
    sdfElementLayer.frame = bounds
  }

  /// The layer that holds the SDF Texture for the SDF layer to use.
  ///
  /// This is used by the SDF layer to create the glass displacement effect.
  private let sdfElementLayer = CASDFElementLayer()

  /// The layer that ultimately serves as the displacement map for the displacement filter.
  private let sdfLayer = CASDFLayer()

  /// The displacement effect that controls the height and curvature of the glass, and the angle
  /// of the viewer when viewing the glass.
  private let displacementEffect = CASDFGlassDisplacementEffect()!

  /// The CAFilter that applies the liquid glass effect from a displacement map.
  ///
  /// The displacement map comes from `sdfLayer`.
  private let displacementFilter = CAFilter(type: "displacementMap")!

  /// The CAFilter that applies the blur effect.
  private let blurFilter = CAFilter(type: "gaussianBlur")!

  /// The CAFilter that applies the color brightness effect.
  private let colorBrightnessFilter = CAFilter(type: "colorBrightness")!

  private func setUpLayer() {
    layer.setValue(true, forKey: "windowServerAware")
    layer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    layer.filters = [
      blurFilter,
      colorBrightnessFilter,
      displacementFilter,
    ]
  }

  private func setUpGlassDisplacementEffect() {
    displacementEffect.setValue(height, forKey: "height")
    displacementEffect.setValue(curvature, forKey: "curvature")
    displacementEffect.setValue(angle, forKey: "angle")
  }

  private func setUpSDFLayer() {
    sdfLayer.setValue(true, forKey: "windowServerAware")
    sdfLayer.name = "sdfLayer"
    sdfLayer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    sdfLayer.setValue(displacementEffect, forKey: "effect")
    layer.addSublayer(sdfLayer)
  }

  private func setUpSDFElementLayer() {
    sdfElementLayer.setValue(10, forKey: "gradientOvalization")
    sdfElementLayer.isOpaque = true
    sdfElementLayer.allowsEdgeAntialiasing = true
    sdfElementLayer.delegate = sdfLayer
    sdfElementLayer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    sdfLayer.addSublayer(sdfElementLayer)
  }

  private func setUpBlurFilter() {
    blurFilter.setName("blur")
    blurFilter.setValue(true, forKey: "inputNormalizeEdges")
    blurFilter.setValue(blur, forKey: "inputRadius")
  }

  private func setUpColorBrightnessFilter() {
    colorBrightnessFilter.setName("colorBrightness")
    colorBrightnessFilter.setValue(brightness, forKey: "inputAmount")
  }

  private func setUpDisplacementFilter() {
    displacementFilter.setName("displacementMap")
    displacementFilter.setValue("sdfLayer", forKey: "inputSourceSublayerName")
  }
}
