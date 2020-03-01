//
//  OutputLanguage.swift
//  Sermo
//
//  Created by Ishan Jain on 2/22/20.
//  Copyright © 2020 Ishan Jain. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class OutputLanguage: UIViewController {

    var myStringValue:String?
    var speechSynthesizer = AVSpeechSynthesizer()

    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var signLanguage: UIButton!
    @IBOutlet weak var brailleButton: UIButton!
    
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textButton.backgroundColor = .clear
        textButton.layer.cornerRadius = 15
        textButton.layer.borderWidth = 1
        textButton.layer.borderColor = UIColor.systemBlue.cgColor
        textButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        
        speechButton.backgroundColor = .clear
        speechButton.layer.cornerRadius = 15
        speechButton.layer.borderWidth = 1
        speechButton.layer.borderColor = UIColor.systemBlue.cgColor
        speechButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        
        signLanguage.backgroundColor = .clear
        signLanguage.layer.cornerRadius = 15
        signLanguage.layer.borderWidth = 1
        signLanguage.layer.borderColor = UIColor.systemBlue.cgColor
        signLanguage.layer.backgroundColor = UIColor.systemBlue.cgColor
        
        brailleButton.backgroundColor = .clear
        brailleButton.layer.cornerRadius = 15
        brailleButton.layer.borderWidth = 1
        brailleButton.layer.borderColor = UIColor.systemBlue.cgColor
        brailleButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 10
        
        
    }
    
    @IBAction func textOutput(_ sender: Any) {
        alertViewFunc(title: "Output Text Data", message: myStringValue!)
    }
    
    @IBAction func speechOutput(_ sender: Any) {
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: myStringValue!)
        //var speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: myStringValue!)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0

        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)

    }
    
    @IBAction func signOutput(_ sender: Any) {

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

        var returnArr: [String] = []
        
        var braille = ""

        let dots = brailleDictionary[myStringValue!]

        for array in dots! {
            for element in array {
                if element == 1 {
                    braille += "•"
                }
                else if element == 0 {
                    braille += "o"
                }
                braille += " "
            }
            
            braille += "\n"
        }
        
        alertViewFunc(title: "Braille Output", message: braille)
    }
    
    @IBAction func brailleOutput(_ sender: Any) {
        
        for char in myStringValue! {
            print(char)
            
            if (char == "-") {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            }
            
            else if char == "." {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            }
            
        }
    }
    
    func alertViewFunc(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
