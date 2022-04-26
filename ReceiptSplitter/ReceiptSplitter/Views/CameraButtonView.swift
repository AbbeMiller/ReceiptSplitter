//
//  CameraButtonView.swift
//  ReceiptSplitter
//
//  Created by Iris Truong on 3/19/21.
//

import SwiftUI

struct CameraButtonView: View {
    @EnvironmentObject var parseImage:ParseImageModel
    @State var parsing = false
    @State var displayImage: UIImage = UIImage()
    @State var showPhotos:Bool = false
    @State var showAlert = false
    @State var showImage = false
    @Binding var tabSelection: Int
    
    
    var body: some View {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            VStack {
                Text("This device does not support the camera feature")
                    .scaledToFit()
                Text("Try importing photo or using another device")
                    .scaledToFit()
            }
        } else {
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
                                    Text("Take Photo")
                                }
                            }.frame(width: 150, height: 50)
                            .background(Color.blue)
                            .padding(5).font(.title2).foregroundColor(.white)
                            Button("Parse Image") {
                                parseImage.processImage(image: self.displayImage)
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
                            ImageImporter(sourceType: .camera, imageSelected: $displayImage)
                        }.alert(isPresented: $showAlert) {
                            Alert(title: Text("No Items Found"), message: Text("Please scan a valid receipt or try again"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
        }
            
//            VStack {
//
//
//                Image(uiImage: self.displayImage)
//                    .resizable()
//                    .scaledToFill()
//
//                // print "parsing" after button has been pressed
//                if parsing{
//                    Text("parsing...")
//                        .foregroundColor(.black)
//                }
//                // calls parse from model
//                Button("Parse Image"){
//                    parsing = true
//                    parseImage.processImage(image: self.displayImage)
//                }
//                .background(Color.blue)
//                .foregroundColor(.white)
//
//                Button(action: {
//                    showPhotos = true
//                }) {
//                    HStack {
//                        Text("Take Photo")
//                    }
//                }.frame(width: 150, height: 50)
//                .background(Color.blue)
//                .padding(5).font(.title2).foregroundColor(.white)
//            }.sheet(isPresented: $showPhotos) {
//                ImageImporter(sourceType: .camera, imageSelected: $displayImage)
//            }
//        }
    }
}

struct CameraButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonView(tabSelection: .constant(1)).environmentObject(ParseImageModel())
    }
}

