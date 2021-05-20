//
//  HomeViewModel.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/20.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class HomeViewModel: ObservableObject {
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)
    
    @Published var allImages: [FilteredImage] = []
    
    // loading filterOption WhenEver Image is Selected
    
    let filters: [CIFilter] = []
    
    func loadFilter() {
        
        let context = CIContext()
        
        filters.forEach { (filter) in
            // loading iamge into filter
            let CiImage = CIImage(data: imageData)
            
            filter.setValue(CiImage!, forKey: kCIInputImageKey)
            //retreving image
            
            
            guard let newImage = filter.outputImage else {
                return
            }
            
            let cgimage = context.createCGImage(newImage, from: newImage.extent)
            let filteredData = FilteredImage(image: UIImage(cgImage: cgimage!), filter: filter)
            
            self.allImages.append(filteredData)
        }
    }
}
