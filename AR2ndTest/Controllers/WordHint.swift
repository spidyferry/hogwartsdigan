//
//  WordHint.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class WordHint: UIViewController {

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        prevButton.layer.cornerRadius = 20
        nextButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func prevScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
