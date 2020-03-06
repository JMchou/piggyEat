//
//  FoodArray.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/18/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import Foundation
import CoreData

class Menu {
    
    static let sharedInstance = Menu()
    var foodArray = [Item]()
    
    func saveData(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error occurred when trying to save \(error)")
        }
    }
    
    func loadData(context: NSManagedObjectContext) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            self.foodArray =  try context.fetch(request)
        } catch {
            print("Error occurred when trying to fetch data. \(error)")
        }
    }
    
    func deleteData(context: NSManagedObjectContext, at location: Int) {
        context.delete(self.foodArray[location])
        self.foodArray.remove(at: location)
        self.saveData(context: context)
    }
    
    
}
