//
//  FilteredImage.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/20.
//

import SwiftUI
import CoreImage

struct FilteredImage: Identifiable {
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    
    
}
