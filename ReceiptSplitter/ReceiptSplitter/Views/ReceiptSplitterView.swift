//
//  ReceiptSplitterView.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 4/16/21.
//

import SwiftUI

struct ReceiptSplitterView: View {
    @StateObject var parseImage: ParseImageModel = ParseImageModel()
    @StateObject var peopleModel: PeopleModel = PeopleModel()
    @State private var tabSelection = 1
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.ignoresSafeArea()
            VStack {
                Text("Receipt Splitter").font(.largeTitle).bold().foregroundColor(.white)
                Text("Select an Option").font(.title).foregroundColor(.white)
                List {
                    NavigationLink( destination: CameraButtonView(tabSelection: $tabSelection).environmentObject(parseImage).navigationBarTitle("Take Photo")) {
                        Text("Take Photo")
                            .font(.largeTitle).padding().foregroundColor(.blue)
                    }
                    NavigationLink( destination: ImportButtonView(tabSelection: $tabSelection).environmentObject(parseImage).navigationBarTitle("Import Photo")) {
                        Text("Import Photo")
                            .font(.largeTitle).padding().foregroundColor(.blue)
                    }
                    NavigationLink( destination:  PeopleView().environmentObject(peopleModel).navigationBarTitle("Buyers and Costs")) {
                        Text("Add Buyers/See Cost")
                            .font(.largeTitle).padding().foregroundColor(.blue)
                    }
                    NavigationLink( destination: ParsedTextView().environmentObject(parseImage).environmentObject(peopleModel)
                                        .navigationBarTitle("Items")) {
                        Text("Assign Items to Buyers").font(.largeTitle).padding().foregroundColor(.blue)
                    }
                    
//                    NavigationLink( destination:  ItemsAndBuyersView().environmentObject(parseImage).environmentObject(peopleModel)
//                        .navigationBarTitle("Items and Buyers")) {
//                        Text("(Working) Items of Each Person")
//                            .font(.largeTitle).padding().foregroundColor(.blue)
//                    }
                }
            }
            }
        }
    }
}

struct ReceiptSplitterView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptSplitterView()
    }
}
