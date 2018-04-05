//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denis Bystruev on 29/03/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    var listOfWords = [
    "Анастасия",
    "Анна",
    "Мария",
    ]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0
    var totalLosses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func newRound() {
        
    }
}
