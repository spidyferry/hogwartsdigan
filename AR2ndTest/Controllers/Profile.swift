//
//  Profile.swift
//  AR2ndTest
//
//  Created by Khairunnisha Afifa on 23/07/21.
//

import UIKit
import CoreData
import AVFoundation

class Profile: UIViewController {
    
    var okButtonTapped = AVAudioPlayer()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var newLearnerBadge: UIButton!
    @IBOutlet weak var theExplorerBadge: UIButton!
    @IBOutlet weak var theAdventureBadge: UIButton!
    @IBOutlet weak var theAchieverBadge: UIButton!
    @IBOutlet weak var theExpertBadge: UIButton!
    @IBOutlet weak var theMasterBadge: UIButton!
    
    private var alphabetList = [AlphabetTable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            okButtonTapped = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource : "s_butt_pressed", ofType: "mp3")!))
        } catch {
            print(error)
        }
        self.fetchCompleted()
    }
    
    func fetchCompleted() {
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            
            let sort                = NSSortDescriptor(key: "alphabet", ascending: true)
            request.sortDescriptors = [sort]
            
            alphabetList = try context.fetch(request)

            var totalScore: Int = 0
            var totalInChapter: Int = 3
            for (index, item) in alphabetList.enumerated() {
                if item.isCompleted == true && totalInChapter > 0 {
                    totalInChapter -= 1
                    
                    if totalInChapter == 0 || (index == alphabetList.count - 1 && totalInChapter == 1) {
                        totalInChapter = 3
                        totalScore += 1
                    }
                }
            }
            
            self.showBadge(total: totalScore)
        } catch {
            print("Error to fetch completed data: \(error.localizedDescription)")
        }
    }
    
    func showBadge(total: Int) {
        if total >= 1 {
            newLearnerBadge.setImage(UIImage(named: "BadgeNewLearnerDone"), for: .normal)
        }
        
        if total >= 2 {
            theExplorerBadge.setImage(UIImage(named: "BadgeTheExplorerDone"), for: .normal)
        }
        
        if total >= 4 {
            theAdventureBadge.setImage(UIImage(named: "BadgeTheAdventurerDone"), for: .normal)
        }
        
        if total >= 6 {
            theAchieverBadge.setImage(UIImage(named: "BadgeTheAchieverDone"), for: .normal)
        }
        
        if total >= 8 {
            theExpertBadge.setImage(UIImage(named: "BadgeTheExpertDone"), for: .normal)
        }
        
        if total >= 9 {
            theMasterBadge.setImage(UIImage(named: "BadgeTheAppleBethMasterDone"), for: .normal)
        }
        
    }
    
    
    @IBAction func okButtonTapped(_ sender: Any) {
        okButtonTapped.play()
    }
}
