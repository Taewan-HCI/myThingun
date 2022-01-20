//
//  ThingunFeaturedView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

struct ThingunFeaturedView: View {
    
    
    //@EnvironmentObject var model:ThingunModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "content", ascending: true)], predicate: NSPredicate(format: "featured == true")) var thinguns: FetchedResults<Thingun>
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            VStack (alignment:.leading, spacing:10) {
                Text("나만의 띵언")
                    .bold()
                    .padding(.top, 40)
                    .padding(.horizontal)
                    .font(.custom("SeoulNamsanB", size:28))
                Text("내 삶에 힘이 되는 나만의 띵언을 모아보세요.")
                    .font(.custom("SeoulNamsanL", size:15))
                    .padding(.horizontal)
                
                
                
                GeometryReader { geo in
                    
                    TabView (selection: $tabSelectionIndex) {
                        
                        // Loop through each recipe
                        ForEach (0..<thinguns.count) { index in
                            
                            // Only show those that should be featured
                            
                            
                            // Recipe card button
                            Button(action: {
                                
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                                
                            }, label: {
                                
                                // Recipe card
                                ZStack {
                                    
                                    
                                    let image = UIImage(data: thinguns[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    
                                    Text(thinguns[index].content)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: geo.size.width - 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .font(.custom("SeoulNamsanB", size:22))
                                        .background(Color.white.opacity(0.7))
                                        .cornerRadius(5)
                                    
                                    
                                    
                                    
                                }
                                
                            })
                                .tag(index)
                                .sheet(isPresented: $isDetailViewShowing) {
                                    // Show the Recipe Detail View
                                    ThingunDetailView(thingun: thinguns[index])
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: geo.size.width - 40, height: geo.size.height - 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(15)
                                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                            
                            
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    
                }
            }
            
            
            VStack (alignment:.center){
                Text("지금까지 모은 띵언카드: \(thinguns.count) 장")
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
