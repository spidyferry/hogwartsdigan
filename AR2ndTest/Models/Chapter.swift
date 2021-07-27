//
//  Chapter.swift
//  AR2ndTest
//
//  Created by Khairunnisha Afifa on 22/07/21.
//

import Foundation

enum Chapter: CaseIterable {
    case chapter1
    case chapter2
    case chapter3
    case chapter4
    case chapter5
    case chapter6
    case chapter7
    case chapter8
    case chapter9
    
    var title: String {
        switch self {
            case .chapter1:
                return "The ABC"
            case .chapter2:
                return "The DEF"
            case .chapter3:
                return "The GHI"
            case .chapter4:
                return "The JKL"
            case .chapter5:
                return "The MNO"
            case .chapter6:
                return "The PQR"
            case .chapter7:
                return "The STU"
            case .chapter8:
                return "The VWX"
            case .chapter9:
                return "The YZ"
        }
    }
    
    var alphabets: [String] {
        switch self {
            case .chapter1:
                return ["A", "B", "C"]
            case .chapter2:
                return ["D", "E", "F"]
            case .chapter3:
                return ["H", "I", "J"]
            case .chapter4:
                return ["K", "L", "M"]
            case .chapter5:
                return ["N", "O", "P"]
            case .chapter6:
                return ["Q", "R", "S"]
            case .chapter7:
                return ["T", "U", "V"]
            case .chapter8:
                return ["W", "X", "Y"]
            case .chapter9:
                return ["Y", "Z"]
        }
    }
    
    var index: Int {
        switch self {
            case .chapter1:
                return 1
            case .chapter2:
                return 2
            case .chapter3:
                return 3
            case .chapter4:
                return 4
            case .chapter5:
                return 5
            case .chapter6:
                return 6
            case .chapter7:
                return 7
            case .chapter8:
                return 8
            case .chapter9:
                return 9
        }
    }
}
