//
//  MemoryGame.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 02.02.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            if cards.isEmpty {
                cards.append(Card(content: content, id: pairIndex * 2))
                cards.insert(Card(content: content, id: pairIndex * 2 + 1), at: Int.random(in: 0..<cards.count))
            } else {
                cards.insert(Card(content: content, id: pairIndex * 2), at: Int.random(in: 0..<cards.count))
                cards.insert(Card(content: content, id: pairIndex * 2 + 1), at: Int.random(in: 0..<cards.count))
            }
            
//            cards.append(Card(content: content, id: pairIndex * 2))
//            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
