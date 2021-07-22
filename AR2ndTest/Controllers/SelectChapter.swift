//
//  SelectChapter.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class SelectChapter: UIViewController {
    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageController()
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.pageController?.dataSource             = self
        self.pageController?.delegate               = self
        self.pageController?.view.backgroundColor   = .clear
        
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC   = ChapterPage(with: pages[0])
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        self.pageController?.didMove(toParent: self)
    }
}

extension SelectChapter: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? ChapterPage else { return nil }
        var index           = currentVC.page.index
        
        if index == 0 { return nil }
        index -= 1
        
        let previousVC: ChapterPage = ChapterPage(with: pages[index])
        return previousVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? ChapterPage else { return nil }
        var index           = currentVC.page.index
        
        if index >= self.pages.count - 1 { return nil }
        index += 1
        
        let nextVC: ChapterPage = ChapterPage(with: pages[index])
        return nextVC
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

