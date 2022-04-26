//
//  ReceiptSplitterApp.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 3/17/21.
//

import SwiftUI

@main
struct ReceiptSplitterApp: App {
    @StateObject var parseImage: ParseImageModel = ParseImageModel()
    @StateObject var peopleModel: PeopleModel = PeopleModel()
    @State private var tabSelection = 1
    var body: some Scene {
        WindowGroup {
            ReceiptSplitterView()
        }
    }
}
