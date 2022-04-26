//
//  AllItemsToBuyersView.swift
//  ReceiptSplitter
//
//  Created by Iris Truong on 4/17/21.
// This is for debugging only. Can delete later
//

import Foundation
import SwiftUI

struct ItemsAndBuyersView: View {
    @EnvironmentObject var parseImage:ParseImageModel
    @EnvironmentObject var personModel: PeopleModel
    
    
    var body: some View {
        Group {
            Text("Buyers of each item")
                .font(.system(size: 30))
                .bold()
//                            .frame(width: 200, height: 100)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding(7)
            List {
                ForEach(parseImage.itemList, id:\.self) { item in
                    Text("Item: \(item.name), id: \(item.id)")
                    ForEach (item.buyers_list, id:\.self) { buyer in
                        Text("\(buyer.name)").padding()
                    }
                }
            }
            Spacer()
            Text("Items of each buyer")
                .font(.system(size: 30))
                .bold()
//                            .frame(width: 200, height: 100)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding(7)
            List {
                ForEach(personModel.people_list, id:\.self) { person in
                    Text("Person: \(person.name)")
                    ForEach (person.items.list, id:\.self) { item in
                        Text("\(item.name)").padding()
                    }
                    
                }
            }
            
        }
    }
}

