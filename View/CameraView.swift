//
//  CameraView.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/21.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View{
        ZStack{
            CameraPreView(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                if camera.isTaken{
                    HStack{
                        Spacer()
                        Button(action: camera.reTake, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.trailing, 10)
                    }
                }
            }
        }
        .onAppear(perform: {
            camera.checkPermission()
        })
        .alert(isPresented: $camera.alert){
            Alert(title: Text("Please Enable Camera Access"))
        }
    }
}

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
