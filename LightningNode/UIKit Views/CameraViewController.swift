//
//  CameraViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/11/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: QRCodeScannerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // If Local, Comment out
        if (self.captureSession?.isRunning == false) {
            self.captureSession.startRunning()
        }
                // If not Local, Comment out
        //        let readableString = lndconnectcode
        //        guard let url = URL(string: readableString) else { return }
        //        guard let queryParameters = url.queryParameters else { return }
        //        guard let certificate = queryParameters["cert"]?.base64UrlToBase64() else { return }
        //        guard let macaroonString = queryParameters["macaroon"]?.base64UrlToBase64() else { return }
        //        guard let nodeHostString = url.host else { return }
        //        guard let port = url.port else { return }
        //        let nodeString = "\(nodeHostString):\(port)"
        //        let rnc = RemoteNodeConnection.init(uri: nodeString, certificate: certificate, macaroon: macaroonString)
        //        Current.remoteNodeConnection = rnc
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRNC"), object: nil)
        //        self.dismiss(animated: true) {
        //            print("dissed")
        //        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.captureSession?.isRunning == true) {
            self.captureSession.stopRunning()
        }
    }
    
    func found(code: String) {
        print("Code: \(code)")
        self.delegate?.codeDidFind(code)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            
            // If Local, Comment out
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let readableString = readableObject.stringValue else { return }
            print("Code read: \(readableString)")
            
            // If not Local, Comment out
//            let readableString = lndconnectcode
            
            guard let url = URL(string: readableString) else { return }
            guard let queryParameters = url.queryParameters else { return }
            guard let certificate = queryParameters["cert"]?.base64UrlToBase64() else { return }
            guard let macaroonString = queryParameters["macaroon"]?.base64UrlToBase64() else { return }
            guard let nodeHostString = url.host else { return }
            guard let port = url.port else { return }
            let nodeString = "\(nodeHostString):\(port)"
            let rnc = RemoteNodeConnection.init(uri: nodeString, certificate: certificate, macaroon: macaroonString)
            Current.remoteNodeConnection = rnc
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRNC"), object: nil)
        }
        
        //        dismiss(animated: true)
        dismiss(animated: true) {
            print("Dismissed Camera")
        }
    }
}

extension CameraViewController {
    func setupCaptureSession() {
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (self.captureSession.canAddInput(videoInput)) {
            self.captureSession.addInput(videoInput)
        } else {
            deviceInputFail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if (self.captureSession.canAddOutput(metadataOutput)) {
            self.captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            deviceInputFail()
            return
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = view.layer.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
        
        self.captureSession.startRunning()
    }
    
    func deviceInputFail() {
        let alertController = UIAlertController(
            title: "Scanning not supported.",
            message: "Your device does not support scanning a code from an item.",
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        self.captureSession = nil
    }
}

protocol QRCodeScannerDelegate {
    func codeDidFind(_ code: String)
}

import SwiftUI
extension CameraViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController,
                                context: UIViewControllerRepresentableContext<CameraViewController>) {
        
    }
    
}
