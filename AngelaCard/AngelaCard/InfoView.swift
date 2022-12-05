//
//  InfoView.swift
//  AngelaCard
//
//  Created by Kostiantyn Kaniuka on 05.12.2022.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 60.0)
            .foregroundColor(.white)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                (Text(text))
            })
            .padding(.all)
    }
}



struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "kek", imageName: "phone")
            .previewLayout(.sizeThatFits)
    }
}
