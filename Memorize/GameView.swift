//
//  ContentView.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 27/04/21.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    
    var body: some View {
        return
            VStack{
                HStack{
                    Button("New Game") {
                        emojiGame.newGame()
                    }
                    Text(emojiGame.actualTheme.name)
                    Text("Score: \(emojiGame.gameScore)")
                }
                Grid(emojiGame.cards){card in
                    CardView(color: emojiGame.actualTheme.cardColor, card: card).onTapGesture {emojiGame.choose(card: card)}
                        .padding(5)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
    }
}

struct  CardView: View {
    //MARK: - Controls
    let color:Color
    private let fontFactor: CGFloat = 0.5
    
    //MARK: - View variables
    var card: MemoryGame<String>.Card
    
    
    var body: some View{
        GeometryReader{ geometry in
            if !card.isMatched || card.isFacedUp{
                ZStack() {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 90-90), clockwise: true)
                        .fill(color).padding(5).opacity(0.4)
                    Text(card.content)
                        .font(cardFont(size: geometry.size))
                }
                .cardify(isFacedUp: card.isFacedUp, color: color)
            }
        }
    }
    
    func cardFont(size: CGSize) -> Font{
        let fontSize = min(size.width,size.height)
        return Font.system(size: fontSize * fontFactor)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return GameView(emojiGame: game)
    }
}

