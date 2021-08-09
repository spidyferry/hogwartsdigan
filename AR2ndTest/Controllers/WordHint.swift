//
//  WordHint.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 16/07/21.
//

import UIKit
import CoreData

class WordHint: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageHint: UIImageView!
    
    var wordSupposedToBe:String = ""
    var dash:String = ""
    var word:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AudioBGM.shared.playSound()

        let currentAlphabet = UserDefaults.standard.string(forKey: "currentAlphabet")!
        wordSupposedToBe = getValueForRecognition(alphabetName: currentAlphabet)
        
        for _ in 1..<wordSupposedToBe.count{
            dash.append(" _")
        }
        
        imageHint.image = UIImage(named: "A")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioBGM.shared.startSound()
    }
    
    func getValueForRecognition(alphabetName:String) -> String{
        var alphabetToRecognize:[AlphabetTable]?
        
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            let pred = NSPredicate(format: "alphabet == %@", alphabetName)
            request.predicate = pred
            alphabetToRecognize = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return alphabetToRecognize![0].wordRec!
    }
    
    @IBAction func pauseButtTapped(_ sender: Any) {
        AudioNextTapped.shared.playSound()
        AudioPausedTheme.shared.playSound()
        AudioBGM.shared.pauseSound()
    }
    
    @IBAction func prevScreen(_ sender: Any) {
        AudioPrevTapped.shared.playSound()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtTapped(_ sender: Any) {
//        AudioBGM.shared.stopSound()
        AudioNextTapped.shared.playSound()
    }
}
