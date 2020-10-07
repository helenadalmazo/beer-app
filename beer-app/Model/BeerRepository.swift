//
//  Repository.swift
//  beer-app
//
//  Created by Helena Dalmazo on 03/09/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class BeerRepository {
    
    static let shared = BeerRepository()
    
    var beers = [Beer]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        let directory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first
        print("[INFO] App directory \(directory)")
        
        load()

        if beers.isEmpty {
            saveSamples()
        }
    }
    
    func load(filter: String? = nil) {
        do {
            let request = Beer.fetchRequest() as NSFetchRequest<Beer>
            
            if let filter = filter, !filter.isEmpty {
                request.predicate = NSPredicate(format: "(name CONTAINS[cd] %@) OR (brewery CONTAINS[cd] %@)", filter, filter)
            }

            beers = try context.fetch(request)
        } catch {
            print("[ERROR] Loading beers: \(error)")
        }
    }
    
    func save(_ beer: Beer) {
        beers.append(beer)
        
        saveContext()
    }
    
    func update(_ beer: Beer, at index: Int) {
        beers[index] = beer
        
        saveContext()
    }
    
    func delete(at index: Int) {
        context.delete(beers[index])
        
        beers.remove(at: index)
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("[ERROR] Saving a beer: \(error)")
        }
    }
    
    private func saveSamples() {
        let deserterBeer = Beer(context: context)
        deserterBeer.name = "Desertora"
        deserterBeer.brewery = "Nefasta"
        deserterBeer.price = 15.9
        deserterBeer.rating = 5
        deserterBeer.image = UIImage(named: "deserter")!.pngData()!
        deserterBeer.color = UIColor.white
        save(deserterBeer)

        let refugeeBeer = Beer(context: context)
        refugeeBeer.name = "Refugiada"
        refugeeBeer.brewery = "Nefasta"
        refugeeBeer.price = 13.9
        refugeeBeer.rating = 4
        refugeeBeer.image = UIImage(named: "refugee")!.pngData()!
        refugeeBeer.color = UIColor.white
        save(refugeeBeer)
    }
}
