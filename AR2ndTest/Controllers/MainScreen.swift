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
        let SelectChapterVC = storyBoard.instantiateViewController(withIdentifier: "SelectChapter") as! SelectChapter
        SelectChapterVC.modalPresentationStyle = .fullScreen
        self.present(SelectChapterVC, animated: true, completion: nil)

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
