//
//  EmojiMemoryGame.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 02.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojies = ["🥸", "🥳", "😍", "🤮", "🤪"]
        let emojiesCount = Int.random(in: 2..<emojies.count)
        return MemoryGame<String>.init(numberOfPairsOfCards: emojiesCount) { pairIndex in
            emojies[pairIndex]
        }
    }
    
    //MARK: - Access to Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
