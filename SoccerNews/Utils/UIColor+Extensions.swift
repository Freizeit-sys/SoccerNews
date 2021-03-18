//
//  UIColor+Extensions.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/19.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    struct scheme {
        public static let background = UIColor.background
        public static let surface = UIColor.surface
        public static let label = UIColor.label
        public static let secondaryLabel = UIColor.secondaryLabel
        public static let button = UIColor.button
        public static let secondaryButton = UIColor.secondaryButton
    }
    
    static private var background: UIColor {
        guard #available(iOS 13.0, *) else  {
            return .systemBackground
        }
        let color = UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return .secondarySystemBackground
            } else {
                return .systemBackground
            }
        }
        return color
    }
    
    static private var surface: UIColor {
        guard #available(iOS 13.0, *) else {
            return .systemBackground
        }
        let color = UIColor { (traitCollction) -> UIColor in
            if traitCollction.userInterfaceStyle == .dark {
                return .secondarySystemBackground
            } else {
                return .systemBackground
            }
        }
        return color
    }
    
    static private var label: UIColor {
        guard #available(iOS 13.0, *) else {
            return .black
        }
        let color = UIColor { (traitCollction) -> UIColor in
            if traitCollction.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }
        return color
    }
    
    static private var secondaryLabel: UIColor {
        guard #available(iOS 13.0, *) else {
            return .lightGray
        }
        let color = UIColor { (traitCollction) -> UIColor in
            if traitCollction.userInterfaceStyle == .dark {
                return .lightGray
            } else {
                return .lightGray
            }
        }
        return color
    }
    
    static private var button: UIColor {
        guard #available(iOS 13.0, *) else {
            return .black
        }
        let color = UIColor { (traitCollction) -> UIColor in
            if traitCollction.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }
        return color
    }
    
    static private var secondaryButton: UIColor {
        guard #available(iOS 13.0, *) else {
            return .white
        }
        let color = UIColor { (traitCollction) -> UIColor in
            if traitCollction.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
        return color
    }
}
