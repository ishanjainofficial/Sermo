//
//  ViewController.swift
//  Sermo
//
//  Created by Ishan Jain on 2/22/20.
//  Copyright © 2020 Ishan Jain. All rights reserved.
//

import UIKit
import Speech
import CoreML

class ViewController: UIViewController, SFSpeechRecognizerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var signLanguage: UIButton!
    @IBOutlet weak var brailleButton: UIButton!
    
    
    @IBOutlet weak var mainView: UIView!
    
    var text:String = ""
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))  //1
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var model: ASL_MODEL_1!
     
    override func viewWillAppear(_ animated: Bool) {
        model = ASL_MODEL_1()
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOutput" {
            let vc = segue.destination as! OutputLanguage
            vc.myStringValue = text
        }
    }

    @IBAction func textAction(_ sender: Any) {
    
        let alert = UIAlertController(title: "Input Text", message: "Write the text that you would like as your input data", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler:{ (UIAlertAction) in
            
            self.text = self.textField!.text!
            self.performSegue(withIdentifier: "toOutput", sender: nil)
            
            print(self.text)

        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func speechAction(_ sender: Any) {
        requestTranscribePermissions()
        
        
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            speechButton.isEnabled = false
            speechButton.setTitle("Start Recording", for: .normal)

        } else {
            startRecording()
            speechButton.setTitle("Stop Recording", for: .normal)
            self.performSegue(withIdentifier: "toOutput", sender: nil)
        }
        
        
    }
    
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Good to go!")
                } else {
                    print("Transcription permission was declined.")
                }
            }
        }
    }
    
    @IBAction func brailleLanguage(_ sender: Any) {
        performSegue(withIdentifier: "braille", sender: nil)
    }
    
    @IBAction func signLanguage(_ sender: Any) {
        //performSegue(withIdentifier: "toOutput", sender: nil)
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker, animated: true)
    }
    
    var textField: UITextField?

    func configurationTextField(textField: UITextField!) {
        if (textField) != nil {
            self.textField = textField!        //Save reference to the UITextField
            self.textField?.placeholder = ""
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            
            if result != nil {
                
                self.text = (result?.bestTranscription.formattedString)!
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        processImage(image)
        
    }
    
    func processImage(_ image: UIImage) {
        let model = ASL_MODEL_1()
        let size = CGSize(width: 299, height: 299)
        
        
        guard let buffer = image.resize(to: size)?.pixelBuffer() else {
            fatalError("Scaling or converting to pixel buffer failed!")
        }
        
        guard let result = try? model.prediction(image: buffer) else {
            fatalError("Prediction failed!")
        }
        
        //let confidence = result.foodConfidence["\(result.classLabel)"]! * 100.0
        //let converted = String(format: "%.2f", confidence)
        
        text = result.classLabel
        
        performSegue(withIdentifier: "toOutput", sender: nil)
        print(result.classLabel)
    }
}

