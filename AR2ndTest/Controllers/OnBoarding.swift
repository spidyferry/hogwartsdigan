//
//  OnBoarding.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 14/07/21.
//

import UIKit

class OnBoarding: UIViewController {
    
    var userName = "Buddy"
    @IBOutlet weak var submitName: UIButton!
    @IBOutlet weak var inputName: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        submitName.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!appDelegate.hasAlreadyLaunched){
            appDelegate.sethasAlreadyLaunched()
//            print("Belum Pernah Jalan")
        }else{
            let MainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
            MainScreen.modalPresentationStyle = .fullScreen
            self.present(MainScreen, animated: false, completion: nil)
        }
    }
    
    
    
    @IBAction func saveUserName(_ sender: Any) {
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: true, completion: nil)
        let inputText = inputName.text
        userName = inputText!
        print("ini send dari button : \(userName)")
        saveDefaults(name: userName)

    }
    
    func saveDefaults(name:String){
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "userName")
        
        let user:String = defaults.string(forKey: "userName")!
        print("Ini di main screen : \(user)")
    }
    
}
