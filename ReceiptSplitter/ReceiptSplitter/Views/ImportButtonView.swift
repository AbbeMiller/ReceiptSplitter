//
//  ImportButtonView.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 3/17/21.
//

import SwiftUI

struct ImportButtonView: View {
    @EnvironmentObject var parseImage:ParseImageModel
    @State var parsing = false
    @State var displayImage: UIImage = UIImage()
    @State var showPhotos:Bool = false
    @State var showAlert = false
    @State var showImage = false
    @Binding var tabSelection: Int
    
    
    var body: some View {
        LoadingView(isShowing: $parseImage.parsing) {
            ScrollView{
                VStack {
                    if self.showImage {
                        Image(uiImage: self.displayImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        ZStack {
                            Rectangle().foregroundColor(.gray).frame(height: 300)
                        }.padding()
                    }
                    // print "parsing" after button has been pressed
//                    if parsing {
//                        ProgressView()
//                    }
                    // calls parse from model
                    HStack {
                        Button(action: {
                            showPhotos = true
                            showImage = true
                        }) {
                            HStack {
                                Text("Import Photo")
                            }
                        }.frame(width: 150, height: 50)
                        .background(Color.blue)
                        .padding(5).font(.title2).foregroundColor(.white)
                        Button("Parse Image") {
                            // parseImage.processImage(image: displayImage)
                            parseImage.processImage(image: #imageLiteral(resourceName: "Costco-Receipt-800x500"))
                            if parseImage.itemList.count > 0 {
                            showAlert = false
                            tabSelection = 3
                            } else {
                            showAlert = true
                            }
                        }.frame(width: 150, height: 50)
                        .background(Color.blue)
                        .padding(5).font(.title2).foregroundColor(.white)
                    
                    }.sheet(isPresented: $showPhotos) {
                        ImageImporter(sourceType: .photoLibrary, imageSelected: $displayImage)
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("No Items Found"), message: Text("Please scan a valid receipt or try again"), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
}

struct ImportButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ImportButtonView(tabSelection: .constant(1)).environmentObject(ParseImageModel())
    }
}
