// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import UIKit
import SwiftUI

/// A view that has two states: a resting state and a "lifted" state.
///
/// This view is meant to be used in situations where you want to cleanly animate between a solid
/// view that doesn't distract the user with glassing and lensing when they're scrolling or
/// interacting with other onscreen elements, but turns into glass when a user starts interacting
/// with the view.
struct LiquidLensView: UIViewRepresentable {
  /// Whether or not the liquid lens view has been "lifted" or not.
  ///
  /// When its not lifted, the lens shows itself in its "resting" state. The resting state has no
  /// lensing, and just shows a background view or background color. This is useful when you don't
  /// want to display the lens when a user isn't interacting with it.
  ///
  /// When it is lifted, the lens transforms from whatever view is shown in the "resting" state into
  /// the "glassy" state.
  let isLifted: Bool

  /// True if this view warps the content below it.
  ///
  /// Note that warping is not the same concept as lensing. Whether the view is lifted
  /// and lensed, setting this to true will warp the content behind it.
  let warpsContentBelow: Bool

  /// The color the background should be when the lens is in its "Resting" state.
  let restingBackgroundColor: Color

  /// Unclear what this does at the moment. AFAICT, this is having no effect.
  let useGlassWhenResting: Bool

  func makeUIView(context: Context) -> some UIView {
    let _UILiquidLensView = NSClassFromString("_UILiquidLensView") as AnyObject as? NSObjectProtocol
    let allocSelector = NSSelectorFromString("alloc")
    let initSelector = NSSelectorFromString("initWithFrame:")

    guard let _UILiquidLensView else {
      preconditionFailure("Could not load _UILiquidLensView")
    }

    let objcAlloc = _UILiquidLensView.perform(allocSelector).takeUnretainedValue()
    let instance = objcAlloc.perform(initSelector, with: NSValue(cgRect: .zero)).takeUnretainedValue()

    let lens = instance as! UIView
    lens.backgroundColor = .clear

    let setLifted = NSSelectorFromString("setLifted:")
    callObjcBoolMethod(lens, setLifted, false)

    return lens
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    let setLifted = NSSelectorFromString("setLifted:")
    let setWarpsContentBelow = NSSelectorFromString("setWarpsContentBelow:")
    let setUseGlassWhenResting = NSSelectorFromString("setUseGlassWhenResting:")
    let updateRestingBackgroundView = NSSelectorFromString("updateRestingBackgroundView")

    uiView.setValue(UIColor(restingBackgroundColor), forKey: "restingBackgroundColor")
    callObjcBoolMethod(uiView, setWarpsContentBelow, warpsContentBelow)
    callObjcBoolMethod(uiView, setLifted, isLifted)
    callObjcBoolMethod(uiView, setUseGlassWhenResting, useGlassWhenResting)

    uiView.perform(updateRestingBackgroundView)
    uiView.setNeedsLayout()
  }

  private func callObjcBoolMethod(_ object: AnyObject, _ selector: Selector, _ value: Bool) {
    typealias ObjCMethod = @convention(c) (AnyObject, Selector, Bool) -> Void
    if let method = object.method(for: selector) {
      let function = unsafeBitCast(method, to: ObjCMethod.self)
      function(object, selector, value)
    }
  }
}
