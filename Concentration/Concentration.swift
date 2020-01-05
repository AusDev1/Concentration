//
//  Concentration.swift
//  Concentration
//
//  Created by Austen Williams on 12/12/19.
//  Copyright © 2019 Austen Williams. All rights reserved.
//

import Foundation

/* this section would be classified as the model.
 it uses a class to define the game "Concentration" which has the user pair cards based on memory. We use a class because it is a refrence type to how to play the game of concentration. The only thing this model does is sets the parameters around how the game is played.
 */

class Concentration {
    
    
    
    var cards = [Card]()
    
    var score = Int()
    
    var seenBefore = [Int: Int]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    func chooseCard(at index: Int ) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func newCards(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        flipCount = 0
        score = 0
        seenBefore.removeAll()
        cards = cards.shuffled()
    }
    
    
    func keepScore(at index: Int) -> Int {
        if let faceUpCard = indexOfOneAndOnlyFaceUpCard {
            if cards[faceUpCard].identifier == cards[index].identifier{
                score += 2
                print("We have a match")
            }
            else if cards[faceUpCard].identifier == seenBefore[faceUpCard] || cards[index].identifier == seenBefore[index] {
                score -= 1
                seenBefore[faceUpCard] = cards[faceUpCard].identifier
                seenBefore[index] = cards[index].identifier
            }
            else{
                seenBefore[faceUpCard] = cards[faceUpCard].identifier
                seenBefore[index] = cards[index].identifier
            }
        }
        return score
    }
    
    var themes = [0:["🏀","🎾","🏈","⚾️","⚽️","🏸","🏹","⛸","🏓"], 1: ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"], 2 : ["👨🏽","🕵🏽‍♂️","🧑🏽‍💻","🧑🏽‍🏫","👷🏽","🧑🏽‍🍳","👩🏽‍🔬","👩🏽‍🎨","👨🏽‍🔧"],3 : ["🐶","🐱","🦊","🐒","🦅","🐌","🐯","🐨","🐤"],4 : ["🍎","🌭","🍔","🧀","🧄","🥨","🥐","🥦","🥭"],5 : ["🏞","🌅","🌄","🌠","🌁","🗾","🌆","🌌","🏙"]]

    func themeChoices(number num: Int)-> [String]{
        if let theme = themes[num] {
            print(theme)
            return theme
        }
        else{
            return ["?"]
        }
    }
    

    
    
    init(numberOfPairsOfCards: Int) {
        //initializes how many cards are in the game based on pairs
        
        for _ in 0..<numberOfPairsOfCards {
            //for every pair the user
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
}
