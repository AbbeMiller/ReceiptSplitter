//
//  PeopleModel.swift
//  ReceiptSplitter
//
//  Created by Autumn on 4/1/21.
//

import Foundation
class PeopleModel:ObservableObject {
    @Published var people_list: [Person]
    
    init() {
        people_list = [Person]()
    }
    
    func add(name: String){
        if (self.indexOf(name) != -1) {
            print("You cannot add the same person twice!") // TO DO: Add alert for this
        } else {
            people_list.append(Person(name: name))
        }
    }
    
    func remove(name:String){
        let index: Int = self.indexOf(name)
        if (index != -1){
            
            // remove person from buyer list of all items
            for item in people_list[index].items.list {
                item.removeBuyer(people_list[index])
            }
            
            // remove person from people list
            people_list.remove(at: index)
            
        } else {
            print("\(name) is not in the list")
        }
    }
    
    func indexOf(_ name: String) -> Int {
        for i in (0..<people_list.count) {
            if people_list[i].name == name {
                return i
            }
        }
        return -1
    }
    
    func getNames() -> [String] {
        var names: [String] = []
        for i in 0..<people_list.count {
            names.append(people_list[i].name)
        }
        return names
    }
}
