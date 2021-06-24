//
//  ViewController.swift
//  ApplePieProject
//
//  Created by River Camacho on 11/5/19.
//  Copyright © 2019 River Camacho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var letterButton: [UIButton]!
    
    var currentGame: Game!
    
    
    var listOfWords = ["worm", "deer", "lion"]
    let incorrectMovesAllowed = 4
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      newRound()
        
        
   
    
    }
    
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else if listOfWords.isEmpty {
            
            scoreLabel.text = "Game Over"
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButton {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            correctWordLabel.text = "Loss"
            
            
            
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            correctWordLabel.text = "Win"
        }else {
            updateUI()
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
        
    }
}




