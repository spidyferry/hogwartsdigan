//
//  OnBoarding.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 14/07/21.
//

import UIKit
import CoreData

class OnBoarding: UIViewController {
    
    var userName = "Duck-Duck DC"
    let defaults = UserDefaults.standard
    let theAlphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let theWords = ["Apple", "Basket", "Chocolate", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let alphaRec = ["Hey", "B", "See", "D", "E", "F", "G", "Age", "Hi", "J", "OK", "L", "I am", "And", "Oh", "P", "Cue", "Are", "Yes", "T", "You", "Fee", "W", "The X", "Why", "Z"]
    let WRec = ["Apple", "Basket", "Chocolate", "The D", "The E", "The F", "The G", "The H", "The I", "The J", "The K", "The L", "The M", "The N", "The O", "The P", "The Q", "The R", "The S", "The T", "The U", "The V", "The W", "The X", "The Y", "The Z"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alphabetCompleted:[AlphabetTable]?
    
    @IBOutlet weak var submitName: UIButton!
    @IBOutlet weak var inputName: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
