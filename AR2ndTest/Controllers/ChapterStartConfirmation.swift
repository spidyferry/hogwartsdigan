//
//  ChapterStartConfirmation.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import CoreData

class ChapterStartConfirmation: UIViewController{
    
    var alphabet = "Sorry :("
    var textfile1 = ""
    var textfile2 = ""
    var textfile3 = ""
    let defaults = UserDefaults.standard
    var titleChapter: String = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alphabetCompleted:[AlphabetTable]?

    @IBOutlet weak var whiteTransBg: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var instructionText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change title chapter
        self.titleLabel.text = titleChapter
        
        let selectedChapter = UserDefaults.standard.integer(forKey: "chapterSelected")
        switch selectedChapter{
        case 1 :
            let theAIsComplete = fetchAlphabet(alphabetName: "The A")
            let theBIsComplete = fetchAlphabet(alphabetName: "The B")
            let theCIsComplete = fetchAlphabet(alphabetName: "The C")
            
            if (theAIsComplete == false && theBIsComplete == false && theCIsComplete == false){
                alphabet = "The A"
                textfile1 = "TheA1"
                textfile2 = "TheA2"
                textfile3 = "TheA3"
            }else if (theAIsComplete == true && theBIsComplete == false && theCIsComplete == false){
                alphabet = "The B"
            }else if (theAIsComplete == true && theBIsComplete == true && theCIsComplete == false){
                alphabet = "The C"
            }else{
                instructionText.text = "Do you want to repeat?"
            }
        case 2 :
            let theDIsComplete = fetchAlphabet(alphabetName: "The D")
            print(theDIsComplete)
        case 3 :
            let theGIsComplete = fetchAlphabet(alphabetName: "The G")
            print(theGIsComplete)
        case 4 :
            let theJIsComplete = fetchAlphabet(alphabetName: "The J")
            print(theJIsComplete)
        case 5 :
            let theMIsComplete = fetchAlphabet(alphabetName: "The M")
            print(theMIsComplete)
        case 6 :
            let thePIsComplete = fetchAlphabet(alphabetName: "The P")
            print(thePIsComplete)
        case 7 :
            let theSIsComplete = fetchAlphabet(alphabetName: "The S")
            print(theSIsComplete)
        case 8 :
            let theVIsComplete = fetchAlphabet(alphabetName: "The V")
            print(theVIsComplete)
        case 9 :
            let theYIsComplete = fetchAlphabet(alphabetName: "The Y")
            print(theYIsComplete)
            
        default:
            print("default")
        }
    }

    override func viewWillAppear(_ animated: Bool) {

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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "ChapterIntro") as! ChapterIntro
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: true, completion: nil)
        MainScreen.alphabetTitle.text = alphabet
        MainScreen.textfile1 = textfile1
        MainScreen.textfile2 = textfile2
        MainScreen.textfile3 = textfile3
    }
    @IBAction func cancelChapter(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
