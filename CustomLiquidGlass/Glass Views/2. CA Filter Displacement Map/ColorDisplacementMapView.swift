// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI
import UIKit

/// A view that dynamically creates a color and uses that color as a displacement map.
struct ColorDisplacementMapView: UIViewRepresentable {
  /// How intense the displacement should be.
  let inputAmount: CGFloat

  /// How much to offset in the x-direction.
  ///
  /// This value gets mapped to the red value of the displacement map's color.
  let xOffset: CGFloat

  /// How much to offset in the y-direction.
  ///
  /// This value gets mapped to the green value of the displacement map's color.
  let yOffset: CGFloat

  func makeUIView(context: Context) -> _ColorDisplacementMapView {
    _ColorDisplacementMapView(frame: .zero)
  }

  func updateUIView(_ uiView: _ColorDisplacementMapView, context: Context) {
    uiView.displacement = inputAmount
    uiView.xOffset = xOffset
    uiView.yOffset = yOffset
  }
}


class _ColorDisplacementMapView: UIView {
  var displacement: CGFloat {
    get { layer.value(forKeyPath: "filters.displacementMap.inputAmount") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "filters.displacementMap.inputAmount")}
  }

  var xOffset: CGFloat = 0.0 {
    didSet { updateDisplacementMapLayer() }
  }

  var yOffset: CGFloat = 0.0 {
    didSet { updateDisplacementMapLayer() }
  }


  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpDisplacementMapLayer()
    setUpDisplacementFilter()
    setUpLayer()
  }

  required init?(coder: NSCoder) {
    preconditionFailure("init?(coder:) is not supported.")
  }

  override class var layerClass: AnyClass { CABackdropLayer.self }

  override func layoutSubviews() {
    super.layoutSubviews()
    displacementMapLayer.frame = bounds
  }

  /// The layer that ultimately serves as the displacement map for the displacement filter.
  private let displacementMapLayer = CALayer()

  /// The CAFilter that applies the liquid glass effect from a displacement map.
  ///
  /// The displacement map comes from `sdfLayer`.
  private let displacementFilter = CAFilter(type: "displacementMap")!

  private func setUpLayer() {
    layer.setValue(true, forKey: "windowServerAware")
    layer.filters = [
      displacementFilter,
    ]
  }

  private func setUpDisplacementMapLayer() {
    displacementMapLayer.name = "displacementMapLayer"
    updateDisplacementMapLayer()
    layer.addSublayer(displacementMapLayer)
  }

  private func updateDisplacementMapLayer() {
    displacementMapLayer.backgroundColor = CGColor(red: xOffset, green: yOffset, blue: 1.0, alpha: 1.0)
  }

  private func setUpDisplacementFilter() {
    displacementFilter.setName("displacementMap")
    displacementFilter.setValue("displacementMapLayer", forKey: "inputSourceSublayerName")
  }
}
