//
//  Home.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/20.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        
        VStack {
            if homeData.imageData.count == 0 {
                Text("Pick An Image To Progress")
            }
        }
        .toolbar {
            // image button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {homeData.imagePicker.toggle()}) {
                    Image(systemName: "photo")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $homeData.imagePicker) {
            ImagePicker(picker: $homeData.imagePicker, imageData: $homeData.imageData)
        }
    }
}
