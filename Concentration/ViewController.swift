//
//  ViewController.swift
//  Concentration
//
//  Created by Adminaccount on 12/5/17.
//

// original files

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: nuberOfPairsOfCards)
    var nuberOfPairsOfCards:Int{
        return (cardButtons.count+1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    //    var scoreCount = 0 {
    //        didSet {
    //            scoreCountLabel.text = "Score: \(scoreCount)"
    //        }
    //    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    //    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    //    @IBAction func startNewGame(_ sender: UIButton) {
    //        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    //        emojiChoices = emojiThemes[randomTheme]!
    //        updateViewFromModel()
    //        flipCount = 0
    //        scoreCount = 0
    //    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            // scoreCount = game.score
            //flipCount = game.flips
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    //    var emojiThemes = ["halloween" : ["🦇","😱","🙀","👿","🎃","👻","🍭","🍬","🍎","🌑"],
    //                       "animals" : ["🐶","🐱","🐼","🐰","🐻","🐯","🐵","🦆","🦋","🐿"],
    //                       "sports" : ["⚽️","🏀","🏈","⚾️","🎾","🏸","🥊","🏄🏼‍♂️","🚴‍♀️","🏊🏽‍♂️"],
    //                       "food" : ["🍇","🍓","🍌","🌽","🍔","🍟","🍝","🍩","🍫","🍿"],
    //                       "space" : ["🚀","🛰","🛸","🌑","🌕","🌎","☄️","🌌","📡","🔭"],
    //                       "entertainments" : ["🎥","💸","🌋","🗽","🗿","🗺","🏝","🚠","🎮","🎬"]]
    
    //  lazy var emojiThemesKeys = Array(emojiThemes.keys)
    
    //    var randomTheme: String {
    //        get {
    //            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemesKeys.count - 1)))
    //            return emojiThemesKeys[randomIndex]
    //        }
    //    }
    
    private var emojiChoices = ["🦇","😱","🙀","👿","🎃","👻" ]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emoji.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self != 0{
            return Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
