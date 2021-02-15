//
//  Cardify.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 12.02.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool, gradientColors: [Color]) {
        rotation = isFaceUp ? 0 : 180
        self.gradientColors = gradientColors
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    var gradientColors: [Color]
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    
}

extension View {
    func cardify(isFaceUp: Bool, gradientColors: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradientColors: gradientColors))
    }
}
