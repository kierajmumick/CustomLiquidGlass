// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct ImageDisplacementMapViewDemo: View {

  var body: some View {
    NavigationStack {
      VStack {
        ZStack {
          RainbowGradientView()
            .ignoresSafeArea()
          ImageDisplacementMapView(
            image: .rotaryDisplacement,
            inputAmount: inputAmount
          )
          .frame(width: 300, height: 300)
          .mask {
            Circle()
              .padding(15)
          }
          .offset(x: offset.width, y: offset.height)
          .offset(y: -40)
          .gesture(
            DragGesture(minimumDistance: 0)
              .onChanged { value in
                print(value.translation)
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
        .overlay(alignment: .bottom) {
          VStack {
            VStack(alignment: .leading) {
              Text("Amount: \(inputAmount)")
              Slider(value: $inputAmount, in: -300...300) {
                Text("Amount")
              } minimumValueLabel: {
                Text("-100")
              } maximumValueLabel: {
                Text("100")
              }
            }
          }
          .padding(.horizontal, 24)
        }

      }
      .background {
        Color.white.ignoresSafeArea()
      }
    }
  }

  @State private var inputAmount = 236.0
  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero

}

#Preview {
  ImageDisplacementMapViewDemo()
}
