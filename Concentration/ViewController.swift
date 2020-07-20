//
//  ViewController.swift
//  Concentration
//
//  Created by Yuri Kim on 2020/07/15.
//  Copyright © 2020 Yuri Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        // read only property
        return (cardButtons.count + 1) / 2
    }
//    var flipCount = 0 { didSet { flipCountLabel.text = "flips : \(flipCount)"  } }
//
//    var score = 0 { didSet { scoreLabel.text = "score : \(score)" } }
//
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    
    var themeChoices = [["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"],
                        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
                        ["~", "!", "@", "#", "$", "%", "^", "&", "*", "("],
                        ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
                        ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ"],
                        ["고", "노", "도", "로", "모", "보", "소", "오", "조", "초"]]
        
    @IBAction func clickNewGame(_ sender: UIButton) {
        let randomThemeIndex = Int(arc4random_uniform(UInt32(themeChoices.count)))
        emojiChoices = themeChoices[randomThemeIndex]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }
    }
    //    var emojiChoices = ["A", "B", "A", "B"]
    
    // MARK: Handle Card Touch Behavior
    @IBAction func touchCard(_ sender: UIButton) {
//        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
//            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
            flipCountLabel.text = "flips : \(game.flipCount)"
            scoreLabel.text = "score : \(game.score)"
        }
    }
    
    var emoji = Dictionary<Int, String>()  // [Int:String]() also works
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil,  emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex % emojiChoices.count)
        }
        
//        if emoji[card.identifier] != nil {  // optional because the thing we looked up for might not be in the dictionary
//            return emoji[card.identifier]
//        } else {
//            return "?"
//        }
        // above code is same as below line
        print(card.identifier)
        return emoji[card.identifier] ?? "?"
        
    }
    
//    func flipCard(withEmoji emoji: String, on button: UIButton) {
//        if button.currentTitle == emoji {
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
//        } else {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }


}

