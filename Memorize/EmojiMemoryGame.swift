//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 29/04/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    //private(set) var game: MemoryGame<String>
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    private static var themes = [Theme]()
    
   private static func createThemes(){
        themes.append(Theme(name: "Halloween", contents: ["๐ป","๐งโโ๏ธ","๐งน","๐","๐"], color: Color.orange))
        themes.append(Theme(name: "Love", contents: ["โค๏ธ","๐","๐","๐","๐ฉโโค๏ธโ๐จ"], color: Color.red))
        themes.append(Theme(name: "St.Patricks", contents: ["๐","โ๏ธ","๐ช","๐ป","๐ฉ"], color: Color.green))
        themes.append(Theme(name: "Games", contents: ["๐ฎ","๐น","๐พ","๐","๐ฒ"], color: Color.black))
        themes.append(Theme(name: "Pets", contents: ["๐","๐ถ","๐ธ","๐ณ","๐"], color: Color.yellow))
    }
    
    private static func createMemoryGame() -> MemoryGame<String>{
        createThemes()
        return createRandomMemoryGame()
    }
    
    static func createRandomMemoryGame() -> MemoryGame<String>{
        let theme = EmojiMemoryGame.themes[Int.random(in: 0...(EmojiMemoryGame.themes.count)-1)]
        return MemoryGame<String>(newTheme: theme) { index in theme.contents[index] }
    }
    
    // MARK: - Acces the Model
    var cards : Array<MemoryGame<String>.Card>{
        game.cards
    }
    var actualTheme: Theme{
        game.theme
    }
    var gameScore:Int{
        game.score
    }
    
    // MARK: - Intents
    func choose( card: MemoryGame<String>.Card){
        game.choose(card: card)
    }
    
    func newGame() -> Void {
        print("new game")
        game = EmojiMemoryGame.createRandomMemoryGame()
    }
    
}
