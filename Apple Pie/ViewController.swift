//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denis Bystruev on 29/03/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = names
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound(after: 0.5)
        }
    }
    
    var totalLoses = 0 {
        didSet {
            currentGame.formattedWord = currentGame.word
            newRound(after: 0.5)
        }
    }

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(arc4random_uniform(0))
        
        
        for i in 0..<listOfWords.count {
            listOfWords[i] = listOfWords[i].lowercased()
        }
        
        newRound()
    }
    
    func enableButtons(_ enable: Bool, in view: Any) {
        if view is UIButton {
            (view as! UIButton).isEnabled = enable
        } else if view is UIStackView {
            for subview in (view as! UIStackView).subviews {
                enableButtons(enable, in: subview)
            }
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for view in view.subviews {
            enableButtons(enable, in: view)
        }
    }
    
    func newRound(after delay: Double = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if !self.listOfWords.isEmpty {
                let randomIndex = Int(arc4random_uniform(UInt32(self.listOfWords.count)))
                let newWord = self.listOfWords.remove(at: randomIndex)
                self.currentGame = Game(
                    word: newWord,
                    incorrectMovesRemaining: self.incorrectMovesAllowed,
                    guessedLetters: []
                )
                self.enableLetterButtons(true)
                self.updateUI()
            } else {
                self.enableLetterButtons(false)
            }
        }
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLoses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        updateUI()
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        letters[0] = letters[0].capitalized
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Выиграно: \(totalWins), Проиграно: \(totalLoses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

}
