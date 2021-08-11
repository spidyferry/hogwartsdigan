//
//  AlphabetSuccess.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class AlphabetSuccess: UIViewController {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var replayButton: UIButton!
    
    var alphabetSuccess: String = ""
    var currentAlphabet: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioCongrat.shared.playSound()
        AudioBGM.shared.playSound()
        
        self.currentAlphabet    = UserDefaults.standard.string(forKey: "currentAlphabet")!
        self.alphabetSuccess = UserDefaults.standard.string(forKey: "alphabetSuccess")!
        self.startNaration()
        
        if(self.currentAlphabet != "") {
            AudioNarration.shared.playSound(file: "s_congrat_\(self.currentAlphabet)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioBGM.shared.startSound()
    }
    
    func startNaration() {
        let line = self.loadNarrationText(file: self.alphabetSuccess)
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
    
    @IBAction func pauseMenuTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.playSound()
        AudioBGM.shared.pauseSound()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioNarration.shared.stopSound()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let AlphabetSuccessVC = UIViewController()
        let WordHintVC = storyBoard.instantiateViewController(withIdentifier: "WordHint") as! WordHint
        let navigationController = UINavigationController(rootViewController: AlphabetSuccessVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        WordHintVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(WordHintVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        if(self.currentAlphabet != "") {
            AudioNarration.shared.playSound(file: "s_congrat_\(self.currentAlphabet)")
        }
        
        self.replayButton.isHidden = true
        self.startNaration()
    }
}
