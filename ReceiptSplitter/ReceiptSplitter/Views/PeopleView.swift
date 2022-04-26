//
//  PeopleView.swift
//  ReceiptSplitter
//
//  Created by Autumn on 4/1/21.
//

import Foundation
import SwiftUI

struct PeopleView: View {
    @EnvironmentObject var people_model:PeopleModel
    // I could've just kept a array here, but then the list would be hard to access for other views, so I store it in PeopleModel
    @State var add_person: String = String()
    @State var remove_person: String = String()
    @State var empty:Bool = true
    @State private var showingDetail = false
    
    init(){
        self.add_person = String()
        self.remove_person = String()
    }
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing:20){
//            Text("Current Member List")
//                .font(.system(size: 30))
//                .bold()
//                .frame(width: 200, height: 100)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            if people_model.people_list.count == 0 {

                Text("You currently have no buyers")
                    .bold()
                    .frame(alignment: Alignment.center)
                    .padding()
            } else {
                List{
                    ForEach(people_model.people_list,id:\.self) { person in
                        HStack {
                            Text("\(person.name): $\(String(format: "%.2f", person.getTotalCostWithTax()))")
                            Button("Show Details") {
                                showingDetail = true
                            }
                            .sheet(isPresented: $showingDetail) {
                                DetailCostView(person: person)
                            }
                            .foregroundColor(.blue)
                        }
                        
                    }
                }.foregroundColor(.black)
            }
            HStack(){
                Text("Add Name")
                    .font(.callout)
                    .bold()
                    .frame(width: 100, height: 50)
                TextField("Add Name",text:$add_person){
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 150, height: 50)


                Button("Add"){
                    people_model.add(name:add_person)
                    empty = false
                    add_person = ""
                }.frame(width: 50, height: 25)
                .padding(20).font(.title2).foregroundColor(.blue)
            }
            HStack(){

                Text("Remove Name")
                    .font(.callout)
                    .bold()
                    .frame(width: 100, height: 50)
                TextField("Remove Name",text:$remove_person){
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 150, height: 50)

                Button("Remove"){
                    people_model.remove(name:remove_person)
                    remove_person = ""
                }.frame(width: 85, height: 25)
                .padding(5).font(.title2).foregroundColor(.blue)
                
            }
            Spacer()
        }

    }
}


struct DetailCostView: View {
    @Environment(\.presentationMode) var presentationMode
    let person: Person
    

    var body: some View {
        Text("Cost Details for \(person.name)")
            .font(.system(size: 30))
            .bold()
            .frame(alignment: .center)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .padding(30)
        List {
            ForEach(person.items.list, id:\.self) { item in
                let price_formatted = String(format: "%.2f", item.price_per_buyer)
                Text("\(item.name): $\(price_formatted)").foregroundColor(.black)
            }
            
        }
        let total_without_tax = String(format: "%.2f", person.getTotalCostWithoutTax())
        let tax_amount = String(format: "%.2f", person.getTotalTax())
        let total_with_tax = String(format: "%.2f", person.getTotalCostWithTax())
        VStack {
            Text("SUBTOTAL: $\(total_without_tax)")
                .bold()
                .frame(alignment: .center)
                .foregroundColor(.black)
                .padding(1)
            
            Text("TAX: $\(tax_amount)")
                .bold()
                .frame(alignment: .center)
                .foregroundColor(.black)
                .padding(1)
            Text("TOTAL: $\(total_with_tax)")
                .bold()
                .frame(alignment: .center)
                .foregroundColor(.black)
                .padding(1)
        }.padding()
        
        Button("Close") {
            presentationMode.wrappedValue.dismiss()
        }
        .frame(alignment: .center)
        .foregroundColor(.blue)
        .padding(30)
        
    }
}


struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView().environmentObject(PeopleModel())
    }
}
