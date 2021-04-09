//
//  Theme.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 10.02.2021.
//

import SwiftUI

struct Theme: Codable {
    
    var name: String
    var emogies: [String]
    var numberOfPairsOfCards: Int
    var color: UIColor.RGB
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}

enum ThemeEnum: CaseIterable {
    
    case animals, fruits, sports, transports, flags, hands
    
    var theme: Theme {
        switch self {
        case .animals: return Theme(name: "Animals", emogies: ThemeEmogies.animalEmojies, numberOfPairsOfCards: 4, color: .init(red: 255, green: 255, blue: 0, alpha: 1))
        case .fruits: return Theme(name: "Fruits", emogies: ThemeEmogies.fruitEmojies, numberOfPairsOfCards: 6, color: .init(red: 0, green: 255, blue: 255, alpha: 1))
        case .sports: return Theme(name: "Sports", emogies: ThemeEmogies.sportEmojies, numberOfPairsOfCards: 9, color: .init(red: 255, green: 0, blue: 255, alpha: 1))
        case .transports: return Theme(name: "Transports", emogies: ThemeEmogies.transportEmogies, numberOfPairsOfCards: 12, color: .init(red: 0, green: 255, blue: 0, alpha: 1))
        case .flags: return Theme(name: "Flags", emogies: ThemeEmogies.flagEmogies, numberOfPairsOfCards: 16, color: .init(red: 0, green: 0, blue: 255, alpha: 1))
        case .hands: return Theme(name: "Hands", emogies: ThemeEmogies.handEmojies, numberOfPairsOfCards: 25, color: .init(red: 255, green: 0, blue: 0, alpha: 1))
        }
    }
    
}

struct ThemeEmogies {
    
    static let animalEmojies = ["🦍", "🦣", "🦨", "🐫", "🐋", "🐩", "🐢", "🦔", "🦒", "🦜", "🦩", "🦧", "🐌", "🦅", "🦉", "🦭"] // 4 pairs from 16 emogies
    static let fruitEmojies = ["🍏", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍑", "🍍", "🥥", "🍆", "🥝", "🫐", "🍒", "🥭", "🌽"] // 6 pairs from 16 emogies
    static let sportEmojies = ["⚽️", "🏀", "🏈", "🥏", "🎱", "🪃", "🏹", "🥊", "🥋", "🛹", "⛸", "🛼", "🥌", "🏆", "🥇", "🎳", "🎯", "🩰", "🎗", "🏵", "🚣‍♀️", "🧘🏿‍♀️", "🤺", "🏄🏻‍♂️", "🏂", "🤼", "🪂"] // 8 pairs from 27 emogies
    static let transportEmogies = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛥", "🛰", "🛴", "🚲", "🛵", "🏍", "🚔", "🚍", "🚘", "🚖", "🚃", "🚆", "🛩", "🚀", "🛸", "🚁", "🛶", "⛵️"] // 12 pairs from 32 emogies
    static let flagEmogies = ["🏴‍☠️", "🏁", "🏳️‍🌈", "🇦🇺", "🇦🇹", "🇧🇷", "🇧🇪", "🇷🇺", "🇯🇵", "🇳🇴", "🇰🇷", "🇺🇸", "🇭🇷", "🇿🇦", "🇪🇹", "🇸🇪", "🇨🇭", "🇨🇿", "🇫🇷", "🇫🇮", "🇺🇾", "🇺🇦", "🇹🇷", "🇹🇭", "🇸🇴", "🇵🇹", "🇵🇱", "🇳🇬", "🇲🇽", "🇧🇶", "🇨🇳", "🇮🇹", "🇮🇸", "🇮🇶", "🇪🇺", "🇩🇴", "🇬🇪", "🇬🇷", "🇩🇪", "🇻🇳", "🇻🇪", "🇧🇩"] // 16 pairs from 42 emogies
    static let handEmojies = ["🤲🏿", "🤲", "🤲🏻", "🤲🏽", "👐🏿", "👐🏽", "👐🏻", "👐", "🙌🏿", "🙌🏽", "🙌🏻", "🙌", "👏🏿", "👏🏽", "👏🏻", "👏", "👍🏽", "👍🏿", "👍🏻", "👍", "👎🏿", "👎🏽", "👎🏻", "👎", "👊🏿", "👊🏽", "👊🏻", "👊", "✊🏿", "✊🏽", "✊🏻", "✊", "🤛🏿", "🤛🏽", "🤛🏻", "🤛", "🤜🏿", "🤜🏽", "🤜🏻", "🤜", "🤞🏿", "🤞🏽", "🤞🏻", "🤞", "✌🏿", "✌🏽", "✌🏻", "✌️", "🤟🏿", "🤟🏽", "🤟🏻", "🤟", "🤘🏿", "🤘🏽", "🤘🏻", "🤘", "👌🏿", "👌🏽", "👌🏻", "👌", "🤌🏿", "🤌🏽", "🤌🏻", "🤌", "🤏🏿", "🤏🏽", "🤏🏻", "🤏", "👈🏿", "👈🏽", "👈🏻", "👈", "👉🏿", "👉🏽", "👉🏻", "👉", "👆🏿", "👆🏽", "👆🏻", "👆", "👇🏿", "👇🏽", "👇🏻", "👇", "☝🏿", "☝🏽", "☝🏻", "☝️"] // 25 pairs from 88 emogies
    
}
