//
//  Concentration.swift
//  Concentration
//
//  Created by Yuri Kim on 2020/07/15.
//  Copyright © 2020 Yuri Kim. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()  // init that has no arguments
    
    var indexOfOneAndOnlyFaceUpCard: Int?  { // only set when only one card is face up
        // computed property
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipCount = 0
    var score = 0
    
    var cardsFlippedBefore: Array<Int> = []
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
//                    numberOfMatchedPairs += 1
                    score += 2
                }
                else if cardsFlippedBefore.contains(index) {
                    score -= 1  // card flipped right before is not counted (problem)
                }
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            if !cardsFlippedBefore.contains(index) {
                cardsFlippedBefore.append(index)
            }
            flipCount += 1
        }
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//
//        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            //let matchingCard = Card(identifier: <#T##Int#>)
            //let matchingCard = card // struct -> copied -> this works too
            cards.append(card)
            //cards.append(matchingCard)
            cards.append(card)  // struct -> copied -> this works too
            // cards += [card, card]  // this is also possible
            
        }
        cards.shuffle()
    }
}
