//
//  Extensions.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 17/07/21.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{return self.cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
