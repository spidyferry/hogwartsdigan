//
//  ARWordMission.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class ARWordMission: UIViewController {

    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var whiteTransBG: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bodyText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
        alphabetTitle.text = "The \(currentAlphabet)"
        let ARMission:String = UserDefaults.standard.string(forKey: "ARMission")!
        let line = self.loadtext(file: ARMission)
        let sentence = line.split(separator: ";").map {String($0)}
        startNaration(script: sentence)
    }
    
    func startNaration(script:Array<String>){
        for (index, element) in script.enumerated() {
          print("Item \(index): \(element)")
                
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
