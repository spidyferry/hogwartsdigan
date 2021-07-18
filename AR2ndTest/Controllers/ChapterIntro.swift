//
//  ChapterIntro.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class ChapterIntro: UIViewController {

    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func prevScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
