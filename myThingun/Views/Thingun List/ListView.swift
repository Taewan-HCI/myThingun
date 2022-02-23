//
//  delete.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/21.
//

import SwiftUI

struct ListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //@EnvironmentObject var model:ThingunModel
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "content", ascending: true)])
    private var thinguns: FetchedResults<Thingun>
    
    @State private var filterBy = ""
    @State private var showingAlert = false

    
    private var filteredThinguns: [Thingun] {
        
        if filterBy.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //no filter text
            return Array(thinguns)
        }
        else {
            //filtered by the search term and return a subset of thingun which contain
            return thinguns.filter { t in
                
                return t.content.contains(filterBy)
                
                
            }
        }
    }

    
    var body: some View {
        
        NavigationView{
        VStack (spacing: 10){
            
            VStack (alignment:.leading, spacing: 10){
                Text("FeaturedViewTitle")
                    .bold()
                    .padding(.top, 40)
                    .font(.custom("SeoulNamsanB", size:28))
                Text("ListViewSubTitle")
                    .padding(.bottom, 10)
                    .font(.custom("SeoulNamsanL", size:15))
                
                SearchBarView(filterBy: $filterBy)
                    .padding([.trailing, .bottom])
            }.padding(.horizontal)
            
            
            
            
            // your regular view body
            List {
                ForEach(filteredThinguns) { p in
                    NavigationLink(destination: ThingunDetailView(thingun: p)) {
                        
                            //list 하나
                            HStack (spacing:10)  {
                                let image = UIImage(data: p.image ?? Data()) ?? UIImage()
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50, alignment: .leading)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                VStack (alignment:.leading, spacing: 10) {
                                    Text(p.content)
                                        .foregroundColor(.black)
                                        .font(.custom("SeoulNamsanM", size:15))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    Text(p.author)
                                        .font(.custom("SeoulNamsanM", size:11))
                                        .foregroundColor(.gray)
                                }
                                
                            }
                        
                    }
                    
                    
                    
                    
                }
                .onDelete(perform: removeLanguages)
                //.onDelete(perform: removeLanguages)
                .listRowSeparator(.hidden)
                
            }.listStyle(.plain)
            
            Spacer()
            
            VStack (alignment:.center){
                Text("CardCount \(thinguns.count)")
                    .font(.custom("SeoulNamsanB", size:15))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationBarHidden(true)

        
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("AlertTitle_delte"),
                          message: Text("AlertContent_delte"),
                          dismissButton: .default(Text("AlertButton_delte")))
                }
         
        }
        
        
        
        
        

    
    func removeLanguages(at offsets: IndexSet) {
        
        if thinguns.count == 1 {
            showingAlert = true
        }
        else{
            for index in offsets {
                viewContext.delete(thinguns[index])
            }
            do {
                try viewContext.save()
                
            } catch {
                print(error)
            }
        }
        
        

    }
    


    
}

