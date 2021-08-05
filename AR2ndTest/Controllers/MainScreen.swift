//
//  MainScreen.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 14/07/21.
//

import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var guideButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserName()
    }
    
    func loadUserName(){
        let name = UserDefaults.standard.string(forKey: "userName")!
        userName.text = "Hi, \(name)"
    }
    
    @IBAction func getIsFinish(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "SelectChapter") as! SelectChapter
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: true, completion: nil)

    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        AudioNextTapped.shared.playSound()
    }
    
    @IBAction func guideButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
    }
    
    @IBAction func usernameButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
    }
}







//        MainScreen.alphabetCompleted = "sapi"
        
//        let defaults = UserDefaults.standard
//        let array = defaults.array(forKey: "alphabetCompleted")  as? [Bool] ?? [Bool]()
//        var currentIndex = 1
        
        
//        for _ in array{
//            if array[1] == true{
//                print("lulus")
//                break
//            }
//        }
        
//        for iscompleted in array
//        {
//            if iscompleted == true {
//                print("Found \(iscompleted) for index \(currentIndex)")
//                MainScreen.alphabetCompleted.append(currentIndex)
//            }
//            currentIndex += 1
//        }
//
//        if completedChapter.contains(9) {
//            print("yes")
//        }
        
//        if completedChapter.contains(8) {
//            return
//        }else{
//            print("bebek")
//        }
        
//        print(completedChapter)
