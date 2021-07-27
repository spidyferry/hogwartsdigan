//
//  SelectChapter.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit
import AVFoundation

class SelectChapter: UIViewController {
    
    var buttonPressed = AVAudioPlayer()
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    private var goToPage: Int = 0
    private var lastPage: Int = 0
    private var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            buttonPressed = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource : "s_butt_pressed", ofType: "mp3")!))
        } catch {
            print(error)
        }
        
        self.setupPageController()
        self.previousButton.isHidden = true
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.pageController?.dataSource             = self
        self.pageController?.delegate               = self
        self.pageController?.view.backgroundColor   = .clear
        
        self.pageController?.view.frame = CGRect(x: 145, y: 259, width: 901,height: 509)
        
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC = ChapterPage(with: pages[0])
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        self.pageController?.didMove(toParent: self)
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        buttonPressed.play()
        if self.currentPage != 0 {
            self.currentPage -= 1
            
            self.movePage(index: self.currentPage, isForward: false)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        buttonPressed.play()
        if self.currentPage < self.pages.count - 1 {
            self.currentPage += 1
            
            self.movePage(index: self.currentPage, isForward: true)
        }
    }
    
    func movePage(index: Int, isForward: Bool) {
        let vc = ChapterPage(with: self.pages[index])
        self.pageController?.setViewControllers([vc], direction: isForward ? .forward : .reverse, animated: true, completion: nil)
        self.pageController?.didMove(toParent: self)
        
        self.setPageControl()
    }
    
    func setPageControl() {
        if self.currentPage == 0 {
            self.previousButton.isHidden = true
        } else {
            self.previousButton.isHidden = false
        }
        
        if self.currentPage == self.pages.count - 1 {
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isHidden = false
        }
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentVC = previousViewControllers[0] as? ChapterPage else { return }
            let index           = currentVC.page.index
            
            self.lastPage = index
            self.currentPage = self.goToPage
            
            self.setPageControl()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let currentVC = pendingViewControllers[0] as? ChapterPage else { return }
        let index           = currentVC.page.index
        
        self.goToPage = index
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

