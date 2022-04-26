//
//  ItemList.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 4/1/21.
//

import Foundation
class ItemList: ObservableObject {
    @Published var list: [Item]
    
    init() {
        list = []
    }
    
    // return true if item was not in the list, item will be added to the list
    // return false if item was in the list before, item will be removed from the list
    func addRemoveItem(_ item: Item) -> Bool {
        for (index, currItem) in list.enumerated() {
            if item.id == currItem.id { // item is currently in the list
                list.remove(at: index)
                return false
            }
        }
        list.append(item)
        return true
    }
}
