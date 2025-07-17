// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct SDFLayerDemo: View {
  var body: some View {
    NavigationStack {
      Color.white.ignoresSafeArea()
    }
    .background(.white)
    .overlay(alignment: .bottom) {
      VStack {
        VStack(alignment: .leading) {
          HStack {
            Text("SDF Ovalization")
            Spacer()
            Text("\(sdfElementLayerOvalization)")
          }
          Slider(value: $sdfElementLayerOvalization, in: 0...5)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading) {
          HStack {
            Text("Corner Radius")
            Spacer()
            Text("\(cornerRadius)")
          }
          Slider(value: $cornerRadius, in: 0...100)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading) {
          HStack {
            Text("Height")
            Spacer()
            Text("\(height)")
          }
          Slider(value: $height, in: 0...100)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading) {
          HStack {
            Text("Curvature")
            Spacer()
            Text("\(curvature)")
          }
          Slider(value: $curvature, in: 0...1)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading) {
          HStack {
            Text("Angle")
            Spacer()
            Text("\(angle)")
          }
          Slider(value: $angle, in: -(4 * Double.pi)...(4 * Double.pi))
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading) {
          HStack {
            Text("Displacement")
            Spacer()
            Text("\(inputAmount)")
          }
          Slider(value: $inputAmount, in: -200...200)
        }
        .frame(maxWidth: .infinity)
      }
      .padding(.horizontal, 24)
    }
    .overlay(alignment: .top) {
      GlassDisplacementEffectDisplacementMapView(
        ovalization: sdfElementLayerOvalization,
        height: height,
        curvature: curvature,
        angle: angle,
        inputAmount: inputAmount,
        cornerRadius: cornerRadius
      )
      .frame(width: 300, height: 160)
      .padding(.top, 100)
      .offset(
        x: offset.width,
        y: offset.height
      )
      .gesture(
        DragGesture(minimumDistance: 0)
          .onChanged { value in
            offset = CGSize(
              width: lastOffset.width + value.translation.width,
              height: lastOffset.height + value.translation.height
            )
          }
          .onEnded { _ in
            lastOffset = offset
          }
      )
    }
  }

  @State private var sdfElementLayerOvalization = 2.0
  @State private var height = 10.0
  @State private var curvature = 1.0
  @State private var angle = 0.0
  @State private var cornerRadius = 50.0
  @State private var inputAmount = -40.0
  @Environment(\.dismiss) private var dismiss

  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero
}

#Preview {
  SDFLayerDemo()
}
