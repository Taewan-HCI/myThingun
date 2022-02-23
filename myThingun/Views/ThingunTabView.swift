//
//  ContentView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

struct ThingunTabView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "content", ascending: true)])
    private var thinguns: FetchedResults<Thingun>
    
    @State private var tabSelection = 0
    var body: some View {
        
        
        
        TabView (selection: $tabSelection) {
            
           
            ThingunFeaturedView()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("tab1")
                        .font(.custom("SeoulNamsanM", size:12))
                    
                }
                .tag(0)
           
                
       
            AddThingunView(tabSelection: $tabSelection)
                .tabItem{
                    Image(systemName: "plus.rectangle.portrait")
                    Text("tab2")
                        .font(.custom("SeoulNamsanM", size:12))
                }
                .tag(1)
            
            ListView()
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("tab3")
                        .font(.custom("SeoulNamsanM", size:12))
                }
                .tag(2)
            
            
        }
        .environmentObject(ThingunModel())
        
        
        
    }
}
