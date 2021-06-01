//
//  CardMemoryGameApp.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 02.02.2021.
//

import SwiftUI

@main
struct CardMemoryGameApp: App {
    
    var body: some Scene {
        WindowGroup {
//            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
            ThemesListView(themes: Themes())
        }
    }
    
}
