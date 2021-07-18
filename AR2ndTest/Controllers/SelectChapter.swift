//
//  SelectChapter.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 15/07/21.
//

import UIKit

class SelectChapter: UIViewController {
    
    @IBOutlet weak var scrollViewCard: UIScrollView!
    //    private let scrollView = UIScrollView()
//    private let pageControl:UIPageControl = {
//        let pageControl = UIPageControl()
//        pageControl.numberOfPages = 3
////        pageControl.backgroundColor = .systemBlue
//        pageControl.pageIndicatorTintColor = .systemGray
//        pageControl.currentPageIndicatorTintColor = .systemOrange
//        return pageControl
//    }()

    @IBOutlet weak var chapterBack: UIButton!
    @IBOutlet weak var chapterNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.backgroundColor = .red
//        view.addSubview(pageControl)
//        view.addSubview(scrollView)
    }

    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        pageControl.frame = CGRect(x: 10, y: view.frame.size.height - 100, width: view.frame.size.width - 20, height: 70)
//        scrollView.frame = CGRect(x: 134, y: 235, width: 926, height: 514)
//    }

}

