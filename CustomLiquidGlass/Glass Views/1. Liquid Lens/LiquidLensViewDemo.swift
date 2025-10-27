// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct LiquidLensViewDemo: View {
  var body: some View {
    NavigationStack {
      ZStack {
        VStack(spacing: 4) {
          ForEach(0..<20) { item in
            Rectangle()
              .fill(Color(hue: Double(item) / 20.0, saturation: 1.0, brightness: 1.0))
              .ignoresSafeArea()
          }
        }
        .safeAreaInset(edge: .bottom, content: {
          VStack {
            Toggle(isOn: $warpsContentBelow) {
              Text("Warps content below")
            }

            Toggle(isOn: $isLifted) {
              Text("Is Lifted")
            }

            Toggle(isOn: $scaleWhenLifted) {
              Text("Scale when Lifted")
            }

            ColorPicker("Resting Background Color", selection: $restingBackgroundColor)
          }
          .padding(24)
          .glassEffect(.regular, in: .rect)
        })
        .overlay {
          VStack {
            LiquidLensView(
              isLifted: isLifted,
              warpsContentBelow: warpsContentBelow,
              restingBackgroundColor: restingBackgroundColor)
            .offset(
              x: offset.width,
              y: offset.height
            )
            .frame(
              width: 200 + (isLifted ? growth.width : 0),
              height: 300 + (isLifted ? growth.height : 0),
              alignment: .center
            )
            .gesture(
              DragGesture(minimumDistance: 0)
                .onChanged { value in
                  print(value.translation)
                  isLifted = true
                  offset = CGSize(
                    width: lastOffset.width + value.translation.width,
                    height: lastOffset.height + value.translation.height
                  )
                }
                .onEnded { _ in
                  isLifted = false
                  lastOffset = offset
                }
            )
          }
        }
        .animation(.spring, value: isLifted)
        .ignoresSafeArea()
        .background(.white)
      }
    }
  }

  private var growth: CGSize {
    if scaleWhenLifted {
      CGSize(width: 20, height: 30)
    } else {
      .zero
    }
  }

  @Environment(\.dismiss) private var dismiss
  @State private var isLifted = false
  @State private var warpsContentBelow = false
  @State private var restingBackgroundColor = Color.white.opacity(0.75)
  @State private var scaleWhenLifted = false

  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero

}

#Preview {
  LiquidLensViewDemo()
}
