//
//  CameraViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/11/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import AVFoundation

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
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let readableString = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            let url = URL(string: readableString)
            let queryParameters = url!.queryParameters
            let certificate = queryParameters!["cert"]?.base64UrlToBase64()
            let macaroonString = queryParameters?["macaroon"]?.base64UrlToBase64()
            let nodeHostString = url?.host
            let port = url?.port
            let nodeString = "\(nodeHostString!):\(port!)"
            let rnc = RemoteNodeConnection.init(uri: nodeString, certificate: certificate!, macaroon: macaroonString!)
            let bundle = Bundle(for: AddNodeViewController.self)
            let addNodeIdentifier = Reusing<AddNodeViewController>().identifier()
            let storyboard = UIStoryboard(name: addNodeIdentifier, bundle: bundle)
            let vc = storyboard.instantiateViewController(withIdentifier: addNodeIdentifier) as! AddNodeViewController
            vc.remoteNodeConnection = rnc
            self.navigationController?.pushViewController(vc, animated: true)
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
        
        let button = UIButton(frame: CGRect(x: 10, y: 60, width: 40, height: 40))
        button.backgroundColor = .clear
        button.setTitle("<", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
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
