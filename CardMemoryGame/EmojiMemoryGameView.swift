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
                Button(newGameConstant, action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                })
                    .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(lineWidth: lineWidth)
                                .foregroundColor(viewModel.theme.colors.first)
                                .padding(buttonBoarderPadding))
            }
            .foregroundColor(viewModel.theme.colors.first)
            Grid(viewModel.cards) { card in
                CardView(card: card, gradientColors: viewModel.theme.colors).onTapGesture {
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isComsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -animatedBonusRemaining * 360 - 90), clockWise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -card.bonusRemaining * 360 - 90), clockWise: true)
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, gradientColors: gradientColors)
            .transition(AnyTransition.scale)
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

