//
//  ChapterPageViewController.swift
//  AR2ndTest
//
//  Created by Khairunnisha Afifa on 22/07/21.
//

import UIKit
import CoreData

class ChapterPage: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Card Chapter
    var cardChapterLeft: UIButton!
    var cardChapterMiddle: UIButton!
    var cardChapterRight: UIButton!
    
    let defaults = UserDefaults.standard
        
    var page: Pages
    var chapter : [Chapter] = Chapter.allCases
    
    private var alphabetList = [AlphabetTable]()
    
    init(with page: Pages) {
        self.page = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showChapterCard()
    }
    
    @objc func buttonChapter(sender: UIButton) {
        let index = sender.tag
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SelectChapterVC = UIViewController()
        let ChapterStartVC = storyBoard.instantiateViewController(withIdentifier: "ChapterStartConfirmation") as! ChapterStartConfirmation
        let navigationController = UINavigationController(rootViewController: SelectChapterVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        
        ChapterStartVC.modalPresentationStyle = .fullScreen
        ChapterStartVC.titleChapter = chapter[index - 1].title
        ChapterStartVC.indexChapter = index - 1
        navigationController.pushViewController(ChapterStartVC, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    func showChapterCard() {
        let pageControllerWidth     = UIScreen.main.bounds.size.width-(150*2)
        let pageControllerHeight    = (451) - 20
        
        // Card Chapter Left
        let chapterLeftLock     = chapter[page.chapterStart - 1].available
        let chapterLeftDone     = self.fetchCompleted(index: page.chapterStart - 1)
        let chapterLeftTitle    = "CardChapter\(page.chapterStart)\(!chapterLeftLock ? "Lock" : (chapterLeftDone ? "Done" : ""))"
        
        cardChapterLeft = UIButton(frame: CGRect(x: 0, y: 10, width:  Int(pageControllerWidth)/3, height: pageControllerHeight))
        cardChapterLeft?.setImage(UIImage(named: chapterLeftTitle), for: .normal)
        cardChapterLeft.tag = page.chapterStart
        cardChapterLeft.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        cardChapterLeft.isEnabled = chapterLeftLock
        self.view.addSubview(cardChapterLeft!)
        
        // Card Chapter Middle
        let chapterMiddleLock     = chapter[page.chapterStart].available
        let chapterMiddleDone     = self.fetchCompleted(index: page.chapterStart)
        let chapterMiddleTitle    = "CardChapter\(page.chapterStart + 1)\(!chapterMiddleLock ? "Lock" : (chapterMiddleDone ? "Done" : ""))"

        cardChapterMiddle = UIButton(frame: CGRect(x: (pageControllerWidth/3), y: 10, width: pageControllerWidth/3, height: CGFloat(pageControllerHeight)))
        cardChapterMiddle?.setImage(UIImage(named: chapterMiddleTitle), for: .normal)
        cardChapterMiddle.tag = page.chapterStart + 1
        cardChapterMiddle.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        cardChapterMiddle.isEnabled = chapterMiddleLock
        self.view.addSubview(cardChapterMiddle!)
        
        // Card Chapter Right
        let chapterRightLock     = chapter[page.chapterStart + 1].available
        let chapterRightDone     = self.fetchCompleted(index: page.chapterStart + 1)
        let chapterRightTitle    = "CardChapter\(page.chapterStart + 2)\(!chapterRightLock ? "Lock" : (chapterRightDone ? "Done" : ""))"

        cardChapterRight = UIButton(frame: CGRect(x: (pageControllerWidth/3)*2, y: 10, width: pageControllerWidth/3, height: CGFloat(pageControllerHeight)))
        cardChapterRight?.setImage(UIImage(named: chapterRightTitle), for: .normal)
        cardChapterRight.tag = page.chapterStart + 2
        cardChapterRight.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        cardChapterRight.isEnabled = chapterRightLock
        self.view.addSubview(cardChapterRight!)
    }
    
    func fetchCompleted(index: Int) -> Bool {
        do {
            let request = AlphabetTable.fetchRequest() as NSFetchRequest<AlphabetTable>
            
            let alphabets       = chapter[index].alphabets
            let predicate       = NSPredicate(format: "alphabet IN %@", alphabets)
            request.predicate   = predicate
            
            let alphabetList = try context.fetch(request)

            var isDone: Bool = false
            var totalInChapter: Int = 0
            for item in alphabetList {
                if item.isCompleted == true && totalInChapter <= alphabets.count {
                    totalInChapter += 1
                    
                    if totalInChapter == alphabets.count {
                        isDone = true
                    }
                }
            }
            
            return isDone
        } catch {
            print("Failed to fetch completed data: \(error.localizedDescription)")
            
            return false
        }
    }
}
