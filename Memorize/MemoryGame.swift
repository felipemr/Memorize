//
//  MemoryGame.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 29/04/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards: Array<Card>
    var theme: Theme
    var score: Int = 0
    
    private var indexOfFacedUpCard: Int?{
        get{ cards.indices.filter{cards[$0].isFacedUp}.only }
        set{
            for index in cards.indices{
                cards[index].isFacedUp = index == newValue
            }
        }
    }
    
    init(newTheme: Theme, cardContentFactory: (Int) -> CardContent){
        theme = newTheme
        cards = Array<Card>()
        for pairIndex in 0..<theme.getRandomPairs(){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id : pairIndex*2))
            cards.append(Card(content: content, id : pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFacedUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfFacedUpCard{
                if cards[potentialMatchIndex].content == cards[chosenIndex].content{
                    cards[potentialMatchIndex].isMatched.toggle()
                    cards[chosenIndex].isMatched.toggle()
                    score+=2
                }
                else{
                    if self.cards[indexOfFacedUpCard!].wasSeen {
                        score-=1
                    }
                    if self.cards[chosenIndex].wasSeen {
                        score-=1
                    }
                    self.cards[indexOfFacedUpCard!].wasSeen = true
                    self.cards[chosenIndex].wasSeen = true
                }
                self.cards[chosenIndex].isFacedUp.toggle()
            }
            else{
                indexOfFacedUpCard = chosenIndex
            }
        }
    }
    
    
    
    struct Card: Identifiable{
        var isFacedUp : Bool = false{
            didSet{
                if isFacedUp{
                    startUsingTimedBonus()
                }
                else{
                    stopUsingTimedBonus()
                }
            }
        }
        var isMatched : Bool = false{
            didSet{
                stopUsingTimedBonus()
            }
        }
        var wasSeen : Bool = false
        var content : CardContent
        var id: Int
        
        
        //MARK: - Timed Bonus
        
        var timedBonusLimit : TimeInterval = 10
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime:TimeInterval = 0
        private var facedUpTime: TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            else{
                return pastFaceUpTime
            }
        }
        
        var timedBonusRemainingTime : TimeInterval{
            max(0, timedBonusLimit - facedUpTime)
        }
        
        var bonusPercentageRemaining: Double{
            (timedBonusLimit > 0 && timedBonusRemainingTime > 0) ? timedBonusRemainingTime/timedBonusLimit : 0
        }
        var hasEarnedBonus: Bool{
            isMatched && timedBonusRemainingTime>0
        }
        var isConsumingBonus: Bool{
            isFacedUp && !isMatched && timedBonusRemainingTime>0
        }
        private mutating func startUsingTimedBonus(){
            if isConsumingBonus, lastFaceUpDate == nil{
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingTimedBonus(){
            pastFaceUpTime = facedUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}
