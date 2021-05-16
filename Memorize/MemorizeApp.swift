//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 27/04/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(emojiGame: EmojiMemoryGame())
        }
    }
}
