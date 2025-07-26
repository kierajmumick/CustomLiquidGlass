// Created by kieraj_mumick on 7/25/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

import SwiftUI

struct SectionHeader: View {
  let title: String
  var body: some View {
    Text(title)
      .fontWeight(.medium)
      .padding(.bottom, 8)
      .padding(.top, 12)
      .frame(maxWidth: .infinity)
      .multilineTextAlignment(.center)
  }
}
