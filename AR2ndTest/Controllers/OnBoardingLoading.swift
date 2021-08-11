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
        let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let OnBoardingLoadingVC = storyBoard.instantiateViewController(withIdentifier: "OnBoardingLoading") as! OnBoardingLoading
        let OnBoardingVC = storyBoard.instantiateViewController(withIdentifier: "OnBoarding") as! OnBoarding
        let navigationController = UINavigationController(rootViewController: OnBoardingLoadingVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        OnBoardingVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(OnBoardingVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
}
