// Created by kieraj_mumick on 7/26/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import QuartzCore

class _GlassChromaticAberrationEffectLayer: CABackdropLayer {

  // MARK: Lifecycle

  override init!() {
    super.init()
    setUpGlassDisplacementEffect()
    setUpSDFLayer()
    setUpSDFElementLayer()
    setUpChromaticAberrationMap()
    setUpLayer()
  }

  required init?(coder: NSCoder) {
    preconditionFailure("init?(coder:) is unimplemented.")
  }

  override func layoutSublayers() {
    super.layoutSublayers()
    sdfLayer.frame = bounds
    sdfElementLayer.frame = bounds
  }

  // MARK: Internal

  var height: CGFloat {
    get { value(forKeyPath: "sublayers.sdfLayer.effect.height") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.sdfLayer.effect.height") }
  }

  var curvature: CGFloat {
    get { value(forKeyPath: "sublayers.sdfLayer.effect.curvature") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.sdfLayer.effect.curvature") }
  }

  var angle: CGFloat {
    get { value(forKeyPath: "sublayers.sdfLayer.effect.angle") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "sublayers.sdfLayer.effect.angle") }
  }

  override var cornerRadius: CGFloat {
    get { sdfElementLayer.cornerRadius }

    set {
      sdfElementLayer.cornerRadius = newValue
      sdfLayer.cornerRadius = newValue
      super.cornerRadius = newValue
    }
  }

  var intensity: CGFloat {
    get { value(forKeyPath: "filters.chromaticAberrationMap.inputAmount") as? CGFloat ?? 0 }
    set { setValue(newValue, forKeyPath: "filters.chromaticAberrationMap.inputAmount")}
  }

  var ovalization: CGFloat {
    get { sdfElementLayer.value(forKey: "gradientOvalization") as? CGFloat ?? 0 }
    set { sdfElementLayer.setValue(newValue, forKey: "gradientOvalization") }
  }

  // MARK: Private

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
    setValue(true, forKey: "windowServerAware")
    filters = [
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
    sdfLayer.setValue(displacementEffect, forKey: "effect")
    addSublayer(sdfLayer)
  }

  private func setUpSDFElementLayer() {
    sdfElementLayer.setValue(10, forKey: "gradientOvalization")
    sdfElementLayer.isOpaque = true
    sdfElementLayer.allowsEdgeAntialiasing = true
    sdfElementLayer.delegate = sdfLayer
    sdfLayer.addSublayer(sdfElementLayer)
  }

  private func setUpChromaticAberrationMap() {
    chromaticAberrationFilter.setName("chromaticAberrationMap")
    chromaticAberrationFilter.setValue("sdfLayer", forKey: "inputSourceSublayerName")
  }
}
