//
//  ThemesListView.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 24.05.2021.
//

import SwiftUI

struct ThemesListView: View {
    @ObservedObject var themes: Themes
    @State private var editMode: EditMode = EditMode.inactive
    @State private var showThemeEditor: Bool = false
    @State var choosenTheme: Theme = ThemeEnum.empty.theme
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themes.savedThemes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))) {
                        HStack {
                            if editMode.isEditing {
                                ThemeEditorButtonView()
                                    .foregroundColor(Color(theme.color))
                                    .onTapGesture {
                                        choosenTheme = theme
                                        showThemeEditor = true
                                    }
                                    .sheet(isPresented: $showThemeEditor, content: {
                                        ThemeEditorView(choosenTheme: $choosenTheme, isShowing: $showThemeEditor)
                                            .environmentObject(themes)
                                            .frame(minWidth: minWidth, minHeight: minHeight)
                                    })
                            }
                            
                            VStack(alignment: .leading) {
                                Text(theme.name)
                                    .foregroundColor(editMode.isEditing ? .black :Color(theme.color))
                                Text(showThemeDetails(theme: theme))
                                    .font(.system(.footnote))
                                    .lineLimit(lineLimit)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { themes.savedThemes[$0] }.forEach { theme in
                        themes.deleteTheme(theme)
                    }
                }            }
            .navigationBarTitle(Text(verbatim: navigationBarTitle))
            .navigationBarItems(
                leading: Button(action: { themes.addTheme(ThemeEnum.empty.theme) },
                                label: { Image(systemName: imageSystemName).imageScale(.large) }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
    
    private func showThemeDetails(theme: Theme) -> String {
        let pairsString = theme.numberOfPairsOfCards == theme.emogies.count ? "All from: " : "\(theme.numberOfPairsOfCards) pairs from: "
        return pairsString + String(theme.emogies.joined())
    }
    
    //MARK: - Drawing constants
    
    private let lineLimit: Int = 1
    private let minWidth: CGFloat = 300
    private let minHeight: CGFloat = 500
    private let navigationBarTitle: String = "Memorize"
    private let imageSystemName: String = "plus"
}

struct ThemeEditorView: View {
    @EnvironmentObject var themes: Themes
    
    @Binding var choosenTheme: Theme
    @Binding var isShowing: Bool
    
    @State private var emojisToAdd: String = ""
    
    @State private var explainUnableDeletion: Bool = false
    @State private var explainUnableDecrementing: Bool = false
    @State private var explainUnableIncrementing: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(mainHeader).font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: { isShowing = false }, label: { Text(doneButtonText) }).padding()
                }
            }
            Divider()
            Form {
                Section(header: Text(themeNameHeader).font(.headline)) {
                    TextField(themeNamePlaceholder, text: $choosenTheme.name, onEditingChanged: { began in
                        if !began {
                            themes.addTheme(choosenTheme)
                        }
                    })
                }
                // Add emoji section
                Section(header: Text(addEmojiHeader).font(.headline)) {
                    HStack {
                        TextField(addEmojiPlaceholder, text: $emojisToAdd)
                        Button(addButtonText) {
                            for character in emojisToAdd {
                                print(character)
                                if !choosenTheme.emogies.contains(String(character)) {
                                    choosenTheme.emogies.append(String(character))
                                }
                            }
                            themes.addTheme(choosenTheme)
                            emojisToAdd = ""
                        }.disabled(emojisToAdd.isEmpty)
                    }
                }
                // Delete emoji section
                Section(header: Text(deleteEmojiHeader).font(.headline)) {
                    Grid(choosenTheme.emogies.map { String($0) }, id: \.self) { emoji in
                        Text(emoji).font(Font.system(size: fontSize))
                            .onTapGesture {
                                if choosenTheme.numberOfPairsOfCards < choosenTheme.emogies.count {
                                    if let index = choosenTheme.emogies.firstIndex(of: emoji) {
                                        choosenTheme.emogies.remove(at: index)
                                        choosenTheme.removedEmojies.append(emoji)
                                        themes.addTheme(choosenTheme)
                                    }
                                } else {
                                    explainUnableDeletion = true
                                }
                            }
                    }
                    .frame(height: removeEmojiHeight)
                    .alert(isPresented: $explainUnableDeletion) {
                        Alert(title: Text(titleDeleteEmojiAlert), message: Text(messageDeleteEmojiAlert), dismissButton: .default(Text(buttonDeleteEmojiAlert)))
                    }
                }
                // Section for selecting the number of pairs
                Section(header: Text(cardCountHeader).font(.headline)) {
                    HStack {
                        Text("\(choosenTheme.numberOfPairsOfCards) Pairs")
                        Stepper(onIncrement: {
                            if choosenTheme.numberOfPairsOfCards < choosenTheme.emogies.count {
                                choosenTheme.numberOfPairsOfCards += 1
                                themes.addTheme(choosenTheme)
                            } else {
                                explainUnableIncrementing = true
                            }
                        }, onDecrement: {
                            if choosenTheme.numberOfPairsOfCards > maxPairs {
                                choosenTheme.numberOfPairsOfCards -= 1
                                themes.addTheme(choosenTheme)
                            } else {
                                explainUnableDecrementing = true
                            }
                        }, label: { EmptyView() })
                        .alert(isPresented: $explainUnableDecrementing) {
                            Alert(title: Text(titleDecrementCountAlert), message: Text(messageDecrementCountAlert), dismissButton: .default(Text(buttonDecrementCountAlert)))
                        }
                        .alert(isPresented: $explainUnableIncrementing) {
                            Alert(title: Text(titleIncrementCountAlert), message: Text(messageIncrementCountAlert), dismissButton: .default(Text(buttonIncrementCountAlert)))
                        }
                    }
                }
                // Color selection section
                Section(header: Text(colorHeader).font(.headline)) {
                    Grid(colors, id: \.self) { color in
                        ZStack {
                            RoundedRectangle(cornerRadius: colorRectangleCornerRadius).fill(Color(color)).frame(width: colorRectangleWidth, height: colorRectangleHeight)
                            RoundedRectangle(cornerRadius: colorRectangleCornerRadius).stroke(Color.black).frame(width: colorRectangleWidth, height: colorRectangleHeight)
                            Image(systemName: checkmarkImageSystemName)
                                .foregroundColor(.white)
                                .opacity(UIColor(choosenTheme.color) == color ? 1 : 0)
                        }
                        .onTapGesture {
                            choosenTheme.color = color.rgb
                            themes.addTheme(choosenTheme)
                        }
                    }
                    .frame(minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight)
                }
                // Return section
                Section(header: HStack {
                    Text(returnEmojiHeader)
                    Button(returnButtonTitle) {
                        choosenTheme.removedEmojies.forEach { emoji in
                            if let index = choosenTheme.removedEmojies.firstIndex(of: emoji) {
                                choosenTheme.emogies.append(emoji)
                                choosenTheme.removedEmojies.remove(at: index)
                            }
                        }
                        themes.addTheme(choosenTheme)
                    }.disabled(choosenTheme.removedEmojies.isEmpty)
                } ) {
                    Grid(choosenTheme.removedEmojies.map { String($0) }, id: \.self) { emoji in
                        Text(emoji).font(Font.system(size: fontSize))
                            .onTapGesture {
                                if let index = choosenTheme.removedEmojies.firstIndex(of: emoji) {
                                    choosenTheme.emogies.append(emoji)
                                    choosenTheme.removedEmojies.remove(at: index)
                                    themes.addTheme(choosenTheme)
                                }
                            }
                    }
                    .frame(height: returnEmojiHeight)
                }
            }
        }
    }
    
    //MARK: - Drawing constants
    
    private var removeEmojiHeight: CGFloat {
        CGFloat((choosenTheme.emogies.count - 1) / 6 * 70 + 70)
    }
    private var returnEmojiHeight: CGFloat {
        CGFloat((choosenTheme.removedEmojies.count - 1) / 6 * 70 + 70)
    }
    private let colors: [UIColor] = [.black, .blue, .gray, .green, .orange, .brown, .purple, .red, .white, .yellow, .cyan, .magenta]
    private let fontSize: CGFloat = 30.0
    private let maxPairs: Int = 2
    private let colorRectangleWidth: CGFloat = 35.0
    private let colorRectangleHeight: CGFloat = 35.0
    private let colorRectangleCornerRadius: CGFloat = 5.0
    private let minHeight: CGFloat = 20
    private let idealHeight: CGFloat = 80
    private let maxHeight: CGFloat = 100
    private let mainHeader: String = "Theme Editor"
    private let doneButtonText: String = "Done"
    private let themeNameHeader: String = "Theme Name"
    private let themeNamePlaceholder: String = "Enter Theme Name"
    private let addEmojiHeader: String = "Add Emoji"
    private let addEmojiPlaceholder: String = "Add Emojis"
    private let addButtonText: String = "Add"
    private let deleteEmojiHeader: String = "Remove Emoji"
    private let cardCountHeader: String = "Card Count"
    private let colorHeader: String = "Color"
    private let returnEmojiHeader: String = "Return Emoji"
    private let returnButtonTitle: String = "Return All"
    private let titleDeleteEmojiAlert: String = "Unable to delete emoji"
    private let messageDeleteEmojiAlert: String = "Impossible to delete more emojis, because now we need all of them for game"
    private let buttonDeleteEmojiAlert: String = "Ok"
    private let titleIncrementCountAlert: String = "Unable to increment count"
    private let messageIncrementCountAlert: String = "Impossible to increment count, because now we don't have enough emojis for it"
    private let buttonIncrementCountAlert: String = "Ok"
    private let titleDecrementCountAlert: String = "Unable to decrement count"
    private let messageDecrementCountAlert: String = "Impossible to decrement count, because now we have the least number of pairs"
    private let buttonDecrementCountAlert: String = "Ok"
    private let checkmarkImageSystemName: String = "checkmark"
}

struct ThemeEditorButtonView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .frame(width: 22, height: 22)
            Image(systemName: "pencil")
                .foregroundColor(.white)
        }
    }
}




struct ThemesListView_Previews: PreviewProvider {
    static var previews: some View {
        ThemesListView(themes: Themes())
    }
}
