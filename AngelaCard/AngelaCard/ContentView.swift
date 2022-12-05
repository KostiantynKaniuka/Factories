//
//  ContentView.swift
//  AngelaCard
//
//  Created by Kostiantyn Kaniuka on 02.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("Front")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(
                        Circle().strokeBorder(Color.white, lineWidth: 5)
                    )
                Text("Kostiantyn")
                    .font(Font.custom("San Francisco", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(Font.custom("San Francisco", size: 20))
                Divider()
                InfoView(text: "+228148833", imageName: "phone")
                InfoView(text: "heyhocombo@gmail.com", imageName: "envelope")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
