//
//  AlphabetSuccess.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class AlphabetSuccess: UIViewController {

    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var replayButton: UIButton!
    
    var alphabetSuccess: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alphabetSuccess = UserDefaults.standard.string(forKey: "alphabetSuccess")!
        
        startNaration()
    }
    
    func startNaration() {
        AudioCongrat.shared.playSound()
        
        let line = self.loadNarrationText(file: self.alphabetSuccess)
        let sentence = line.split(separator: ";").map {String($0)}
        
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
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        self.startNaration()
    }
}
