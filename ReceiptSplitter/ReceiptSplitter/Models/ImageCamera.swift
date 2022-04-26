//
//  Camera.swift
//  ReceiptSplitter
//
//  Created by Iris Truong on 3/19/21.
//

import SwiftUI

final class CameraCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImageCamera
    
    init(_ parent: ImageCamera) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parent.imageSelected = image
        }
        
        parent.presentationMode.wrappedValue.dismiss()
    }
}

struct ImageCamera: UIViewControllerRepresentable {
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var imageSelected: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let importer = UIImagePickerController()
        importer.allowsEditing = true
        importer.sourceType = sourceType
        importer.delegate = context.coordinator
        return importer
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> CameraCoordinator {
        CameraCoordinator(self)
    }
}
