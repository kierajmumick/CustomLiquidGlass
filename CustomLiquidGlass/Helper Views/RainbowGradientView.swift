// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct RainbowGradientView: View {
  var body: some View {
    Rectangle()
      .fill(
        AngularGradient(
          gradient: Gradient(colors: [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .indigo,
            .purple
          ]),
          center: .center,
        )
      )
  }
}

#Preview {
  RainbowGradientView()
}
