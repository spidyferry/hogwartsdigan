//
//  MainScreen.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 14/07/21.
//

import UIKit
import CoreData

class MainScreen: UIViewController {
    

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var guideButton: UIButton!
//    let value = UIInterfaceOrientation.landscapeLeft.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 20
        guideButton.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }
    
    func loadUserName(){
        let sapi = UserDefaults.standard.string(forKey: "userName")!
        print("Di load setelah masuk app : \(sapi)")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        UIDevice.current.setValue(value, forKey: "orientation")
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .landscapeLeft
//    }
//
//    override var shouldAutorotate: Bool{
//        return false
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        return .landscapeLeft
//    }

}
