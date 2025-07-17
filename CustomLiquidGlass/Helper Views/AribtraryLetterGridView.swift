// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct ArbitraryLetterGridView: View {
  let gridLetters: [[String]] = [
    ["A", "B", "C", "D", "E"],
    ["F", "G", "H", "I", "J"],
    ["K", "L", "M", "N", "O"],
    ["P", "Q", "R", "S", "T"],
    ["U", "V", "W", "X", "Y"]
  ]

  var body: some View {
    let totalCells = gridLetters.flatMap { $0 }.count
    let colors = generateColors(count: totalCells)

    Grid(horizontalSpacing: 2, verticalSpacing: 2) {
      ForEach(0..<gridLetters.count, id: \.self) { row in
        GridRow {
          ForEach(0..<gridLetters[row].count, id: \.self) { col in
            let color = colors[5 * row + col]
            Text(gridLetters[row][col])
              .font(.system(size: 20, weight: .bold, design: .monospaced))
              .frame(width: 30, height: 30)
              .background(color.opacity(0.2))
              .foregroundStyle(color)
              .cornerRadius(4)
          }
        }
      }
    }
    .padding()
  }

  private func generateColors(count: Int) -> [Color] {
    (0..<count).map { i in
      let hue = Double(i) / Double(count)
      return Color(hue: hue, saturation: 0.8, brightness: 0.9)
    }
  }
}

#Preview {
  ArbitraryLetterGridView()
}
