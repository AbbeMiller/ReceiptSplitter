//
//  Preview.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 4/1/21.
//

//import SwiftUI
//
//struct Preview: View {
//    @StateObject var parseImage: ParseImageModel = ParseImageModel()
//    @StateObject var peopleModel: PeopleModel = PeopleModel()
//    var body: some View {
//            TabView{
//                CameraButtonView().environmentObject(parseImage)
//                    .tabItem{
//                        Label("Take Photo",systemImage: "camera")
//                    }
//                ImportButtonView().environmentObject(parseImage)
//                    .tabItem{
//                        Label("Import Photo", systemImage: "folder.circle")
//                    }
//                ParsedTextView().environmentObject(parseImage)
//                    .tabItem{
//                        Label("View Parsed Text",systemImage: "square.and.pencil")
//                    }
//                PeopleView().environmentObject(peopleModel)
//                    .tabItem{
//                    Label("View Members",systemImage:"person.3.fill")
//                }
//            }
//            
//        
//    }
//}
//
//struct Preview_Previews: PreviewProvider {
//    static var previews: some View {
//        Preview()
//    }
//}
