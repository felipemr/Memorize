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
                        withAnimation(.easeInOut(duration: 0.5)) {
                            emojiGame.newGame()
                        }
                    }
                    Text(emojiGame.actualTheme.name)
                    Text("Score: \(emojiGame.gameScore)")
                }
                Grid(emojiGame.cards){card in
                    CardView(color: emojiGame.actualTheme.cardColor, card: card).onTapGesture {
                        withAnimation(.linear(duration: 1)) {
                            emojiGame.choose(card: card)
                        }
                    }
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
            makeBody(for: geometry)
        }
    }
    
    @State var animatedTimedBonus : Double = 0
    
    private func startTimedBonusAnimation(){
        animatedTimedBonus = card.bonusPercentageRemaining
        withAnimation(.linear(duration: card.timedBonusRemainingTime)){
            animatedTimedBonus = 0
        }
    }

    @ViewBuilder
    private func makeBody(for geometry: GeometryProxy) -> some View {
        if !card.isMatched || card.isFacedUp{
            ZStack() {
                Group{
                    if card.isConsumingBonus{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -animatedTimedBonus*360-90), clockwise: true)
                            .fill(color)
                            .onAppear{
                                self.startTimedBonusAnimation()
                            }
                    }
                    else{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -card.bonusPercentageRemaining*360-90), clockwise: true)
                            .fill(color)
                    }
                }
                .padding(5).opacity(0.4)

                
                    
                Text(card.content)
                    .font(cardFont(size: geometry.size))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1.3).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFacedUp: card.isFacedUp, color: color)
            .transition(.scale)
            
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

