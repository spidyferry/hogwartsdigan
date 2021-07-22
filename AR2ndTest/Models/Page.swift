//
//  Page.swift
//  AR2ndTest
//
//  Created by Khairunnisha Afifa on 22/07/21.
//

import Foundation

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    
    var chapterStart: Int {
        switch self {
            case .pageZero:
                return 1
            case .pageOne:
                return 4
            case .pageTwo:
                return 7
        }
    }
    
    var index: Int {
        switch self {
            case .pageZero:
                return 0
            case .pageOne:
                return 1
            case .pageTwo:
                return 2
        }
    }
}
