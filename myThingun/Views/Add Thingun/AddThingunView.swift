//
//  ThingunRegisterView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/20.
//

import SwiftUI


struct AddThingunView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    //
    @Binding var tabSelection: Int
    
    // properties for recipe meta data
    @State private var content = ""
    @State private var summary = ""
    @State private var author = ""
    @State private var date = ""
    @State private var featured = true
    
    //image picker
    @State private var isShowingImagePicker = false
    @State private var selectedImageSource = UIImagePickerController.SourceType.photoLibrary
    @State private var placeHolderImage = Image("placeholder")
    
    //thingun image
    @State private var image: UIImage?
    
    @State private var showingAlert = false

    
    
    
    
    var body: some View {
        
        
        
        VStack (alignment: .leading, spacing: 10){
            HStack{
                
                Button {
                    clear()
                } label: {
                    Text("Clear all")
                        .font(.custom("SeoulNamsanB", size:15))
                }

                Spacer()
                Button  {
                    if content != "" && summary != "" && author != "" && date != "" && image != nil {
                        addThingun()
                        clear()
                        tabSelection = 0
                    }
                    else {
                        showingAlert = true
                    }
                    
                } label: {
                    Text("Register")
                        .font(.custom("SeoulNamsanB", size:15))
                }

                
            }.padding(.top)
            
            Text("AddViewTitle")
                .bold()
                .font(.custom("SeoulNamsanB", size:28))
            Text("AddViewSubTitle")
                .padding(.bottom, 10)
                .font(.custom("SeoulNamsanL", size:15))
            
            
            ScrollView (showsIndicators: false) {
                
                VStack (alignment:.leading) {
                    
                    //placeholder image
                    
                    
                    HStack (alignment:.center){
                        
                        Button {
                            selectedImageSource = .photoLibrary
                            isShowingImagePicker = true
                        } label: {
                            VStack(alignment: .center){
                                placeHolderImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 180)
                                    .clipped()
                                    .cornerRadius(10)
                                Text("Add from PhotoLibrary")
                                    .font(.custom("SeoulNamsanB", size:15))
                            }
                            
                        }

                        
                        
                        /*
                        Button("Camera") {
                            selectedImageSource = .camera
                            isShowingImagePicker = true
                            
                        }
                         */
                    }
                    .padding(.bottom)
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedSource: selectedImageSource, image: $image)
                    }
                    
                    AddMetaData(content: $content, summary: $summary, author: $author, date: $date)
                    
                    
                    
                }
                
            }
        }
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("AlertTitle_add"),
                          message: Text("AlertContent_add"),
                          dismissButton: .default(Text("AlertButton_delte")))
                }
        .padding(.horizontal)
        .onTapGesture {
            let resign = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
        
    }
    
    func clear() {
        //clear all the form fields
        content = ""
        summary = ""
        author = ""
        date = ""
        
        placeHolderImage = Image("placeholder")
    }
    
    func addThingun() {
        
        let thingun = Thingun(context: viewContext)
        thingun.id = UUID()
        thingun.content = content
        thingun.summary = summary
        thingun.author = author
        thingun.date = date
        thingun.image = image?.jpegData(compressionQuality: 1.0)
        thingun.featured = true
        
        //save to core data
        do {
            //savr the recipe
            try viewContext.save()
            
            //switch the view to list
        }
        catch {
            //couldn't save the recipe
        }
        
        
        
    }
    
    func loadImage() {
        
        //check if an image was selected from the library
        if image != nil {
            placeHolderImage = Image(uiImage: image!)
        }
        
    }
}

