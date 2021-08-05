//
//  ParentGuide.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class ParentGuide: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var whiteTransBg: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    @IBAction func closeGuide(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        dismiss(animated: true, completion: nil)
    }
    
    
}
