//
//  ChapterIntro.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class ChapterIntro: UIViewController {
    
    var textfile1 = ""

    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let line = self.loadtext(file: self.textfile1)
        let sentence = line.split(separator: ";").map {String($0)}
        startNaration(script: sentence)
    }
    
    func startNaration(script:Array<String>){
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            self.bodyText.text = script[0]
        }
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.bodyText.text = script[1]
        }
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { timer in
            self.bodyText.text = script[2]
        }
    }

    @IBAction func prevScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadtext(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "no files"}
        return content
    }
    

}
