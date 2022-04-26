//
//  Item.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 4/1/21.
//

import Foundation

var countIDs = 0

class Item: ObservableObject, Hashable {
    @Published var name: String
    @Published var price: Float
    @Published var id: Int
    @Published var buyers_list: [Person]
    @Published var price_per_buyer: Float
    @Published var tax_percent: Float
    
    init(name: String, price: Float) {
        self.name = name
        self.price = price
        self.id = Item.generateNewID()
        self.buyers_list = []
        self.price_per_buyer = 0
        tax_percent = 0.075 // default tax of each item, TO DO: update this value after parsing tax
    }
    
    func getItemTaxPerBuyer() -> Float {
        return tax_percent * price_per_buyer
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func generateNewID() -> Int {
        countIDs += 1
        return countIDs
    }
    
    // this price not include tax
    // returns price of this item per buyer
    func updateItemPricePerBuyer() {
        if buyers_list.count != 0 {
            price_per_buyer = price / Float(buyers_list.count)
        } else {
            price_per_buyer = 0
        }
    }
    
    func addBuyer(_ buyer: Person) {
        print("Add buyer: \(buyer.name) to buyer list of item \(self.name)")
        buyers_list.append(buyer)
        updateItemPricePerBuyer()
    }
    
    // return true if buyer is removed successfully
    func removeBuyer(_ buyer: Person) -> Bool {
        print("Remove buyer: \(buyer.name) from buyer list of item \(self.name)")
        for (index, currBuyer) in buyers_list.enumerated() {
            if buyer.name == currBuyer.name {
                buyers_list.remove(at: index)
                updateItemPricePerBuyer()
                return true
            }
        }
        return false
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(price)
        hasher.combine(id)
    }
}
