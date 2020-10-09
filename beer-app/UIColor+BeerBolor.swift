//
//  UIColor+BeerBolor.swift
//  beer-app
//
//  Created by Helena Dalmazo on 08/10/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var americanWheat: UIColor {
        get {
            return beerColor(at: 6)
        }
    }
    
    static var americanPaleAle: UIColor {
        get {
            return beerColor(at: 27)
        }
    }
    
    static func beerColor(at index: Int) -> UIColor {
        let selected = beerColorList[index]
        
        let red = CGFloat(selected["red"] ?? 0) / 255
        let green = CGFloat(selected["green"] ?? 0) / 255
        let blue = CGFloat(selected["blue"] ?? 0) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func beerColor(of color: UIColor) -> Int {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0
        
        color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        
        let red = Int(fRed * 255.0)
        let green = Int(fGreen * 255.0)
        let blue = Int(fBlue * 255.0)
        
        return beerColorList.firstIndex(of: [ "red": red, "green": green, "blue": blue ]) ?? 0
    }
    
    static let beerColorList = [
        [ "red": 255, "green": 255, "blue": 255 ],
        [ "red": 251, "green": 240, "blue": 203 ],
        [ "red": 247, "green": 225, "blue": 161 ],
        [ "red": 244, "green": 211, "blue": 128 ],
        [ "red": 240, "green": 197, "blue": 102 ],
        [ "red": 237, "green": 185, "blue": 80 ],
        [ "red": 233, "green": 173, "blue": 63 ],
        [ "red": 229, "green": 162, "blue": 49 ],
        [ "red": 225, "green": 151, "blue": 38 ],
        [ "red": 221, "green": 141, "blue": 29 ],
        [ "red": 217, "green": 132, "blue": 22 ],
        [ "red": 213, "green": 123, "blue": 17 ],
        [ "red": 209, "green": 115, "blue": 12 ],
        [ "red": 205, "green": 108, "blue": 8 ],
        [ "red": 200, "green": 101, "blue": 5 ],
        [ "red": 196, "green": 94, "blue": 3 ],
        [ "red": 192, "green": 88, "blue": 1 ],
        [ "red": 188, "green": 82, "blue": 0 ],
        [ "red": 183, "green": 77, "blue": 0 ],
        [ "red": 179, "green": 72, "blue": 0 ],
        [ "red": 175, "green": 67, "blue": 0 ],
        [ "red": 171, "green": 63, "blue": 0 ],
        [ "red": 167, "green": 59, "blue": 0 ],
        [ "red": 163, "green": 55, "blue": 0 ],
        [ "red": 159, "green": 52, "blue": 0 ],
        [ "red": 155, "green": 48, "blue": 0 ],
        [ "red": 151, "green": 45, "blue": 0 ],
        [ "red": 143, "green": 40, "blue": 0 ],
        [ "red": 136, "green": 35, "blue": 0 ],
        [ "red": 129, "green": 31, "blue": 0 ],
        [ "red": 123, "green": 27, "blue": 0 ],
        [ "red": 116, "green": 24, "blue": 0 ],
        [ "red": 110, "green": 21, "blue": 0 ],
        [ "red": 104, "green": 18, "blue": 0 ],
        [ "red": 99, "green": 16, "blue": 0 ],
        [ "red": 94, "green": 14, "blue": 0 ],
        [ "red": 89, "green": 12, "blue": 0 ],
        [ "red": 84, "green": 11, "blue": 0 ],
        [ "red": 80, "green": 9, "blue": 0 ],
        [ "red": 76, "green": 8, "blue": 0 ],
        [ "red": 72, "green": 7, "blue": 0 ],
        [ "red": 68, "green": 6, "blue": 0 ],
        [ "red": 65, "green": 5, "blue": 0 ],
        [ "red": 61, "green": 5, "blue": 0 ],
        [ "red": 58, "green": 4, "blue": 0 ],
        [ "red": 55, "green": 4, "blue": 0 ],
        [ "red": 52, "green": 3, "blue": 0 ],
        [ "red": 50, "green": 3, "blue": 0 ],
        [ "red": 47, "green": 2, "blue": 0 ],
        [ "red": 45, "green": 2, "blue": 0 ],
        [ "red": 42, "green": 2, "blue": 0 ],
        [ "red": 40, "green": 1, "blue": 0 ],
        [ "red": 38, "green": 1, "blue": 0 ],
        [ "red": 36, "green": 1, "blue": 0 ],
        [ "red": 22, "green": 0, "blue": 0 ],
        [ "red": 13, "green": 0, "blue": 0 ],
        [ "red": 0, "green": 0, "blue": 0 ],
    ]
}
