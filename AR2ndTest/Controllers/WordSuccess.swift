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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_bgm", ofType: "wav")!)
        audioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        let wordSuccess:String = UserDefaults.standard.string(forKey: "wordSuccess")!
        let line = self.loadtext(file: wordSuccess)
        let fields = line.split(separator: ";").map {String($0)}
        startNaration(script: fields)
    }
    
    func startNaration(script:Array<String>){
        for (index, element) in script.enumerated() {
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0*Double(index)) {
                self.bodyText.text = script[index]
            }
        }
    }
    
    func loadtext(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "no files"}
        return content
    }

}
