//
//  Repository.swift
//  beer-app
//
//  Created by Helena Dalmazo on 03/09/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import Foundation

class BeerRepository {
    
    static let shared = BeerRepository()
    static let BEERS_KEY = "beers"
    
    var beers = [Beer]()
    
    init() {
        let directory = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        print("Libary directory \(directory)")
        
//        UserDefaults.standard.removeObject(forKey: "beers")
        
        load()

        if beers.isEmpty {
            let caiumBeer = Beer("Cauim", "Colorado", 15.9, 3)
            save(caiumBeer)
            let cacildisBeer = Beer("Cacildis", "Brassaria Anápolis", 16.9, 2)
            save(cacildisBeer)
        }
    }
    
    func save(_ beer: Beer) {
        beers.append(beer)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: beers, requiringSecureCoding: true)
            
            UserDefaults.standard.set(data, forKey: "beers")
        } catch {
            print("[ERROR] Saving a beer: \(error)")
        }
    }
    
    func load() {
        do {
            guard let data = UserDefaults.standard.value(forKey: "beers") as? Data else {
                return
            }
            
            if let beers = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Beer.self], from: data) as? [Beer] {
                self.beers = beers
            }
        } catch {
            print("[ERROR] Loading beers: \(error)")
        }
    }
}
