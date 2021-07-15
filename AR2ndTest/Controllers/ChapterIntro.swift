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
        whiteTransBg.layer.cornerRadius = 20
        prevButton.layer.cornerRadius = 20
        nextButton.layer.cornerRadius = 20

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
