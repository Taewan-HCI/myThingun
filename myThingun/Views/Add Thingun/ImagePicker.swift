//
//  ImagePicker.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    var selectedSource: UIImagePickerController.SourceType
    @Binding var image:UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        //create the image picker controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        
        //check that this source is availble first
        if UIImagePickerController.isSourceTypeAvailable(selectedSource) {
            imagePickerController.sourceType = selectedSource
        }
        
        
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        //create a coordinator
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //check if we can get the image
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               //we were able to get the uiimage into the image constant, pass this back
                parent.image = image
            }
            //dismiss this view
            parent.presentationMode.wrappedValue.dismiss()
            
        }
        
    }
}
