//
//  ThingunFeaturedView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

struct ThingunFeaturedView: View {
    
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    @State var cardCountIndex = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //@EnvironmentObject var model:ThingunModel
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "content", ascending: true)])
    private var thinguns: FetchedResults<Thingun>
    
    @State private var filterBy = ""
    
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
        
        VStack(spacing: 10) {
            
            VStack (alignment:.leading, spacing:10) {
                Text("FeaturedViewTitle")
                    .bold()
                    .padding(.top, 40)
                    .padding(.horizontal)
                    .font(.custom("SeoulNamsanB", size:28))
                Text("FeaturedViewSubTitle")
                    .font(.custom("SeoulNamsanL", size:15))
                    .padding(.horizontal)
                
                
                
                GeometryReader { geo in
                    
                    TabView (selection: $tabSelectionIndex) {
                        
                        // Loop through each recipe
                        ForEach (filteredThinguns, id: \.self) { t in
                            
                            // 카드를 하나씩
                            
                            // Recipe card button
                            Button(action: {
                                
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                                
                            }, label: {
                                
                                // Recipe card
                                ZStack {
                                    
                                    
                                    let image = UIImage(data: t.image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                        
                                        Text(t.content)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: geo.size.width - 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .font(.custom("SeoulNamsanB", size:22))
                                            .lineSpacing(3)
                                            .background(Color.white.opacity(0.7))
                                            .cornerRadius(5)
                                        
                                        
                                    
                                       
                                     
                                    
                                    
                                    
                                    
                                }
                                
                            })
                                .tag(t)
                                .sheet(isPresented: $isDetailViewShowing) {
                                    // Show the Recipe Detail View
                                    ThingunDetailView(thingun:t)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: geo.size.width - 40, height: geo.size.height - 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(15)
                                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                            
                            
                        }
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                
                    
                }
            }
            
            
            VStack (alignment:.center){
                Text("CardCount \(thinguns.count)")
                    .font(.custom("SeoulNamsanB", size:15))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
        
        
    }
    
    
    
    func setFeaturedIndex() {
        
        // Find the index of first recipe that is featured
        let index = thinguns.firstIndex { (thingun) -> Bool in
            return thingun.featured
        }
        tabSelectionIndex = index ?? 0
    }
    
}
