//
//  Theme.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 05/05/21.
//

import SwiftUI

/*
 A theme consists of a name for the theme, a set of emoji to use, a number of cards to show (which, for at least one, but not all themes, should be random), and an appropriate color to use to draw (e.g. orange would be appropriate for a Halloween theme).
 */

struct Theme {
    let name:String
    var contents: [String]
    var numberOfPairs: Int
    let cardColor: Color
    
    init(name: String, contents: [String], numberOfCards: Int, color : Color) {
        self.name = name
        self.contents = contents
        self.numberOfPairs = numberOfCards*2
        self.cardColor = color
    }
    
    init(name: String, contents: [String], color : Color) {
        self.name = name
        self.contents = contents
        self.cardColor = color
        self.numberOfPairs = contents.count
    }
    
    func getRandomPairs()->Int{
        Int.random(in: 2...numberOfPairs)
    }
    
}
