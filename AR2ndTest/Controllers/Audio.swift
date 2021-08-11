//
//  Audio.swift
//  AR2ndTest
//
//  Created by Ibrahim Nanang Purnawan on 05/08/21.
//

import Foundation
import AVFoundation

//Singleton BGM
class AudioBGM{
    static let shared = AudioBGM()
    
    var bgMusic = AVAudioPlayer()
    
    func playSound(){
        let bgmMusic = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_bgm", ofType: "wav")!)
        bgMusic = try! AVAudioPlayer(contentsOf: bgmMusic as URL)
        bgMusic.prepareToPlay()
        bgMusic.numberOfLoops = -1
        bgMusic.play()
        bgMusic.volume = 0.5
    }
    
    func stopSound(){
        bgMusic.stop()
    }
    
    func pauseSound(){
        bgMusic.pause()
    }
    
    func startSound(){
        bgMusic.play()
        bgMusic.volume = 0.5
    }
}

//Singleton Button Tapped NEXT
class AudioNextTapped{
    static let shared = AudioNextTapped()
    
    var buttNextTapped = AVAudioPlayer()
    
    func playSound(){
        let audioButtNextTapped = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_butt_pressed", ofType: "mp3")!)
        buttNextTapped = try! AVAudioPlayer(contentsOf: audioButtNextTapped as URL)
        buttNextTapped.prepareToPlay()
        buttNextTapped.numberOfLoops = 0
        buttNextTapped.play()
    }
       
    func startSound(){
        buttNextTapped.play()
    }
}

//Singleton Button PREVIOUS
class AudioPrevTapped{
    static let shared = AudioPrevTapped()
    
    var buttPrevTapped = AVAudioPlayer()
    
    func playSound(){
        let audioButtPrevTapped = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_butt_paused", ofType: "mp3")!)
        buttPrevTapped = try! AVAudioPlayer(contentsOf: audioButtPrevTapped as URL)
        buttPrevTapped.prepareToPlay()
        buttPrevTapped.numberOfLoops = 0
        buttPrevTapped.play()
    }
    
    func startSound(){
        buttPrevTapped.play()
    }
}
//Singleton Narration
class AudioNarration{
    static let shared = AudioNarration()
    
    var narrAudio = AVAudioPlayer()
    
    func playSound(file: String){
        AudioSession.shared.setAudioSession(active: true)
        
        let narrationAudio = NSURL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp3")!)
        narrAudio = try! AVAudioPlayer(contentsOf: narrationAudio as URL)
        narrAudio.prepareToPlay()
        narrAudio.numberOfLoops = 0
        narrAudio.play()
//        narrAudio.volume = 1
    }
    
    func stopSound(){
        narrAudio.stop()
    }
    
    func pauseSound(){
        narrAudio.pause()
    }
//    func continueSound(){
//        narrAudio.continue()
//    }
    
    func startSound(){
        AudioSession.shared.setAudioSession(active: true)
        narrAudio.play()
    }
}

//  Singleton Audio Paused Theme
class AudioPausedTheme{
    static let shared = AudioPausedTheme()
    
    var pausedTheme = AVAudioPlayer()
    
    func playSound(){
        AudioSession.shared.setAudioSession(active: true)
        
        let pausedThemeAudio = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_paused_theme", ofType: "mp3")!)
        pausedTheme = try! AVAudioPlayer(contentsOf: pausedThemeAudio as URL)
        pausedTheme.prepareToPlay()
        pausedTheme.numberOfLoops = -1
        pausedTheme.play()
        pausedTheme.volume = 0.5
    }
      
    func startSound(){
        AudioSession.shared.setAudioSession(active: true)
        pausedTheme.play()
    }
    func stopSound(){
        pausedTheme.stop()
    }
}

//  Singleton Congratulations Yay!
class AudioCongrat{
    static let shared = AudioCongrat()
    
    var congratAudio = AVAudioPlayer()
    
    func playSound(){
        AudioSession.shared.setAudioSession(active: true)
        
        let audioCongrat = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_congrat", ofType: "mp3")!)
        congratAudio = try! AVAudioPlayer(contentsOf: audioCongrat as URL)
        congratAudio.prepareToPlay()
        congratAudio.numberOfLoops = 0
        congratAudio.play()
        congratAudio.volume = 0.5
    }
      
    func startSound(){
        AudioSession.shared.setAudioSession(active: true)
        congratAudio.play()
    }
    func stopSound(){
        congratAudio.stop()
    }
}

// Singleton Audio Session
class AudioSession {
    static let shared = AudioSession()

    func setAudioSession(active: Bool) {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(AVAudioSession.Category.soloAmbient)
            try audioSession.setActive(active, options: .notifyOthersOnDeactivation)
        } catch {
            print("Error set audio session: \(error)")
        }
    }
}
