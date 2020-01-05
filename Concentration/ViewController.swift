//
//  ViewController.swift
//  Concentration
//
//  Created by Austen Williams on 12/12/19.
//  Copyright © 2019 Austen Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* Initializes model with how many available buttons and if number of button
 is odd. Adding 1 and dividing by 2 creates an even number of cards
 */
    
    //
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count / 2))

    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    func updateViewFromModel() {
        let count = game.flipCount
        flipCountLabel.text = "Flips: \(count)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            //print("Card is face up: \(card.isFaceUp), Card is matched \(card.isMatched)")
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🏀","🎾","🏈","⚾️","⚽️","🏸","🏹","⛸","🏓"]
    
    var emoji = [Int:String]()
    
    
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        
        
        return emoji[card.identifier] ?? "?"
        /*
        The same as the code below:
         
        if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        }
        return "?"
        */
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            let score = game.keepScore(at: cardNumber)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            scoreLabel.text = "Score: \(score)"
        } else{
            print("Chosen card is not in cardButtons")
        }
    
        
}
    
    
    @IBAction func newGame(_ sender: Any) {
        game.newCards()
        updateViewFromModel()
        scoreLabel.text = "Score: 0"
        emojiChoices = game.themeChoices(number: Int(arc4random_uniform(UInt32(6))))
        emoji.removeAll()
        }
    
    
    
    
}
