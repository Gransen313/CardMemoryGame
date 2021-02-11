//
//  EmojiMemoryGameView.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 02.02.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.theme.name)
                Spacer()
                Text(scoreConstant + String(viewModel.score))
                Spacer()
                Button(newGameConstant, action: viewModel.startNextGame)
                    .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(lineWidth: lineWidth)
                                .foregroundColor(viewModel.theme.colors.first)
                                .padding(buttonBoarderPadding))
            }
            .foregroundColor(viewModel.theme.colors.first)
            Grid(viewModel.cards) { card in
                CardView(card: card, gradientColors: viewModel.theme.colors).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(cardViewPadding)
            }
            .padding()
        }
        .padding()
    }
    //MARK: - Constants
    
    let scoreConstant = "Score: "
    let newGameConstant = " New Game "
    let cornerRadius: CGFloat = 20.0
    let lineWidth: CGFloat = 2.0
    let buttonBoarderPadding: CGFloat = -5.0
    let cardViewPadding: CGFloat = 5.0
    
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    var gradientColors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing contstants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
    
}

