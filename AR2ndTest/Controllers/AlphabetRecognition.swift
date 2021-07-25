//
//  AlphabetRecognition.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import AVFoundation
import Speech
import CoreData

class AlphabetRecognition: UIViewController, SFSpeechRecognizerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var alphabetCompleted:[AlphabetTable]?
    var alphabet = ""
    var alphabetSupposedToBe:String = ""

    @IBOutlet weak var theAlphabet: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var tryagainNotification: UIView!
    @IBOutlet weak var sayIt: UILabel!
    @IBOutlet weak var playAudio: UIButton!
    @IBOutlet weak var recognizeAlphabet: UIButton!
    var soundPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
        theAlphabet.text = currentAlphabet
        alphabetSupposedToBe = getValueForRecognition(alphabetName: "A")
        speechRecognizer.delegate = self
        prepareAudioPlayer()
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                isFinal = result.isFinal
                self.alphabet = result.bestTranscription.formattedString
                print("hasil teks \(self.alphabet)")
                self.checkingAlphabet()
            }
            
            
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
    }
    
    @IBAction func startSpeech(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            do {
                try startRecording()
                
                sayIt.isHidden = false
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        soundPlayer.play()
    }
    
    func prepareAudioPlayer(){
        let url = Bundle.main.url(forResource: "A", withExtension: "mp3")
        
        do{
            soundPlayer = try AVAudioPlayer(contentsOf: url!)
            soundPlayer.prepareToPlay()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func checkingAlphabet(){
//        let firstLetter = alphabet.prefix(1)
        
            print(alphabet)
        
        if (alphabet == alphabetSupposedToBe){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let MainScreen = storyBoard.instantiateViewController(withIdentifier: "AlphabetSuccess") as! AlphabetSuccess
            MainScreen.modalPresentationStyle = .fullScreen
            self.present(MainScreen, animated: false, completion: nil)
        } else {
            tryagainNotification.isHidden = false
        }
    }

    @IBAction func tryAgain(_ sender: Any) {
        tryagainNotification.isHidden = true
        sayIt.isHidden = true
    }
    
    func getValueForRecognition(alphabetName:String) -> String{
        var alphabetToRecognize:[AlphabetTable]?
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            let pred = NSPredicate(format: "alphabet == %@", alphabetName)
            request.predicate = pred
            alphabetToRecognize = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return alphabetToRecognize![0].alphabetRec!
    }
    
}
