// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import UIKit
import SwiftUI

/// A view that uses an image as a displacement map for the content thats behind it.
struct ImageDisplacementMapView: UIViewRepresentable {
  /// The image to use as a displacement map.
  ///
  /// In this image, each pixel's red, green, and blue values correspond to:
  /// - R: how much to displace in the x-direction.
  /// - G: how much to displace in the y-direction.
  /// - B: the alpha value of the displaced image.
  let image: ImageResource

  /// How intense the distortion should be.
  let inputAmount: CGFloat

  func makeUIView(context: Context) -> _ImageDisplacementMapView {
    _ImageDisplacementMapView(frame: .zero)
  }

  func updateUIView(_ uiView: _ImageDisplacementMapView, context: Context) {
    uiView.displacement = inputAmount
    uiView.image = image
  }
}

class _ImageDisplacementMapView: UIView {
  var image: ImageResource? {
    didSet { updateDisplacementMapLayer() }
  }

  var displacement: CGFloat {
    get { layer.value(forKeyPath: "filters.displacementMap.inputAmount") as? CGFloat ?? 0 }
    set { layer.setValue(newValue, forKeyPath: "filters.displacementMap.inputAmount")}
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
    displacementMapLayer.setValue(window?.windowScene?.screen.scale ?? 1, forKey: "scale")
    updateDisplacementMapLayer()
    layer.addSublayer(displacementMapLayer)
  }

  private func updateDisplacementMapLayer() {
    if let image {
      let cgImage = UIImage(resource: image).cgImage
      displacementMapLayer.contents = cgImage
    }
  }

  private func setUpDisplacementFilter() {
    displacementFilter.setName("displacementMap")
    displacementFilter.setValue("displacementMapLayer", forKey: "inputSourceSublayerName")
  }
}
