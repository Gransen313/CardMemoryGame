//
//  EmojiMemoryGame.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 02.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let themeOptional = ThemeEnum.allCases.randomElement()?.theme
        let theme = themeOptional != nil ? themeOptional! : ThemeEnum.animals.theme
        print("json: \(theme.json?.utf8 ?? "nil")")
        let emojies = theme.emogies
        return MemoryGame<String>.init(theme: theme) { pairIndex in
            emojies[pairIndex]
        }
    }
    
    //MARK: - Access to Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var theme: Theme {
        model.theme
    }
    var score: Int {
        model.score
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
