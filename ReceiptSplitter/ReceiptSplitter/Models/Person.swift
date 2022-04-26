//
//  Person.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 4/1/21.
//

import Foundation

class Person: Hashable {
    @Published var name: String
    @Published var items: ItemList
    
    init(name: String) {
        self.name = name
        items = ItemList()
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    // return the total cost associated with each person (not including tax)
    func getTotalCostWithoutTax() -> Float {
        var total_cost: Float = 0
        for item in items.list {
            total_cost += item.price_per_buyer
        }
        return total_cost
    }
    
    // return the total tax amount associated with each person
    func getTotalTax() -> Float {
        var total_tax: Float = 0
        for item in items.list {
//            print("Tax of \(item.name) is $\(item.getItemTaxPerBuyer())")
            total_tax += item.getItemTaxPerBuyer()
        }
        return total_tax
    }
    
    // all cost = total cost without tax + total tax
    func getTotalCostWithTax() -> Float {
        return getTotalTax() + getTotalCostWithoutTax()
    }
    
}

