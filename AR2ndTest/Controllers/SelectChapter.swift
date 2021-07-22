//
//  SelectChapter.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class SelectChapter: UIViewController {

    @IBOutlet weak var chapterBack: UIButton!
    @IBOutlet weak var chapterNext: UIButton!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func chapter1Selected(_ sender: Any) {
        defaults.set(1, forKey: "chapterSelected")
    }
    
}

