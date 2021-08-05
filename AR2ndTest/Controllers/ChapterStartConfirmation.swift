//
//  ChapterStartConfirmation.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import CoreData

class ChapterStartConfirmation: UIViewController{
    
    var alphabet = ""
    var titleChapter: String = ""
    
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alphabetCompleted:[AlphabetTable]?

    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var instructionText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioNarration.shared.stopSound()
        
        // Change title chapter
        self.titleLabel.text = titleChapter
        
        let selectedChapter = UserDefaults.standard.integer(forKey: "chapterSelected")
        switch selectedChapter{
        case 1 :
            prepareDataforCurrentChapter(first: "A", second: "B", third: "C")
        case 2 :
            prepareDataforCurrentChapter(first: "D", second: "E", third: "F")
        case 3 :
            prepareDataforCurrentChapter(first: "G", second: "H", third: "I")
        case 4 :
            prepareDataforCurrentChapter(first: "J", second: "K", third: "L")
        case 5 :
            prepareDataforCurrentChapter(first: "M", second: "N", third: "O")
        case 6 :
            prepareDataforCurrentChapter(first: "P", second: "Q", third: "R")
        case 7 :
            prepareDataforCurrentChapter(first: "S", second: "T", third: "U")
        case 8 :
            prepareDataforCurrentChapter(first: "V", second: "W", third: "X")
        case 9 :
            prepareDataforCurrentChapter(first: "Y", second: "Z", third: "Z")
            
        default:
            print("default")
        }
    }
    
    func prepareDataforCurrentChapter (first:String, second:String, third: String){
        let firstIsComplete = fetchAlphabet(alphabetName: first)
        let secondIsComplete = fetchAlphabet(alphabetName: second)
        let thirdIsComplete = fetchAlphabet(alphabetName: third)
        
        if (firstIsComplete == false && secondIsComplete == false && thirdIsComplete == false){
            alphabet = first
            defaults.set(first, forKey: "currentAlphabet")
            defaults.set("\(first)alphabetIntro", forKey: "alphabetIntro")
            defaults.set("\(first)alphabetSuccess", forKey: "alphabetSuccess")
            defaults.set("\(first)ARMission", forKey: "ARMission")
            defaults.set("\(first)ARSuccess", forKey: "ARSuccess")
            defaults.set("\(first)wordSuccess", forKey: "wordSuccess")
        }else if (firstIsComplete == true && secondIsComplete == false && thirdIsComplete == false){
            alphabet = second
            defaults.set(second, forKey: "currentAlphabet")
            defaults.set("\(second)alphabetIntro", forKey: "alphabetIntro")
            defaults.set("\(second)alphabetSuccess", forKey: "alphabetSuccess")
            defaults.set("\(second)ARMission", forKey: "ARMission")
            defaults.set("\(second)ARSuccess", forKey: "ARSuccess")
            defaults.set("\(second)wordSuccess", forKey: "wordSuccess")
            instructionText.text = "Do you want to continue?"
        }else if (firstIsComplete == true && secondIsComplete == true && thirdIsComplete == false){
            alphabet = third
            defaults.set(third, forKey: "currentAlphabet")
            defaults.set("\(third)alphabetIntro", forKey: "alphabetIntro")
            defaults.set("\(third)alphabetSuccess", forKey: "alphabetSuccess")
            defaults.set("\(third)ARMission", forKey: "ARMission")
            defaults.set("\(third)ARSuccess", forKey: "ARSuccess")
            defaults.set("\(third)wordSuccess", forKey: "wordSuccess")
            instructionText.text = "Do you want to continue?"
        }else{
            instructionText.text = "Do you want to repeat?"
        }
    }
    
    func fetchAlphabet(alphabetName:String) -> Bool{
        var alphabetFinished:[AlphabetTable]?
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            let pred = NSPredicate(format: "alphabet == %@", alphabetName)
            request.predicate = pred
            alphabetFinished = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return alphabetFinished![0].isCompleted
    }
    
    @IBAction func gotoNext(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioBGM.shared.stopSound()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "ChapterIntro") as! ChapterIntro
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: true, completion: nil)
        MainScreen.alphabetTitle.text = "The \(alphabet)"
    }
    @IBAction func cancelChapter(_ sender: Any) {
        AudioPrevTapped.shared.playSound()
//        dismiss(animated: true, completion: nil)
    }

}


//    func fetchRecords(){
//        do {
//            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
//            let pred = NSPredicate(format: "alphabet == %@", alphabet)
//            request.predicate = pred
//            self.alphabetCompleted = try context.fetch(request)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
