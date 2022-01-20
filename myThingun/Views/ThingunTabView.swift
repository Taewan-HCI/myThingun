//
//  ContentView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import SwiftUI

struct ThingunTabView: View {
    
    @State private var tabSelection = 0
    var body: some View {
        
        
        
        TabView (selection: $tabSelection) {
            ThingunFeaturedView()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("내가 좋아하는 띵언")
                        .font(.custom("SeoulNamsanM", size:12))
                    
                }
                .tag(0)
       
            AddThingunView(tabSelection: $tabSelection)
                .tabItem{
                    Image(systemName: "plus.rectangle.portrait")
                    Text("띵언카드 추가")
                        .font(.custom("SeoulNamsanM", size:12))
                }
                .tag(1)
            
            ThingunListView()
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("모든 띵언 보기")
                        .font(.custom("SeoulNamsanM", size:12))
                }
                .tag(2)
        }
        .environmentObject(ThingunModel())
        
        
        
    }
}
