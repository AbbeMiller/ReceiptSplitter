//
//  ParsedTextView.swift
//  ReceiptSplitter(AUT)
//
//  Created by Autumn on 3/18/21.
//

import Foundation
import SwiftUI

struct ItemView: View {
    @EnvironmentObject var personModel: PeopleModel
    @State private var showActionSheet = false

    let item: Item

    var body: some View {
        let item_price: Float = item.price
        let price_formatted = String(format: "%.2f", item_price)
        Button("\(item.name), $\(price_formatted)") {
            showActionSheet = true
        }.actionSheet(isPresented: $showActionSheet) {
            generateActionSheet()
        }.foregroundColor(.black)
        if item.buyers_list.count != 0 {
            HStack {
                ForEach (item.buyers_list, id:\.self) { buyer in
                    Text("\(buyer.name)").padding().foregroundColor(.gray)
                }
            }
            Text("Price/buyer: $\(String(format: "%.2f", item.price_per_buyer))")
                .padding()
                .foregroundColor(.gray)
            
        }
        
    }
    
    func generateActionSheet() -> ActionSheet {
        let buttons = personModel.people_list.enumerated().map { i, person in
            Alert.Button.default(Text(person.name), action: {
                //print ("People list: \(personModel.people_list[i].name)")
                let isAdded: Bool = personModel.people_list[i].items.addRemoveItem(item) // add/remove the item from the item list of this person
                if isAdded == true { // if the item was not in the item list of this person -> add
                    item.addBuyer(personModel.people_list[i]) // add this person to buyers_list of this item
                    print("Add Item: \(item.name), person: \(person.name)")
                } else { // if the item was in the item list of this person -> remove
                    item.removeBuyer(personModel.people_list[i]) // remove this person from buyers_list of this item
                    print("Remove Item: \(item.name), person: \(person.name)")
                }
            })
        }
        return ActionSheet(title: Text("Item: \(item.name)"),
                           message: Text("Add/remove a buyer for this item"), buttons: buttons + [Alert.Button.cancel()])
    }
}

struct ParsedTextView: View {
    @EnvironmentObject var parseImage:ParseImageModel
    @EnvironmentObject var personModel: PeopleModel
    @State private var showAlert = false
    
    var body: some View {
//        List {
//            ForEach(parseImage.itemList, id:\.self) { item in
//                Button("\(item.name)") {
//                    showActionSheet = true
//                }.actionSheet(isPresented: $showActionSheet) {
//                    generateActionSheet(item: item)
//                }.foregroundColor(.black)
//            }
//        }
        Group {
            if parseImage.itemList.count == 0 {
                Text("Please select and parse a receipt image")
            } else {
                Group {
                    Text("Please click on each item to assign buyers")
                        .font(.system(size: 25))
                        .bold()
                        .frame(alignment: .center)
                        .foregroundColor(.blue)
                        .padding()
//                        Text("Note: You can click on each item multiple times to assign multiple buyers")
//                            .italic()
//                            .frame(alignment: .center)
//                            .foregroundColor(.gray)
//                            .padding()
                    
                    if personModel.people_list.count > 0 {
                        List {
                            ForEach(parseImage.itemList, id:\.self) { item in
                                ItemView(item: item)
                            }
                        }
                    } else {
                        List {
                            ForEach(parseImage.itemList, id:\.self) { item in
                                let price_formatted = String(format: "%.2f", item.price)
                                Button("\(item.name), $\(price_formatted)"){
                                    showAlert = true
                                }.foregroundColor(.black)
                                //                        Button("\(item.name)") {
                                //                            showActionSheet = true
                                //                        }.actionSheet(isPresented: $showActionSheet) {
                                //                            generateActionSheet(item: item)
                                //                        }.foregroundColor(.black)
                            }
                        }
                    }
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("No Buyers Added"), message: Text("Please add buyers before assigning items"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct ParsedTextView_Previews: PreviewProvider {
    static var previews: some View {
        ParsedTextView().environmentObject(ParseImageModel())
    }
}
