//
//  SearchBarView.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/20.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var filterBy: String
    @FocusState private var nameIsFocused: Bool
    
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow( radius: 5)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("SearchbarTitle", text: $filterBy)
                    .focused($nameIsFocused)
                Button {
                    filterBy = ""
                    nameIsFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                       
                }

            }
            .padding()
        }
        .frame(height: 48)
        .foregroundColor(.gray)
        
    }
}


