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
    override func viewDidLoad() {
        super.viewDidLoad()

        let ARSuccess:String = UserDefaults.standard.string(forKey: "ARSuccess")!
        let line = self.loadtext(file: ARSuccess)
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
    
    func loadtext(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "no files"}
        return content
    }

}
