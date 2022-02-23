//
//  ThingunDetailView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

struct ThingunDetailView: View {
    @State private var tabSelection = 1
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingEditScreen = false
    
    
        

    
    var thingun:Thingun
    
    var body: some View {
        
        //Image
        NavigationView{
            VStack (alignment:.center) {
                
                
                
                VStack{
                    let image = UIImage(data: thingun.image ?? Data()) ?? UIImage()
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipped()
                    
                }
                
                //contents
                
                ScrollView{
                    VStack (alignment: .leading){
                        HStack {
                            HStack{
                                Image(systemName: "calendar")
                                Text(thingun.date)
                                    .font(.custom("SeoulNamsanL", size:15))
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "person.fill")
                                Text(thingun.author)
                                    .font(.custom("SeoulNamsanL", size:15))
                            }
                        }.padding()
                        
                        
                        Text(thingun.content)
                            .bold()
                            .font(.custom("SeoulNamsanB", size:28))
                            .padding()
                        
                        
                        Text(thingun.summary)
                            .font(.custom("SeoulNamsanL", size:15))
                            .padding(.horizontal)
                        
                       
                        
                        
                    }
                    
                    
                }
            }
            .ignoresSafeArea(.container, edges: .top)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showingEditScreen) {
            EditThingunView()
        }
        
        
        
        
    }
    
    
    
}
