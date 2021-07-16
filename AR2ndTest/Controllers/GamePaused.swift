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
        continueButton.layer.cornerRadius = 20
        narationButton.layer.cornerRadius = 20
        mainMenuButton.layer.cornerRadius = 20
        quitButton.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePausedMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
