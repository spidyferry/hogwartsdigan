//
//  ChapterIntro.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class ChapterIntro: UIViewController {
    
    var textfile = ""

    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bodyText.text = loadtext(file: textfile)
    }

    @IBAction func prevScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadtext(file:String) -> String{
        if let path = Bundle.main.path(forResource: file, ofType: "txt"){
            if let content = try? String(contentsOfFile: path){
                return content
            }else{
                print("The file doesn't has any text")
            }
        }else{
            print("File doesn't exist")
        }
        return ""
    }
    

}
