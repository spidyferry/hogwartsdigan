//
//  OnBoarding.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 14/07/21.
//

import UIKit

class OnBoarding: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!appDelegate.hasAlreadyLaunched){
            appDelegate.sethasAlreadyLaunched()
//            print("Belum Pernah Jalan")
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let MainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
            MainScreen.modalPresentationStyle = .fullScreen
            self.present(MainScreen, animated: false, completion: nil)
            print("Udah Jalan")
        }
    }

}
