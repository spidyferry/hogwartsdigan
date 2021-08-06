//
//  OnBoardingLoading.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import AVFoundation

class OnBoardingLoading: UIViewController {

    let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "OnBoarding") as! OnBoarding
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: false, completion: nil)
    }

}
