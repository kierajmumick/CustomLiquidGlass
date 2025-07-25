// Created by kieraj_mumick on 7/25/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI
import UIKit

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
    uiView.cornerRadius = cornerRadius

    context.animate {
      uiView.ovalization = ovalization
      uiView.curvature = curvature
      uiView.angle = angle
      uiView.intensity = intensity
      uiView.height = height
    }
  }
}

class _GlassChromaticAberrationEffectView: UIView {

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

  var cornerRadius: CGFloat = 0 {
    didSet {
      sdfElementLayer.cornerRadius = cornerRadius
      sdfLayer.cornerRadius = cornerRadius
    }
  }

  var intensity: CGFloat {
    get { layer.value(forKeyPath: "filters.chromaticAberrationMap.inputAmount") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "filters.chromaticAberrationMap.inputAmount")}
  }

  var ovalization: CGFloat {
    get { sdfElementLayer.value(forKey: "gradientOvalization") as? CGFloat ?? 0 }
    set { sdfElementLayer.setValue(newValue, forKey: "gradientOvalization") }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setUpGlassDisplacementEffect()
    setUpSDFLayer()
    setUpSDFElementLayer()
    setUpChromaticAberrationMap()
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
  private let chromaticAberrationFilter = CAFilter(type: "chromaticAberrationMap")!

  private func setUpLayer() {
    layer.setValue(true, forKey: "windowServerAware")
    layer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    layer.filters = [
      chromaticAberrationFilter,
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

  private func setUpChromaticAberrationMap() {
    chromaticAberrationFilter.setName("chromaticAberrationMap")
    chromaticAberrationFilter.setValue("sdfLayer", forKey: "inputSourceSublayerName")
  }
}
