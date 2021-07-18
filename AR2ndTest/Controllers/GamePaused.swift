//
//  GamePaused.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class GamePaused: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var narationButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePausedMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
