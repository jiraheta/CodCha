//
//  ShadowHelperView.swift
//  CodCha
//
//  Created by Jportdev on 6/4/21.
//
// Helper class to add shadow effect
import UIKit

@IBDesignable
class ShadowHelperView: UIView {
    //shadow color property set
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    //shadow radius property set
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    //shadow opacity property set
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    //shadow offset sets
    @IBInspectable var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}
