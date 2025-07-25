// Created by kieraj_mumick on 7/25/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct GlassChromaticAberrationViewDemo: View {
  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        ScrollView {
          VStack(spacing: 0) {
            Image(.banff)
              .resizable()
              .ignoresSafeArea()
              .aspectRatio(contentMode: .fit)
              .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.size.height
              } action: { newValue in
                self.imageHeight = newValue
              }

            Image(.banff)
              .resizable()
              .ignoresSafeArea()
              .aspectRatio(contentMode: .fit)
              .transformEffect(.init(scaleX: 1, y: -1))
              .transformEffect(.init(translationX: 0, y: imageHeight))

            Image(.banff)
              .resizable()
              .ignoresSafeArea()
              .aspectRatio(contentMode: .fit)
          }
          .frame(maxWidth: .infinity)
        }
        .overlay(alignment: .bottom) {
          VStack(alignment: .leading) {
            HStack {
              Text("Ovalization")
              Spacer()
              Text("\(ovalization)")
            }
            Slider(value: $ovalization, in: 0...5)

            HStack {
              Text("Height")
              Spacer()
              Text("\(height)")
            }
            Slider(value: $height, in: 0...100)

            HStack {
              Text("Curvature")
              Spacer()
              Text("\(curvature)")
            }
            Slider(value: $curvature, in: 0...1)

            HStack {
              Text("Angle")
              Spacer()
              Text("\(angle / Double.pi)π")
            }
            Slider(value: $angle, in: 0...Double.pi * 2 * 10)

            HStack {
              Text("Intensity")
              Spacer()
              Text("\(intensity)")
            }
            Slider(value: $intensity, in: 0...200)

            HStack {
              Text("Corner Radius")
              Spacer()
              Text("\(cornerRadius)")
            }
            Slider(value: $cornerRadius, in: 0...100)
          }
          .padding(24)
          .frame(maxWidth: .infinity)
          .glassEffect(.regular, in: .rect(cornerRadius: 48))
          .padding(12)
        }
        .ignoresSafeArea()


        GlassChromaticAberrationEffectView(
          ovalization: ovalization,
          height: height,
          curvature: curvature,
          angle: angle,
          intensity: intensity,
          cornerRadius: cornerRadius
        )
        .frame(width: 200, height: 200)
        .offset(x: offset.width, y: offset.height)
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
      .frame(maxHeight: .infinity, alignment: .top)
      .background(.white)
    }
  }

  @State private var height: CGFloat = 20.0
  @State private var curvature: CGFloat = 1
  @State private var angle: CGFloat = 0.0
  @State private var intensity: CGFloat = 150
  @State private var cornerRadius: CGFloat = 40
  @State private var ovalization: CGFloat = 0.5

  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero

  @State private var imageHeight: CGFloat = 0.0

}

#Preview {
  GlassChromaticAberrationViewDemo()
}
