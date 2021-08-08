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
        
    }
    
    @IBAction func closePausedMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func contButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.stopSound()
//        AudioNarration.shared.playSound(file: "")
    }
    
    @IBAction func narrButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.stopSound()
    }
    
    @IBAction func mainMenuButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioBGM.shared.playSound()
        AudioPausedTheme.shared.stopSound()
    }
    
    @IBAction func quitButtonTapped(_ sender: Any) {
        AudioPrevTapped.shared.playSound()
        AudioBGM.shared.playSound()
        AudioPausedTheme.shared.stopSound()
    }
    
}
