//
//  ChapterPageViewController.swift
//  AR2ndTest
//
//  Created by Khairunnisha Afifa on 22/07/21.
//

import UIKit

class ChapterPage: UIViewController {

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
        
        cardChapterLeft = UIButton(frame: CGRect(x: 153, y: 267, width: 280, height: 450))
        cardChapterLeft?.setImage(UIImage(named: "CardChapter\(page.chapterStart)"), for: .normal)
        cardChapterLeft.tag = page.chapterStart
        cardChapterLeft.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        self.view.addSubview(cardChapterLeft!)
        
        cardChapterMiddle = UIButton(frame: CGRect(x: 457, y: 267, width: 280, height: 450))
        cardChapterMiddle?.setImage(UIImage(named: "CardChapter\(page.chapterStart + 1)"), for: .normal)
        cardChapterMiddle.tag = page.chapterStart + 1
        cardChapterMiddle.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        self.view.addSubview(cardChapterMiddle!)
        
        cardChapterRight = UIButton(frame: CGRect(x: 760, y: 267, width: 280, height: 450))
        cardChapterRight?.setImage(UIImage(named: "CardChapter\(page.chapterStart + 2)"), for: .normal)
        cardChapterRight.tag = page.chapterStart + 2
        cardChapterRight.addTarget(self, action: #selector(buttonChapter), for: .touchUpInside)
        self.view.addSubview(cardChapterRight!)
    }
    
    @objc func buttonChapter(sender: UIButton) {
        let index = sender.tag
        defaults.set(index, forKey: "chapterSelected")
    }
}