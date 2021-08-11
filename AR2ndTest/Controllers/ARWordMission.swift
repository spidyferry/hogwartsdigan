//
//  ARWordMission.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class ARWordMission: UIViewController {

    @IBOutlet weak var alphabetTitle: UILabel!
    @IBOutlet weak var whiteTransBG: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var replayButton: UIButton!
    
    var ARMissionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentAlphabet     = UserDefaults.standard.string(forKey: "currentAlphabet")!
        self.alphabetTitle.text = "The \(currentAlphabet)"
        
        self.ARMissionText = UserDefaults.standard.string(forKey: "ARMission")!
        self.startNaration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioBGM.shared.startSound()
    }
    
    func startNaration() {
        let line = self.loadNarrationText(file: self.ARMissionText)
        var sentence = line.split(separator: ";").map {String($0)}
        
        sentence.removeLast()
        
        for (index, element) in sentence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0*Double(index)) {
                self.bodyText.text = element
                
                if index == (sentence.count - 1) {
                    self.replayButton.isHidden = false
                }
            }
        }
    }
    
    func loadNarrationText(file:String) -> String{
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
            let content = try? String(contentsOfFile: path) else {return "There is no file for narration"}
        
        return content
    }

    @IBAction func pauseButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.playSound()
        AudioBGM.shared.pauseSound()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ARWordMissionVC = storyBoard.instantiateViewController(withIdentifier: "ARWordMission") as! ARWordMission
        let ARVC = storyBoard.instantiateViewController(withIdentifier: "ARViewController") as! ViewController
        let navigationController = UINavigationController(rootViewController: ARWordMissionVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
        
        ARVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(ARVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        self.replayButton.isHidden = true
        self.startNaration()
    }
}
