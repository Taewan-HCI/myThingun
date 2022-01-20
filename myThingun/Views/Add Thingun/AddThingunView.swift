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
    
    
    var body: some View {
        
        
        
        VStack (alignment: .leading, spacing: 10){
            HStack{
                
                Button {
                    clear()
                } label: {
                    Text("모두지우기")
                        .font(.custom("SeoulNamsanB", size:15))
                        .foregroundColor(.black)                
                }

                Spacer()
                Button  {
                    addThingun()
                    clear()
                    tabSelection = 0
                } label: {
                    Text("등록하기")
                        .font(.custom("SeoulNamsanB", size:15))
                        .foregroundColor(.black)
                }

                
            }.padding(.top)
            
            Text("새로운 띵언 등록하기")
                .bold()
               
                .font(.custom("SeoulNamsanB", size:28))
            Text("내 삶에 힘이 되는 나만의 띵언을 모아보세요.")
                .padding(.bottom, 10)
                .font(.custom("SeoulNamsanL", size:15))
            
            
            ScrollView (showsIndicators: false) {
                
                VStack (alignment:.leading) {
                    
                    //placeholder image
                    placeHolderImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180)
                        .clipped()
                    
                    HStack{
                        
                        Button {
                            selectedImageSource = .photoLibrary
                            isShowingImagePicker = true
                        } label: {
                            Text("사진첩에서 가져오기")
                                .font(.custom("SeoulNamsanB", size:15))
                                .foregroundColor(.black)
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

