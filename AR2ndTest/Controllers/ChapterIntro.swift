//
//  ChapterIntro.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class ChapterIntro: UIViewController {
    
    var textfile1 = ""
    var textfile2 = ""
    var textfile3 = ""

    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startNaration()
    }
    
    func startNaration(){
        self.bodyText.text = loadtext(file: textfile1)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.bodyText.text = self.loadtext(file: self.textfile2)
        }
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { timer in
            self.bodyText.text = self.loadtext(file: self.textfile3)
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
