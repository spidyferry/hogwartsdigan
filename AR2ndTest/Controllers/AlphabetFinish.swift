//
//  AlphabetFinish.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class AlphabetFinish: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishPerAlphabet(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "SelectChapter") as! SelectChapter
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: false, completion: nil)
    }
    

}
