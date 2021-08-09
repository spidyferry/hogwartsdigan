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
    var alphabets: [String] = []
    var reset: Bool = false
    var alphabetToReset: [String] = []
    var titleChapter: String = ""
    var indexChapter: Int = 0
    
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alphabetCompleted:[AlphabetTable]?
    var chapter : [Chapter] = Chapter.allCases

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
        
        self.alphabets = self.chapter[indexChapter].alphabets
        self.prepareDataforCurrentChapter(first: alphabets[0], second: alphabets[1], third: (alphabets.count == 3 ? alphabets[2] : alphabets[1]))
    }
    
    func prepareDataforCurrentChapter (first:String, second:String, third: String){
        let firstIsComplete = fetchAlphabet(alphabetName: first)
        let secondIsComplete = fetchAlphabet(alphabetName: second)
        let thirdIsComplete = fetchAlphabet(alphabetName: third)
        
        var nextAlphabet: String = ""
        
        if (firstIsComplete == false && secondIsComplete == false && thirdIsComplete == false) {
            self.alphabet                = first
            self.instructionText.text    = "Are you ready to start?"
            
            nextAlphabet = self.alphabets[1]
        } else if (firstIsComplete == true && secondIsComplete == false && thirdIsComplete == false) {
            self.alphabet                = second
            self.instructionText.text    = "Do you want to continue?"
            
            nextAlphabet = self.alphabets.count == 3 ? self.alphabets[2] : ""
        } else if (firstIsComplete == true && secondIsComplete == true && thirdIsComplete == false) {
            self.alphabet                = third
            self.instructionText.text    = "Do you want to continue?"
        } else {
            self.alphabet                = first
            self.reset                   = true
            self.alphabetToReset         = self.alphabets
            self.instructionText.text    = "Do you want to repeat?"
        }
        
        defaults.set(self.indexChapter, forKey: "indexChapter")
        defaults.set(self.alphabet, forKey: "currentAlphabet")
        defaults.set(self.titleChapter, forKey: "currentChapter")
        defaults.set(nextAlphabet, forKey: "nextAlphabet")
        defaults.set((self.chapter.count != self.indexChapter ? self.chapter[self.indexChapter + 1].title : ""), forKey: "nextChapter")
        defaults.set("\(self.alphabet)alphabetIntro", forKey: "alphabetIntro")
        defaults.set("\(self.alphabet)alphabetSuccess", forKey: "alphabetSuccess")
        defaults.set("\(self.alphabet)ARMission", forKey: "ARMission")
        defaults.set("\(self.alphabet)ARSuccess", forKey: "ARSuccess")
        defaults.set("\(self.alphabet)wordSuccess", forKey: "wordSuccess")
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
