//
//  AlphabetSuccess.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class AlphabetSuccess: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var whiteTransBg: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 20
        whiteTransBg.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
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