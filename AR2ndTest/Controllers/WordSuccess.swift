//
//  WordSuccess.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit
import AVFoundation

class WordSuccess: UIViewController {

    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
    var wordSuccessText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioCongrat.shared.playSound()
        AudioBGM.shared.playSound()
        
        self.wordSuccessText = UserDefaults.standard.string(forKey: "wordSuccess")!
        self.startNaration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioBGM.shared.startSound()
    }
    
    func startNaration() {
        let line = self.loadNarrationText(file: self.wordSuccessText)
        var sentence = line.split(separator: ";").map {String($0)}
        
        sentence.removeLast()
        
        for (index, element) in sentence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0*Double(index)) {
                self.bodyText.text = element
                
                if index == (sentence.count - 1) {
                    self.replayButton.isHidden = false
                }
            }
        }
    }
    
    func loadNarrationText(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "There is no file for narration"}
        
        return content
    }

    @IBAction func pauseButtonTapped(_ sender: Any) {AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.playSound()
        AudioBGM.shared.pauseSound()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let WordSuccessVC = storyBoard.instantiateViewController(withIdentifier: "WordSuccess") as! WordSuccess
        let AlphabetFinishVC = storyBoard.instantiateViewController(withIdentifier: "AlphabetFinish") as! AlphabetFinish
        let navigationController = UINavigationController(rootViewController: WordSuccessVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        AlphabetFinishVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(AlphabetFinishVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        self.replayButton.isHidden = true
        self.startNaration()
    }
}
