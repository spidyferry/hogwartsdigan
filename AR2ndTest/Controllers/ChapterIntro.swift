//
//  ChapterIntro.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class ChapterIntro: UIViewController {
    
    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
    var titleChapter: String = ""
    var currentAlphabet: String = ""
    var countTimer = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentAlphabet    = UserDefaults.standard.string(forKey: "currentAlphabet")!
        self.alphabetTitle.text = titleChapter
        
//         Start Narration
        if(self.currentAlphabet != "") {
            AudioNarration.shared.playSound(file: "narr_\(self.currentAlphabet)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioNarration.shared.startSound()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getSentece),userInfo: nil,repeats: true)
        self.timer.fire()
    }
    
    @objc func getSentece() {
        countTimer += 1
        
        let alphabetIntro:String = UserDefaults.standard.string(forKey: "alphabetIntro")!
        let line = self.loadNarrationText(file: alphabetIntro)
        let sentence = line.split(separator: ";").map {String($0)}
        
        if countTimer/3 < sentence.count{
            self.bodyText.text = sentence[countTimer/3]
        }
        
        if countTimer/3 > sentence.count{
            self.replayButton.isHidden = false
            self.timer.invalidate()
        }
    }
    
    
//    func startNaration(script:Array<String>){
//        for (index, element) in script.enumerated() {
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0*Double(index)) {
//                print("Item \(index): \(element)")
//                self.bodyText.text = script[index]
//            }
//        }
        
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
//            self.bodyText.text = script[0]
//        }
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
//            self.bodyText.text = script[1]
//        }
        
//    }

    @IBAction func prevScreen(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioNarration.shared.stopSound()
        AudioBGM.shared.playSound()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioNarration.shared.stopSound()
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioNarration.shared.pauseSound()
        AudioPausedTheme.shared.playSound()
        
        self.timer.invalidate()
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        if(self.currentAlphabet != "") {
            AudioNarration.shared.playSound(file: "narr_\(self.currentAlphabet)")
        }
        
        self.countTimer = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getSentece),userInfo: nil,repeats: true)
        self.timer.fire()
        
        self.replayButton.isHidden = true
    }
    
    func loadNarrationText(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "There is no file for narration"}
        
        return content
    }
}
