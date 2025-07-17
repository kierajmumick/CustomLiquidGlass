// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI
import UIKit

#Preview {
  // Gradient ovalization is set to 0.5 according to a swizzle of
  // didChangeValueForKey
  @Previewable @State var gradientOvalization: CGFloat = 0.5
  @Previewable @State var cornerRadius: CGFloat = 0.0

  VStack {
    SDFElementView(
      gradientOvalization: gradientOvalization,
      cornerRadius: cornerRadius)
    .cornerRadius(cornerRadius)

    VStack {
      VStack(alignment: .leading) {
        Text("Gradient Ovalization")
        Slider(value: $gradientOvalization, in: 0...1)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      VStack(alignment: .leading) {
        Text("Corner Radius")
        Slider(value: $cornerRadius, in: 0...340)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  .padding(.horizontal, 24)
}
