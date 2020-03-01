//
//  Braille.swift
//  Sermo
//
//  Created by Ishan Jain on 2/29/20.
//  Copyright © 2020 Ishan Jain. All rights reserved.
//

import UIKit

class Braille: UIViewController {

    @IBOutlet weak var row1Col1: UIButton!
    @IBOutlet weak var row1Col2: UIButton!
    
    @IBOutlet weak var row2Col1: UIButton!
    @IBOutlet weak var row2Col2: UIButton!
    
    @IBOutlet weak var row3Col1: UIButton!
    @IBOutlet weak var row3Col2: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var text: String = ""

    var brailleDictionary: Dictionary = [
        " " : [[0,0],[0,0],[0,0]],
        "a" : [[1,0],[0,0],[0,0]],
        "b" : [[1,0],[1,0],[0,0]],
        "c" : [[1,1],[0,0],[0,0]],
        "d" : [[1,1],[0,1],[0,0]],
        "e" : [[1,0],[0,1],[0,0]],
        "f" : [[1,1],[1,0],[0,0]],
        "g" : [[1,1],[1,1],[0,0]],
        "h" : [[1,0],[1,1],[0,0]],
        "i" : [[0,1],[1,0],[0,0]],
        "j" : [[0,1],[1,1],[0,0]],
        "k" : [[1,0],[0,0],[1,0]],
        "l" : [[1,0],[1,0],[1,0]],
        "m" : [[1,1],[0,0],[1,0]],
        "n" : [[1,1],[0,1],[1,0]],
        "o" : [[1,0],[0,1],[1,0]],
        "p" : [[1,1],[1,0],[1,0]],
        "q" : [[1,1],[1,1],[1,0]],
        "r" : [[1,0],[1,1],[1,0]],
        "s" : [[0,1],[1,0],[1,0]],
        "t" : [[0,1],[1,1],[1,0]],
        "u" : [[1,0],[0,0],[1,1]],
        "v" : [[1,0],[1,0],[1,1]],
        "w" : [[0,1],[1,1],[0,1]],
        "x" : [[1,1],[0,0],[1,1]],
        "y" : [[1,1],[0,1],[1,1]],
        "z" : [[1,0],[0,1],[1,1]],
        "1" : [[1,0],[0,0],[0,0]],
        "2" : [[1,0],[1,0],[0,0]],
        "3" : [[1,1],[0,0],[0,0]],
        "4" : [[1,1],[0,1],[0,0]],
        "5" : [[1,0],[0,1],[0,0]],
        "6" : [[1,1],[1,0],[0,0]],
        "7" : [[1,1],[1,1],[0,0]],
        "8" : [[1,0],[1,1],[0,0]],
        "9" : [[0,1],[1,0],[0,0]],
        "0" : [[0,1],[1,1],[0,0]]
    ]
    
   
    
    var intDict: [[Int]] = [[0, 0], [0, 0], [0,0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func row1Col1Action(_ sender: Any) {
        if row1Col1.currentTitle! == "•" {
            row1Col1.setTitle("º", for: .normal)
            
            intDict[0][0] = 0
            
        }else {
            row1Col1.setTitle("•", for: .normal)
            intDict[0][0] = 1
        }
    }
    
    @IBAction func row1Col2Action(_ sender: Any) {
        if row1Col2.currentTitle! == "•" {
            row1Col2.setTitle("º", for: .normal)
            
            intDict[0][1] = 0

        }else {
            row1Col2.setTitle("•", for: .normal)
            
            intDict[0][1] = 1

        }
        
    }
    
    @IBAction func row2Col1(_ sender: Any) {
        if row2Col1.currentTitle! == "•" {
            row2Col1.setTitle("º", for: .normal)
            
            intDict[1][0] = 0

        }else {
            row2Col1.setTitle("•", for: .normal)
            
            intDict[1][0] = 1
        }
        
    }
    
    @IBAction func row2Col2(_ sender: Any) {
        if row2Col2.currentTitle! == "•" {
            row2Col2.setTitle("º", for: .normal)
            
            intDict[1][1] = 0

        }else {
            row2Col2.setTitle("•", for: .normal)
            intDict[1][1] = 1
        }
        
    }
    
    @IBAction func row3Col1(_ sender: Any) {
        if row3Col1.currentTitle! == "•" {
            row3Col1.setTitle("º", for: .normal)
            
            intDict[2][0] = 0

        }else {
            row3Col1.setTitle("•", for: .normal)
            
            intDict[2][0] = 1

        }
        
    }
    
    @IBAction func row3Col2(_ sender: Any) {
        if row3Col2.currentTitle! == "•" {
            row3Col2.setTitle("º", for: .normal)
            
            intDict[2][1] = 0

        }else {
            row3Col2.setTitle("•", for: .normal)
            
            intDict[2][1] = 1
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextAction" {
            let vc = segue.destination as! OutputLanguage
            vc.myStringValue = text
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        for letter in brailleDictionary.keys {
            
            if intDict.elementsEqual(brailleDictionary[letter]!) {
                text = letter
                
            }
            
        }
        
        performSegue(withIdentifier: "nextAction", sender: nil)
        
        
    }
    
    
    
}
