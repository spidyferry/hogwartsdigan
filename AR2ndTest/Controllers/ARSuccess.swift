//
//  ARSuccess.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit

class ARSuccess: UIViewController {

    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
    var ARSuccessText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioCongrat.shared.playSound()
        AudioBGM.shared.playSound()

        self.ARSuccessText = UserDefaults.standard.string(forKey: "ARSuccess")!
        self.startNaration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioBGM.shared.startSound()
    }
    
    func startNaration() {
        let line = self.loadNarrationText(file: self.ARSuccessText)
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
    
    @IBAction func tryButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioBGM.shared.stopSound()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ARSuccessVC = storyBoard.instantiateViewController(withIdentifier: "ARSuccess") as! ARSuccess
        let WordRecognitionVC = storyBoard.instantiateViewController(withIdentifier: "WordRecognition") as! WordRecognition
        let navigationController = UINavigationController(rootViewController: ARSuccessVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        WordRecognitionVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(WordRecognitionVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        self.replayButton.isHidden = true
        self.startNaration()
    }
}
