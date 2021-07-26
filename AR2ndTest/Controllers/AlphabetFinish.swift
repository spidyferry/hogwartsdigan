//
//  AlphabetFinish.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit
import CoreData

class AlphabetFinish: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    @IBOutlet weak var finishButton: UIButton!
    var alphabetToRecognize:[AlphabetTable]?
    var currentAlphabet:String=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!

    }
    
    @IBAction func finishPerAlphabet(_ sender: Any) {
        
        getValueForLevelFinished()
        
        alphabetToRecognize![0].isCompleted = true
        do{
            try self.context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "SelectChapter") as! SelectChapter
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: false, completion: nil)
    }
    
    func getValueForLevelFinished(){
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            let pred = NSPredicate(format: "alphabet == %@", currentAlphabet)
            request.predicate = pred
            alphabetToRecognize = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }

}
