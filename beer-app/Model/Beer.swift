//
//  Beer.swift
//  beer-app
//
//  Created by Helena Dalmazo on 02/09/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit
import Foundation

class Beer: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var name: String
    var brewery: String
    var price: Double
    var rating: Int
    var image: Data
    
    init(_ name: String, _ brewery: String, _ price: Double, _ rating: Int, _ image: Data) {
        self.name = name
        self.brewery = brewery
        self.price = price
        self.rating = rating
        self.image = image
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.brewery, forKey: "brewery")
        coder.encode(self.price, forKey: "price")
        coder.encode(self.rating, forKey: "rating")
        coder.encode(self.image, forKey: "image")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard
            let name = decoder.decodeObject(of: [NSString.self], forKey: "name") as? String,
            let brewery = decoder.decodeObject(of: [NSString.self], forKey: "brewery") as? String,
            let price = decoder.decodeDouble(forKey: "price") as? Double,
            let rating = decoder.decodeInteger(forKey: "rating") as? Int,
            let image = decoder.decodeObject(of: [NSString.self], forKey: "image") as? Data
            else {
                return nil
        }
        self.init(name, brewery, price, rating, image)
    }
}
