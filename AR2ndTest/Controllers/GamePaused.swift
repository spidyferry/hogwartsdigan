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
    @IBOutlet weak var narrationSymbol: UIImageView!
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func contButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.stopSound()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func narrButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        
        let currentState = UserDefaults.standard.string(forKey: "navigationVoice") ?? nil
        
        if currentState == "1" {
            defaults.set("0", forKey: "navigationVoice")
            narrationSymbol.image = UIImage(systemName: "speaker.slash.fill")
        } else {
            defaults.set("1", forKey: "navigationVoice")
            narrationSymbol.image = UIImage(systemName: "speaker.wave.3.fill")
        }
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
