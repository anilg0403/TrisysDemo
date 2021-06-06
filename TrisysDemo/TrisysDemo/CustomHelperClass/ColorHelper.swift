//
//  ColorHelper.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import UIKit
import Foundation

enum AssetsColor {
    case base_1
    case base_2
    
    case black
    case white
    case gray
    case lightGray
}

extension UIColor {

    static func getColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .base_1:
            return UIColor(named: "base_1") ?? UIColor.white
        case .base_2:
            return UIColor(named: "base_2") ?? UIColor.white
        case .black:
            return UIColor(named: "black") ?? UIColor.white
        case .white:
            return UIColor(named: "white") ?? UIColor.white
        case .gray:
            return UIColor(named: "gray") ?? UIColor.white
        case .lightGray:
            return UIColor(named: "lightGray") ?? UIColor.white
        }
    }
}


extension UIColor {
    
    // MARK: - Initialization
    
    convenience public init?(hex: String) {
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var int = UInt32()
        Scanner(string: hexSanitized).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hexSanitized.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    // MARK: - Computed Properties
    
    public var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    public func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}

