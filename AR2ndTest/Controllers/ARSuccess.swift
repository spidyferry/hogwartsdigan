//
//  ARSuccess.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class ARSuccess: UIViewController {

    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
    var ARSuccessText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioCongrat.shared.playSound()
        AudioBGM.shared.playSound()

        self.ARSuccessText = UserDefaults.standard.string(forKey: "ARSuccess")!
        self.startNaration()
    }
    
    func startNaration() {
        let line = self.loadNarrationText(file: self.ARSuccessText)
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

    @IBAction func pauseButtonTapped(_ sender: Any) {
        AudioPausedTheme.shared.playSound()
    }
    
    @IBAction func tryButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        self.replayButton.isHidden = true
        self.startNaration()
    }
}
