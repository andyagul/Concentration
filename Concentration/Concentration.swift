//
//  Concentration.swift
//  Concentration
//
//  Created by Adminaccount on 12/6/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation

class Concentration
{    
    private(set) var cards = [Card]()
    var shuffledCards = [Card]()
    
    var flippedCardsIDs = [Int]()
    
    var score = 0
    var flips = 0
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
//            var foundIndex:Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp {
//                    if foundIndex  == nil{
//                         foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    
    var faceUpCardID: Int?
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), " Concentration chooseCard (at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
          

    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0 , " Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //different cards, cause struct gets copied
        }
        // TODO: Shuffle the cards
        /*
         for cardIndex in 0..<cards.count {
         let randomIndex = Int(arc4random_uniform(UInt32(cards.count - 1)))
         cards.swapAt(cardIndex, randomIndex)
         }*/
    }
    
}


extension Collection{
    var oneAndOnly: Element? {
    return count == 1 ? first : nil
    }
}
