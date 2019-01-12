//
//  CameraViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/11/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import AVFoundation

public class CameraViewController: UIViewController {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput // (device: captureDevice) other has this
        
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
        
        let button = UIButton(frame: CGRect(x: 10, y: 60, width: 40, height: 40))
        button.backgroundColor = .clear
        button.setTitle("<", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.captureSession?.isRunning == false) {
            self.captureSession.startRunning()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.captureSession?.isRunning == true) {
            self.captureSession.stopRunning()
        }
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
    

    func captured(qr: String) {
        
        let url = URL(string: qr)
        let queryParameters = url!.queryParameters
        
        let certificate = queryParameters!["cert"]?.base64UrlToBase64()
        
        let macaroonString = queryParameters?["macaroon"]?.base64UrlToBase64()
        
        let nodeHostString = url?.host
        let port = url?.port
        let nodeString = "\(nodeHostString!):\(port!)"
        
        let rnc = RemoteNodeConnection.init(uri: nodeString, certificate: certificate!, macaroon: macaroonString!)
        
        let bundle = Bundle(for: AddNodeViewController.self)
        let storyboard = UIStoryboard(name: "AddNodeViewController", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNodeViewController") as! AddNodeViewController
        vc.remoteNodeConnection = rnc
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func buttonAction(sender: UIButton!) {
        _ = navigationController?.popViewController(animated: true)
    }
    

}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let readableString = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            captured(qr: readableString)
        }
        
        dismiss(animated: true)
    }
    
}
