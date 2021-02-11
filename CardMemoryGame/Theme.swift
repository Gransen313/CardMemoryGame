//
//  Theme.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 10.02.2021.
//

import SwiftUI

struct Theme {
    
    var name: String
    var emogies: [String]
    var numberOfPairsOfCards: Int
    var color: Color
    
}

enum ThemeEnum: CaseIterable {
    
    case animals, fruits, sports, transports, flags, hands
    
    var theme: Theme {
        switch self {
        case .animals: return Theme(name: "Animals", emogies: ThemeEmogies.animalEmojies, numberOfPairsOfCards: 4, color: .red)
        case .fruits: return Theme(name: "Fruits", emogies: ThemeEmogies.fruitEmojies, numberOfPairsOfCards: 6, color: .green)
        case .sports: return Theme(name: "Sports", emogies: ThemeEmogies.sportEmojies, numberOfPairsOfCards: 9, color: .yellow)
        case .transports: return Theme(name: "Transports", emogies: ThemeEmogies.transportEmogies, numberOfPairsOfCards: 12, color: .gray)
        case .flags: return Theme(name: "Flags", emogies: ThemeEmogies.flagEmogies, numberOfPairsOfCards: 16, color: .pink)
        case .hands: return Theme(name: "Hands", emogies: ThemeEmogies.handEmojies, numberOfPairsOfCards: Int.random(in: 24...32), color: .orange)
        }
    }
    
}

struct ThemeEmogies {
    
    static let animalEmojies = ["🦍", "🦣", "🦨", "🐫", "🐋", "🐩", "🐢", "🦔", "🦒", "🦜", "🦩", "🦧", "🐌", "🦅", "🦉", "🦭"] // 4 pairs from 16 emogies
    static let fruitEmojies = ["🍏", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍑", "🍍", "🥥", "🍆", "🥝", "🫐", "🍒", "🥭", "🌽"] // 6 pairs from 16 emogies
    static let sportEmojies = ["⚽️", "🏀", "🏈", "🥏", "🎱", "🪃", "🏹", "🥊", "🥋", "🛹", "⛸", "🛼", "🥌", "🏆", "🥇", "🎳", "🎯", "🩰", "🎗", "🏵", "🚣‍♀️", "🧘🏿‍♀️", "🤺", "🏄🏻‍♂️", "🏂", "🤼", "🪂"] // 8 pairs from 27 emogies
    static let transportEmogies = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛥", "🛰", "🛴", "🚲", "🛵", "🏍", "🚔", "🚍", "🚘", "🚖", "🚃", "🚆", "🛩", "🚀", "🛸", "🚁", "🛶", "⛵️"] // 12 pairs from 32 emogies
    static let flagEmogies = ["🏴‍☠️", "🏁", "🏳️‍🌈", "🇦🇺", "🇦🇹", "🇧🇷", "🇧🇪", "🇷🇺", "🇯🇵", "🇳🇴", "🇰🇷", "🇺🇸", "🇭🇷", "🇿🇦", "🇪🇹", "🇸🇪", "🇨🇭", "🇨🇿", "🇫🇷", "🇫🇮", "🇺🇾", "🇺🇦", "🇹🇷", "🇹🇭", "🇸🇴", "🇵🇹", "🇵🇱", "🇳🇬", "🇲🇽", "🇧🇶", "🇨🇳", "🇮🇹", "🇮🇸", "🇮🇶", "🇪🇺", "🇩🇴", "🇬🇪", "🇬🇷", "🇩🇪", "🇻🇳", "🇻🇪", "🇧🇩"] // 16 pairs from 42 emogies
    static let handEmojies = ["🤲🏿", "🤲", "🤲🏻", "🤲🏽", "👐🏿", "👐🏽", "👐🏻", "👐", "🙌🏿", "🙌🏽", "🙌🏻", "🙌", "👏🏿", "👏🏽", "👏🏻", "👏", "👍🏽", "👍🏿", "👍🏻", "👍", "👎🏿", "👎🏽", "👎🏻", "👎", "👊🏿", "👊🏽", "👊🏻", "👊", "✊🏿", "✊🏽", "✊🏻", "✊", "🤛🏿", "🤛🏽", "🤛🏻", "🤛", "🤜🏿", "🤜🏽", "🤜🏻", "🤜", "🤞🏿", "🤞🏽", "🤞🏻", "🤞", "✌🏿", "✌🏽", "✌🏻", "✌️", "🤟🏿", "🤟🏽", "🤟🏻", "🤟", "🤘🏿", "🤘🏽", "🤘🏻", "🤘", "👌🏿", "👌🏽", "👌🏻", "👌", "🤌🏿", "🤌🏽", "🤌🏻", "🤌", "🤏🏿", "🤏🏽", "🤏🏻", "🤏", "👈🏿", "👈🏽", "👈🏻", "👈", "👉🏿", "👉🏽", "👉🏻", "👉", "👆🏿", "👆🏽", "👆🏻", "👆", "👇🏿", "👇🏽", "👇🏻", "👇", "☝🏿", "☝🏽", "☝🏻", "☝️"] // 24-32 pairs from 88 emogies
    
}
