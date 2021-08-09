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
    
    var countTimer = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioCongrat.shared.playSound()
        AudioBGM.shared.playSound()
        
//        let alphabetSuccess:String = UserDefaults.standard.string(forKey: "alphabetSuccess")!
//        let line = self.loadNarrationText(file: alphabetSuccess)
//        let sentence = line.split(separator: ";").map {String($0)}
//        startNaration(script: sentence)
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
        let line = self.loadNarrationText(file: alphabetIntro)
        let sentence = line.split(separator: ";").map {String($0)}
        if countTimer/3 < sentence.count{
            self.bodyText.text = sentence[countTimer/3]
        }
//        if countTimer/3 > sentence.count{
//            repeatButton.isHidden = false
//        }
    }
    
//    func startNaration(script:Array<String>){
//        for (index, element) in script.enumerated() {
//          print("Item \(index): \(element)")
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0*Double(index)) {
//                self.bodyText.text = script[index]
//            }
//        }
//    }
    
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
        self.replayButton.isHidden = true
//        self.startNaration()
    }
}
