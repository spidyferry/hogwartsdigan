//
//  ParentGuide.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import AVFoundation

class ParentGuide: UIViewController {

    var buttonPressed = AVAudioPlayer()
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var whiteTransBg: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            buttonPressed = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource : "s_butt_GFP", ofType: "mp3")!))
        } catch {
            print(error)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeGuide(_ sender: Any) {
        buttonPressed.play()
        dismiss(animated: true, completion: nil)
    }
    
    
}
