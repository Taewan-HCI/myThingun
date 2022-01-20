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
                Text("추가하려는 띵언은?")
                    .font(.custom("SeoulNamsanB", size:20))
                    .foregroundColor(.black)
                    TextField("내가 추가하려는 띵언이 무엇이냐면..", text: $content)
                    .font(.custom("SeoulNamsanL", size:18))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("같이 남기고 싶은 메모?")
                    .font(.custom("SeoulNamsanB", size:20))
                TextField("오늘같은 날에는..", text: $summary)
                    .font(.custom("SeoulNamsanL", size:18))
                .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("누가?")
                    .font(.custom("SeoulNamsanB", size:20))
                TextField("여기에 적어주세요..", text: $author)
                    .font(.custom("SeoulNamsanL", size:18))
                .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("언제로 기억되기 원하나요?")
                    .font(.custom("SeoulNamsanB", size:20))
                TextField("여기에 적어주세요..", text: $date)
                    .font(.custom("SeoulNamsanL", size:18))
               
            }
        }
    }
}

