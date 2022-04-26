//
//  ImageImport.swift
//  ReceiptSplitter
//
//  Created by Abbe Miller on 3/17/21.
//

import SwiftUI

final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImageImporter
    
    init(_ parent: ImageImporter) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parent.imageSelected = image
        }
        
        parent.presentationMode.wrappedValue.dismiss()
    }
}

struct ImageImporter: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var imageSelected: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let importer = UIImagePickerController()
        importer.allowsEditing = false
        importer.sourceType = sourceType
        importer.delegate = context.coordinator
        return importer
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
