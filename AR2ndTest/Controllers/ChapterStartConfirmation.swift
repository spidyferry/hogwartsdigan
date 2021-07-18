//
//  ChapterStartConfirmation.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import Speech

class ChapterStartConfirmation: UIViewController{

    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func cancelChapter(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
