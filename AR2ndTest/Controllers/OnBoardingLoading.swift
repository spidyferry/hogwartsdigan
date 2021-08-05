//
//  OnBoardingLoading.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import AVFoundation

class OnBoardingLoading: UIViewController {

//    var onBoardingAudio = AVAudioPlayer()
    let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        BGM
//        let onBoardAudio = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_launch", ofType: "mp3")!)
//        onBoardingAudio = try! AVAudioPlayer(contentsOf: onBoardAudio as URL)
//        onBoardingAudio.prepareToPlay()
//        onBoardingAudio.numberOfLoops = 0
//        onBoardingAudio.play()
//        onBoardingAudio.volume = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "OnBoarding") as! OnBoarding
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: false, completion: nil)
    }

}
