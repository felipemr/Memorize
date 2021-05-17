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
                }
            }
    }
}

struct  CardView: View {
    //MARK: - Controls
    private let cornerRadius: CGFloat = 25.0
    private let lineWidth: CGFloat = 3
    private let fontFactor: CGFloat = 0.5
    let color:Color
    // font: Font
    
    //MARK: - View variables
    var card: MemoryGame<String>.Card
    
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack() {
                if card.isFacedUp {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .circular).stroke(lineWidth: lineWidth).fill(color)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 90-90), clockwise: true)
                        .fill(color).padding(5).opacity(0.4)
                    Text(card.content)
                }
                else {
                    if !card.isMatched{
                        RoundedRectangle(cornerRadius: cornerRadius, style: .circular).fill(color)
                    }
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .font(cardFont(size: geometry.size))
            
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

