//
//  ChapterPageViewController.swift
//  AR2ndTest
//
//  Created by Khairunnisha Afifa on 22/07/21.
//

import UIKit

class ChapterPage: UIViewController {

    // Card Chapter
    var cardChapterLeft: UIButton!
    var cardChapterMiddle: UIButton!
    var cardChapterRight: UIButton!
    
    let defaults = UserDefaults.standard
        
    var page: Pages
    
    init(with page: Pages) {
        self.page = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Card Chapter Left
        cardChapterLeft = UIButton(frame: CGRect(x: 6, y: 10, width: 280, height: 450))
        cardChapterLeft?.setImage(UIImage(named: "CardChapter\(page.chapterStart)"), for: .normal)
        cardChapterLeft.tag = page.chapterStart
        cardChapterLeft.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        self.view.addSubview(cardChapterLeft!)
        
        // Card Chapter Middle
        cardChapterMiddle = UIButton(frame: CGRect(x: 310, y: 10, width: 280, height: 450))
        cardChapterMiddle?.setImage(UIImage(named: "CardChapter\(page.chapterStart + 1)"), for: .normal)
        cardChapterMiddle.tag = page.chapterStart + 1
        cardChapterMiddle.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        self.view.addSubview(cardChapterMiddle!)
        
        // Card Chapter Right
        cardChapterRight = UIButton(frame: CGRect(x: 613, y: 10, width: 280, height: 450))
        cardChapterRight?.setImage(UIImage(named: "CardChapter\(page.chapterStart + 2)"), for: .normal)
        cardChapterRight.tag = page.chapterStart + 2
        cardChapterRight.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        self.view.addSubview(cardChapterRight!)
    }
    
    @objc func buttonChapter(sender: UIButton) {
        let index = sender.tag
        defaults.set(index, forKey: "chapterSelected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "ChapterStartConfirmation") as! ChapterStartConfirmation
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: true, completion: nil)
    }
}
