// Created by kieraj_mumick on 7/25/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct SliderRow<Value: BinaryFloatingPoint>: View where Value.Stride: BinaryFloatingPoint {
  init(
    title: String,
    value: Binding<Value>,
    range: ClosedRange<Value>,
    valueString: @escaping (Value) -> String
  ) {
    self.title = title
    _value = value
    self.range = range
    self.valueString = valueString
  }

  init(
    title: String,
    value: Binding<Value>,
    range: ClosedRange<Value>,
  ) where Value == CGFloat {
    self.title = title
    _value = value
    self.range = range
    self.valueString = { "\($0)" }
  }

  init(
    title: String,
    value: Binding<Value>,
    range: ClosedRange<Value>,
  ) where Value == Double {
    self.title = title
    _value = value
    self.range = range
    self.valueString = { "\($0)" }
  }

  init(
    title: String,
    value: Binding<Value>,
    range: ClosedRange<Value>,
  ) where Value == Float {
    self.title = title
    _value = value
    self.range = range
    self.valueString = { "\($0)" }
  }

  let title: String
  @Binding var value: Value
  let range: ClosedRange<Value>
  let valueString: (Value) -> String

  var body: some View {
    VStack {
      HStack {
        Text(title)
          .font(.body.smallCaps())
        Spacer()
        Text(valueString(value))
          .monospaced()
      }
      Slider(value: $value, in: range)
    }
  }
}

#Preview {
  @Previewable @State var value = 10.0
  SliderRow(title: "Number", value: $value, range: 0...20)
    .padding()
}
