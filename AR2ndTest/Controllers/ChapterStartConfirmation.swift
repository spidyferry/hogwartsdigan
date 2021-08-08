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
    var reset: Bool = false
    var alphabetToReset: [String] = []
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
        
        if (firstIsComplete == false && secondIsComplete == false && thirdIsComplete == false) {
            self.alphabet                = first
            self.instructionText.text    = "Are you ready to start?"
        } else if (firstIsComplete == true && secondIsComplete == false && thirdIsComplete == false) {
            self.alphabet                = second
            self.instructionText.text    = "Do you want to continue?"
        } else if (firstIsComplete == true && secondIsComplete == true && thirdIsComplete == false) {
            self.alphabet                = third
            self.instructionText.text    = "Do you want to continue?"
        } else {
            self.alphabet                = first
            self.reset                   = true
            self.alphabetToReset        = [first, second, third]
            self.instructionText.text    = "Do you want to repeat?"
        }
        
        defaults.set(alphabet, forKey: "currentAlphabet")
        defaults.set("\(alphabet)alphabetIntro", forKey: "alphabetIntro")
        defaults.set("\(alphabet)alphabetSuccess", forKey: "alphabetSuccess")
        defaults.set("\(alphabet)ARMission", forKey: "ARMission")
        defaults.set("\(alphabet)ARSuccess", forKey: "ARSuccess")
        defaults.set("\(alphabet)wordSuccess", forKey: "wordSuccess")
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
    
    func resetChapter() {
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            
            for item in self.alphabetToReset {
                let predicate       = NSPredicate(format: "alphabet CONTAINS %@", item)
                request.predicate   = predicate
                
                let alphabet = try context.fetch(request)
                
                if(alphabet.count != 0) {
                    let item            = alphabet[0]
                    item.isCompleted    = false
                    
                    try context.save()
                }
                
                else {
                    print("Cannot find alphabet \(item)")
                }
            }

        } catch {
            print("Failed to set complete: \(error.localizedDescription)")
        }
    }
    
    @IBAction func gotoNext(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioBGM.shared.stopSound()
        
        if reset {
            self.resetChapter()
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ChapterIntroVC = storyBoard.instantiateViewController(withIdentifier: "ChapterIntro") as! ChapterIntro
        ChapterIntroVC.modalPresentationStyle = .fullScreen
        ChapterIntroVC.titleChapter = titleChapter
        self.present(ChapterIntroVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelChapter(_ sender: Any) {
        AudioPrevTapped.shared.playSound()
    }
}
