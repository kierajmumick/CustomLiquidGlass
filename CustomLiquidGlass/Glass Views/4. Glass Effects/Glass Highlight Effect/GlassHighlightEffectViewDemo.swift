// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct GlassHighlightEffectViewDemo: View {
  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        HStack(spacing: 0) {
          ForEach(0..<100) { item in
            Rectangle()
              .fill(Color(hue: Double(item) / 100.0, saturation: 1.0, brightness: 1.0))
              .ignoresSafeArea()
          }
        }
        .frame(maxWidth: .infinity)

        GlassHighlightEffectView(
          ovalization: ovalization,
          height: height,
          curvature: curvature,
          angle: angle,
          spread: spread,
          amount: amount,
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
            Text("Spread")
            Spacer()
            Text("\(spread / Double.pi)π")
          }
          Slider(value: $spread, in: 0...2 * Double.pi)

          HStack {
            Text("Amount")
            Spacer()
            Text("\(amount)")
          }
          Slider(value: $amount, in: 0...1)

          HStack {
            Text("Corner Radius")
            Spacer()
            Text("\(cornerRadius)")
          }
          Slider(value: $cornerRadius, in: 0...100)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
      }
    }
  }

  @State private var height: CGFloat = 20.0
  @State private var curvature: CGFloat = 1
  @State private var angle: CGFloat = Double.pi / 2
  @State private var spread: CGFloat = Double.pi
  @State private var amount: CGFloat = 0.5
  @State private var cornerRadius: CGFloat = 40
  @State private var ovalization: CGFloat = 0.5

  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero

}

#Preview {
  GlassHighlightEffectViewDemo()
}
