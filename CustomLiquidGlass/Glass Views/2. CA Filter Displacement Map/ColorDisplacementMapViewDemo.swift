// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct DisplacementFilterDemo: View {
  var body: some View {
    NavigationStack {
      VStack {
        ZStack {
          ZStack {
            ArbitraryLetterGridView()
            ColorDisplacementMapView(
              inputAmount: inputAmount,
              xOffset: xOffset,
              yOffset: yOffset
            )
            .frame(width: 155, height: 155)
          }
          .offset(x: -175.0 / 2)

          Color(
            red: xOffset,
            green: yOffset,
            blue: 0.9,
            opacity: 1)
            .frame(width: 155, height: 155)
            .offset(x: 175.0 / 2 + 20)
        }

        VStack {
          VStack(alignment: .leading) {
            Text("Amount")
            Slider(value: $inputAmount, in: -100...100) {
              Text("Amount")
            } minimumValueLabel: {
              Text("-100")
            } maximumValueLabel: {
              Text("100")
            }
          }

          VStack(alignment: .leading) {
            HStack {
              Text("X-Offset")
              Spacer()
              Text("\(xOffset)")
            }
            Slider(value: $xOffset, in: 0...1) {
              Text("X-Offset")
            } minimumValueLabel: {
              Text("0")
            } maximumValueLabel: {
              Text("1")
            }
          }

          VStack(alignment: .leading) {
            HStack {
              Text("Y-Offset")
              Spacer()
              Text("\(yOffset)")
            }
            Slider(value: $yOffset, in: 0...1) {
              Text("Y-Offset")
            } minimumValueLabel: {
              Text("0")
            } maximumValueLabel: {
              Text("1")
            }
          }
        }
        .padding(.horizontal, 24)
      }
      .frame(maxHeight: .infinity)
      .background(.white)
    }
  }

  @State private var inputAmount = 0.0
  @State private var xOffset = 0.0
  @State private var yOffset = 0.0
}

#Preview {
  DisplacementFilterDemo()
}
