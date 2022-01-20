//
//  ThingunListView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

struct ThingunListView: View {
    
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
        
        NavigationView{
            
            VStack (spacing:10) {
                
                VStack (alignment:.leading, spacing: 10) {
                    Text("모든 띵언들")
                        .bold()
                        .padding(.top, 40)
                        .font(.custom("SeoulNamsanB", size:28))
                    Text("내 삶에 힘이 되는 나만의 띵언을 모아보세요.")
                        .padding(.bottom, 10)
                        .font(.custom("SeoulNamsanL", size:15))
                    
                    SearchBarView(filterBy: $filterBy)
                        .padding([.trailing, .bottom])
                    //TextField("Filter by...", text: $filterBy)
                    
                    ScrollView {
                        LazyVStack (alignment: .leading) {
                            ForEach(filteredThinguns) { t in
                                
                                NavigationLink(
                                    destination: ThingunDetailView(thingun:t), label: {
                                    
                                        HStack (spacing: 15) {
                                            
                                            let image = UIImage(data: t.image ?? Data()) ?? UIImage()
                                            Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipped()
                                            .cornerRadius(5)
                                        
                                        VStack (alignment:.leading) {
                                            Text(t.content)
                                                .foregroundColor(.black)
                                                .font(.custom("SeoulNamsanM", size:15))
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                            Text(t.author)
                                                .font(.custom("SeoulNamsanM", size:11))
                                                .foregroundColor(.gray)
                                        }
                                        
                                    }
                                    
                                })
                                
                            }
                        }
                    }
                }
                
                
                
               
                
                VStack (alignment:.center){
                    Text("지금까지 모은 띵언카드: \(thinguns.count) 장")
                        .font(.custom("SeoulNamsanB", size:15))
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
            .onTapGesture {
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
            }
            
            
        }
        
        
    }
}
