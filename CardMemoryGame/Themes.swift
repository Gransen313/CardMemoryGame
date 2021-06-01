//
//  Themes.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 24.05.2021.
//

import Foundation

class Themes: ObservableObject {
    @Published private(set) var savedThemes: [Theme]
    static let saveKey = "SavedThemesForCardMemoryGame"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Themes.saveKey) {
            if let decoded = try? JSONDecoder().decode([Theme].self, from: data) {
                savedThemes = decoded
                return
            }
        }
        savedThemes = [ThemeEnum.animals.theme, ThemeEnum.fruits.theme, ThemeEnum.sports.theme, ThemeEnum.transports.theme, ThemeEnum.flags.theme]
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(savedThemes) {
            UserDefaults.standard.set(encoded, forKey: Themes.saveKey)
        }
    }
    
    func addTheme(_ theme: Theme) {
        if let index = savedThemes.firstIndex(matching: theme) {
            savedThemes[index] = theme
        } else {
            savedThemes.insert(theme, at: 0)
        }
        save()
    }
    
    func deleteTheme(_ theme: Theme) {
        if let index = savedThemes.firstIndex(matching: theme) {
            savedThemes.remove(at: index)
            save()
        }
    }
}
