//
//  Cameara.swift
//  duri-mood
//
//  Created by 김두리 on 2021/05/21.
//

import SwiftUI
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    
    @Published var output = AVCapturePhotoOutput()
    @Published var pictureData = Data(count: 0)
    @Published var alert = false
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                (status) in
                if status{
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    
    }
    
    func setUp() {
        do {
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        }
        
        catch{
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        DispatchQueue.global(qos: .background).async {
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation {self.isTaken.toggle()}
            }
        }
    }
    
    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                
                self.isSaved = false
                self.picData = Data(count: 0)
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo:  AVCapturePhoto, error: Error?) {
        
        if error != nil {
            return
        }
        
        print("pic taken..")
        
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        
        self.picData = imageData
    }
    
    func savePic() {
        guard let image = UIImage(data: self.picData) else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        print("saved sucecussfully...")
    }
    
}
