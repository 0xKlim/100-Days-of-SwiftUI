//
//  FilterSliderView.swift
//  13_Instafilter
//
//  Created by Vladislav on 05.11.2026.
//

import SwiftUI

struct FilterSliderView: View {
    let name: String
    @Binding var value: Double
    let range: ClosedRange<Double>

    init(_ name: String, value: Binding<Double>, in range: ClosedRange<Double> = 0...1) {
        self.name = name
        self._value = value
        self.range = range
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Slider(value: $value, in: range)
                .containerRelativeFrame(.horizontal) { size, _ in
                    size * 0.7
                }
        }
    }
}

#Preview {
    FilterSliderView("Scale", value: .constant(0.5))
        .padding()
    
}
