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
    var recAlphabet = AVAudioPlayer()
    var soundPlayer : AVAudioPlayer!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var alphabetCompleted:[AlphabetTable]?
    var alphabet = ""
    var alphabetSupposedToBe: String = ""
    var success: Bool = false
    var currentAlphabet: String = ""

    @IBOutlet weak var theAlphabet: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var tryagainNotification: UIView!
    @IBOutlet weak var sayIt: UILabel!
    @IBOutlet weak var playAudio: UIButton!
    @IBOutlet weak var recognizeAlphabet: UIButton!
    @IBOutlet weak var recordShadow1: UIView!
    @IBOutlet weak var recordShadow2: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentAlphabet             = UserDefaults.standard.string(forKey: "currentAlphabet")!
        theAlphabet.text            = currentAlphabet
        alphabetSupposedToBe        = getValueForRecognition(alphabetName: currentAlphabet)
        speechRecognizer.delegate   = self
        
        prepareAudioPlayer()
        
        // Set record shadow corner radius
        recordShadow1.layer.cornerRadius = 20
        recordShadow2.layer.cornerRadius = 20
        
        // Hide record shadow
        self.recordShadow1.layer.opacity = 0
        self.recordShadow2.layer.opacity = 0
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
                print("Result: \(self.alphabet)")
                self.checkingAlphabet()
            }
            
            // Stop recognizing speech if there is a problem.
            if error != nil || isFinal {
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
        
        do {
            try audioEngine.start()
        } catch let error {
            print("Error on start recording: \(error)")
        }
    }
    
    @IBAction func startSpeech(_ sender: Any) {
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.stopRecordAnimation()
        } else {
            do {
                try startRecording()
                self.startRecordAnimation()

                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    self.audioEngine.stop()
                    self.audioEngine.inputNode.removeTap(onBus: 0)
                    self.recognitionRequest?.endAudio()
                    self.stopRecordAnimation()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        AudioSession.shared.setAudioSession(active: true)
        self.soundPlayer.play()
    }
    
    func prepareAudioPlayer() {
        let url = Bundle.main.url(forResource: self.currentAlphabet, withExtension: "mp3")
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url!)
            soundPlayer.prepareToPlay()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func checkingAlphabet() {
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        self.stopRecordAnimation()
        
        if (alphabet == alphabetSupposedToBe) {
            if self.success == false {
                self.nextPage()
                self.success = true
            }
        } else {
            self.stopRecordAnimation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tryagainNotification.isHidden = false
            }
        }
    }

    @IBAction func tryAgain(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        tryagainNotification.isHidden = true
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
    
    func startRecordAnimation() {
        self.recognizeAlphabet.isEnabled = false
        
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [.repeat]) {
            // 1st Keyframe
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                self.recognizeAlphabet.backgroundColor = UIColor(red: 25.0/255.0, green: 67.0/255.0, blue: 80/255.0, alpha: 1)
            }

            // 2nd Keyframe
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                self.recordShadow1.layer.opacity = 1
            }

            // 3rd Keyframe
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.6) {
                self.recordShadow2.layer.opacity = 1
            }
        } completion: { isComplete in
            if isComplete {
                //
            }
        }
    }
    
    func stopRecordAnimation() {
        self.recognizeAlphabet.isEnabled = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: []) {
            self.recordShadow2.layer.opacity = 0
            self.recordShadow1.layer.opacity = 0
            self.recognizeAlphabet.backgroundColor = UIColor(red: 245.0/255.0, green: 134.0/255.0, blue: 52/255.0, alpha: 1)
        } completion: { isComplete in
            if isComplete {
                //
            }
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        self.nextPage()
    }
    
    func nextPage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let AlphabetRecognitionVC = UIViewController()
        let AlphabetSuccessVC = storyBoard.instantiateViewController(withIdentifier: "AlphabetSuccess") as! AlphabetSuccess
        let navigationController = UINavigationController(rootViewController: AlphabetRecognitionVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        AlphabetSuccessVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(AlphabetSuccessVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    @IBAction func pauseButtTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.playSound()
    }
}
