//
//  AlphabetFinish.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit
import CoreData

class AlphabetFinish: UIViewController {

    let context         = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults        = UserDefaults.standard
    var currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
    var currentChapter  = UserDefaults.standard.string(forKey: "currentChapter")!
    var nextAlphabet    = UserDefaults.standard.string(forKey: "nextAlphabet")!
    var nextChapter     = UserDefaults.standard.string(forKey: "nextChapter")!
    var indexChapter    = UserDefaults.standard.string(forKey: "indexChapter")!
    
    var chapter : [Chapter] = Chapter.allCases
    
    @IBOutlet weak var finishButton: UIButton!
    var alphabetToRecognize:[AlphabetTable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
        currentChapter  = UserDefaults.standard.string(forKey: "currentChapter")!
        nextAlphabet    = UserDefaults.standard.string(forKey: "nextAlphabet")!
        nextChapter     = UserDefaults.standard.string(forKey: "nextChapter")!
        indexChapter    = UserDefaults.standard.string(forKey: "indexChapter")!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioBGM.shared.startSound()
    }
    
    @IBAction func finishPerAlphabet(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        
        self.setToComplete()
        
        let nextChapterAvailable = self.nextChapter != "" ? self.chapter[Int(self.indexChapter)! + 1].available : false
        let goToNextChapter      = self.nextAlphabet == "" ? true : false
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let AlphabetFinishVC = UIViewController()
        let ChapterStartConfirmationVC = storyBoard.instantiateViewController(withIdentifier: "ChapterStartConfirmation") as! ChapterStartConfirmation
        let navigationController = UINavigationController(rootViewController: AlphabetFinishVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        ChapterStartConfirmationVC.modalPresentationStyle = .fullScreen
        ChapterStartConfirmationVC.titleChapter = nextChapterAvailable && goToNextChapter ? self.nextChapter : self.currentChapter
        ChapterStartConfirmationVC.indexChapter = (nextChapterAvailable && goToNextChapter ? Int(self.indexChapter)! + 1 : Int(self.indexChapter))!
        
        print("Here")
        print(UserDefaults.standard.string(forKey: "currentChapter")!)
        print(self.currentChapter)
        navigationController.pushViewController(ChapterStartConfirmationVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    func setToComplete() {
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            
            let predicate       = NSPredicate(format: "alphabet CONTAINS %@", self.currentAlphabet)
            request.predicate   = predicate
            
            let alphabet = try context.fetch(request)
            
            if(alphabet.count != 0) {
                let item            = alphabet[0]
                item.isCompleted    = true
                
                try context.save()
            }
            
            else {
                print("Cannot find alphabet \(self.currentAlphabet)")
            }
            
        } catch {
            print("Failed to set complete: \(error.localizedDescription)")
        }
    }

    @IBAction func pauseButtonTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.playSound()
        AudioBGM.shared.pauseSound()
    }
}
