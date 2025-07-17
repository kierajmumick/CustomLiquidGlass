// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI
import UIKit

/// A view that generates a displacement map that is used to warp the layer beneath it, which gives
/// the glass "warping" effect.
struct GlassDisplacementEffectDisplacementMapView: UIViewRepresentable {
  /// The ovalization of the SDF Element Layer.
  ///
  /// This value must be between 0 and 1.
  ///
  /// Apple has this set to 0.5 by default.
  let ovalization: CGFloat

  /// How high above the backing layer the glass should be simulated to be.
  let height: CGFloat

  /// How perfectly curved the corners are. This value must be between 0 and 1. A value of 1
  /// represents perfectly rounded edges. A value of 0 represents chamfered edges.
  let curvature: CGFloat

  /// The angle that an observer is looking through this glass. This changes the direction in which
  /// warping happens. This is in radians.
  let angle: CGFloat

  /// How much displacement should happen. The larger the value, the more intense the displacement.
  let inputAmount: CGFloat

  /// The corner radius of the SDF Element. This value must be set here, not through the normal
  /// `.cornerRadius` view modifier.
  let cornerRadius: CGFloat

  func makeUIView(context: Context) -> _GlassDisplacementEffectDisplacementMapView {
    _GlassDisplacementEffectDisplacementMapView(frame: .zero)
  }

  func updateUIView(_ uiView: _GlassDisplacementEffectDisplacementMapView, context: Context) {
    uiView.cornerRadius = cornerRadius
    uiView.displacement = inputAmount
    uiView.ovalization = ovalization
    uiView.height = height
    uiView.angle = angle
    uiView.curvature = curvature
  }
}

class _GlassDisplacementEffectDisplacementMapView: UIView {

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

    setUpGlassDisplacementEffect()
    setUpSDFLayer()
    setUpSDFElementLayer()
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

  private func setUpLayer() {
    layer.setValue(true, forKey: "windowServerAware")
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

    layer.addSublayer(sdfLayer)
  }

  private func setUpSDFElementLayer() {
    sdfElementLayer.setValue(10, forKey: "gradientOvalization")
    sdfElementLayer.isOpaque = true
    sdfElementLayer.allowsEdgeAntialiasing = true
    sdfElementLayer.delegate = sdfLayer
    sdfLayer.addSublayer(sdfElementLayer)
  }

}
