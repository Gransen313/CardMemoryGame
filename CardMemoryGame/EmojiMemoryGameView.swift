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
            .foregroundColor(viewModel.theme.colors.first)
        }
        .padding()
    }
    //MARK: - Helpfull constants
    
    private let scoreConstant = "Score: "
    private let newGameConstant = " New Game "
    private let cornerRadius: CGFloat = 20.0
    private let lineWidth: CGFloat = 2.0
    private let buttonBoarderPadding: CGFloat = -5.0
    private let cardViewPadding: CGFloat = 5.0
    
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    var gradientColors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 30))
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    //MARK: - Drawing contstants
    
    private let fontScaleFactor: CGFloat = 0.6
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
    
}

