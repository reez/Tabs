//
//  CameraViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/11/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import AVFoundation
import PanModal

class CameraViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.captureSession?.isRunning == false) {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.captureSession?.isRunning == true) {
            self.captureSession.stopRunning()
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let readableString = readableObject.stringValue else { return }
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
        
        dismiss(animated: true)
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

extension CameraViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(565)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
}
