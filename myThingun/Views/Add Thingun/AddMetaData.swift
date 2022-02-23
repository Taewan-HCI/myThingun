//
//  AddMetaData.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/21.
//

import SwiftUI

struct AddMetaData: View {
    
    @Binding var content: String
    @Binding var summary: String
    @Binding var author: String
    @Binding var date: String
    
    var body: some View {
        Group {
            VStack (alignment: .leading) {
                Text("InputTitle_1")
                    .font(.custom("SeoulNamsanB", size:20))
                    .foregroundColor(.black)
                    TextField("InputSubTitle_1", text: $content)
                    .font(.custom("SeoulNamsanL", size:18))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("InputTitle_2")
                    .font(.custom("SeoulNamsanB", size:20))
                TextField("InputSubTitle_2", text: $summary)
                    .font(.custom("SeoulNamsanL", size:18))
                .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("InputTitle_3")
                    .font(.custom("SeoulNamsanB", size:20))
                TextField("InputSubTitle_3", text: $author)
                    .font(.custom("SeoulNamsanL", size:18))
                .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("InputTitle_4")
                    .font(.custom("SeoulNamsanB", size:20))
                TextField("InputSubTitle_4", text: $date)
                    .font(.custom("SeoulNamsanL", size:18))
               
            }
        }
    }
}

