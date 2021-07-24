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
    override func viewDidLoad() {
        super.viewDidLoad()

        let alphabetSuccess:String = UserDefaults.standard.string(forKey: "alphabetSuccess")!
        let line = self.loadtext(file: alphabetSuccess)
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
