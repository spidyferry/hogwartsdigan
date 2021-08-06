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
    
    var countTimer = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
//        Start Narration
        if (currentAlphabet == "A"){
        AudioNarration.shared.playSound(file: "narr_A")
        }
        else if (currentAlphabet == "B"){
            AudioNarration.shared.playSound(file: "narr_B")
        }
        else if (currentAlphabet == "C"){
            AudioNarration.shared.playSound(file: "narr_C")
        }

        
    }
    override func viewDidAppear(_ animated: Bool) {
        
       
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getSentece),userInfo: nil,repeats: true)
        timer.fire()
//        startNaration(script: sentence)
    }
    
    @objc
    func getSentece(){
        countTimer+=1
        
        let alphabetIntro:String = UserDefaults.standard.string(forKey: "alphabetIntro")!
        let line = self.loadtext(file: alphabetIntro)
        let sentence = line.split(separator: ";").map {String($0)}
        if countTimer/3 < sentence.count{
            self.bodyText.text = sentence[countTimer/3]
        }
        
    }
    
    
    func startNaration(script:Array<String>){
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
        
    }

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
    
    @IBAction func pauseButtTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioNarration.shared.pauseSound()
        AudioPausedTheme.shared.playSound()
        timer.invalidate()
    }
    
    func loadtext(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "no files"}
        return content
    }
    
}
