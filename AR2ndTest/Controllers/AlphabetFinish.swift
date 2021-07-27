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
    let currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
    
    @IBOutlet weak var finishButton: UIButton!
    var alphabetToRecognize:[AlphabetTable]?
    var currentAlphabet:String=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!

    }
    
    @IBAction func finishPerAlphabet(_ sender: Any) {
        self.setToComplete()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SelectChapterVC = storyBoard.instantiateViewController(withIdentifier: "SelectChapter") as! SelectChapter
        SelectChapterVC.modalPresentationStyle = .fullScreen
        self.present(SelectChapterVC, animated: false, completion: nil)
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

}
