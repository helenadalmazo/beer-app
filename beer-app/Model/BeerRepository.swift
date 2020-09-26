//
//  Repository.swift
//  beer-app
//
//  Created by Helena Dalmazo on 03/09/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit
import Foundation

class BeerRepository {
    
    static let shared = BeerRepository()
    static let BEERS_KEY = "beers"
    
    var beers = [Beer]()
    
    init() {
        let directory = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        print("[INFO] Libary directory \(directory)")
        
//        UserDefaults.standard.removeObject(forKey: "beers")
        
        unarchive()

        if beers.isEmpty {
            let deserterBeer = Beer("Desertora", "Nefasta", 15.9, 5, UIImage(named: "deserter")!)
            save(deserterBeer)
            
            let refugeeBeer = Beer("Refugiada", "Nefasta", 13.9, 4, UIImage(named: "refugee")!)
            save(refugeeBeer)
        }
    }
    
    func save(_ beer: Beer) {
        beers.append(beer)
        
        archive()
    }
    
    func update(_ beer: Beer, at index: Int) {
        beers[index] = beer
        
        archive()
    }
    
    func delete(at index: Int) {
        beers.remove(at: index)
        
        archive()
    }
    
    private func archive() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: beers, requiringSecureCoding: true)
            
            UserDefaults.standard.set(data, forKey: "beers")
        } catch {
            print("[ERROR] Saving a beer: \(error)")
        }
    }
    
    private func unarchive() {
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
