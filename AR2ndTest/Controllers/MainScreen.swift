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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
