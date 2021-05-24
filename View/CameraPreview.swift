//
//  CameraPreview.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/24.
//

import SwiftUI
import AVFoundation

struct CameraPreView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
}
