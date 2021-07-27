//
//  OnBoarding.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 14/07/21.
//

import UIKit
import CoreData
import AVFoundation

class OnBoarding: UIViewController {
    
    var userName = "Duck-Duck DC"
    var audioPlayer = AVAudioPlayer()
    
    let defaults = UserDefaults.standard
    let theAlphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let theWords = ["Apple", "Basket", "Chocolate", "Duck", "Ear", "Feather", "Girrafe", "Hen", "Ice Cream", "Jelly", "Kiwi", "Lion", "Mango", "Nib", "Orange", "Penguin", "Queen", "Rooster", "Star", "Tree", "Umbrella", "Vase", "Well", "Xylophone", "Yoghurt", "Zebra"]
    let alphaRec = ["Hey", "B", "See", "D", "E", "F", "G", "Age", "Hi", "J", "OK", "L", "I am", "And", "Oh", "P", "Cue", "Are", "Yes", "T", "You", "Fee", "W", "The X", "Why", "Z"]
    let WRec = ["Apple", "Basket", "Chocolate", "Duck", "Ear", "Feather", "Girrafe", "Hen", "Ice Cream", "Jelly", "Kiwi", "Lion", "Mango", "Nib", "Orange", "Penguin", "Queen", "Rooster", "Star", "Tree", "Umbrella", "Vase", "Well", "Xylophone", "Yoghurt", "Zebra"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alphabetCompleted:[AlphabetTable]?
    
    @IBOutlet weak var submitName: UIButton!
    @IBOutlet weak var inputName: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //BGM
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "s_bgm", ofType: "wav")!)
        audioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        audioPlayer.volume = 0.5
        
        defaults.set(alphabetCompleted, forKey: "alphabetCompleted")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!appDelegate.hasAlreadyLaunched){
            appDelegate.sethasAlreadyLaunched()
        }else{
            let MainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
            MainScreen.modalPresentationStyle = .fullScreen
            self.present(MainScreen, animated: false, completion: nil)
        }
    }
    
    @IBAction func saveUserName(_ sender: Any) {
        if(inputName.text?.isEmpty == true){
            let MainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
            MainScreen.modalPresentationStyle = .fullScreen
            self.present(MainScreen, animated: true, completion: nil)
            saveDefaults(name: userName)
        }else{
            let MainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
            MainScreen.modalPresentationStyle = .fullScreen
            self.present(MainScreen, animated: true, completion: nil)
            let inputText = inputName.text
            userName = inputText!
            print("ini send dari button : \(userName)")
            saveDefaults(name: userName)
        }
    }
    
    func saveDefaults(name:String){
        defaults.set(name, forKey: "userName")
        
        for (index, element) in theAlphabets.enumerated() {
            let newRecords = AlphabetTable(context: self.context)
            newRecords.alphabet = element
            newRecords.date = Date()
            newRecords.isCompleted = false
            newRecords.alphabetRec = alphaRec[index]
            newRecords.wordRec = WRec[index]
            newRecords.word = theWords[index]
            do{
                try self.context.save()
            }catch{
                print("error init database \(error.localizedDescription)")
            }
        }
    }
    
}
