//
//  OnBoardingLoading.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class OnBoardingLoading: UIViewController {

    let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "OnBoarding") as! OnBoarding
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: false, completion: nil)

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
