//
//  AddNodeViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PanModal

class AddNodeViewController: UIViewController {
    
    private var nvActivityIndicator: NVActivityIndicatorView?
    let titleLabel = UILabel()
    let lndConnectButton = UIButton()
    let titleLabelStatic = UILabel()
    let rootStackView = UIStackView()
    let certificateTextField = UITextField()
    let macaroonTextField = UITextField()
    let uriTextField = UITextField()
    let submitButton = UIButton()
    let textFieldStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadRNC), name: NSNotification.Name(rawValue: "loadRNC"), object: nil)
        
        switch loadFromKeychain() {
        case let .success(value):
            Current.remoteNodeConnectionFormatted = value
            let vc = TabBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case let .failure(error):
            print(error)
        }
        
    }
    
    // RNC from camera to appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
        loadRNC()
    }
    
}

extension AddNodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitPressed()
        
        return true
    }
}

extension AddNodeViewController {
    func setupUI() {
        
        self.titleLabel
            |> title1BoldTextStyle
            <> { $0.text = "Add a Node" }
        
        self.lndConnectButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Scan lndconnect QRCode", for: .normal) }
        
        self.lndConnectButton.addTarget(
            self,
            action: #selector(cameraPressed),
            for: .touchUpInside
        )
        
        self.titleLabelStatic
            |> { $0.numberOfLines = 0 }
            <> centerTextStyle
            <> subheadlineTextStyle
            <> { $0.text = "Or paste info manually below" }
            <> { $0.textColor = .mr_gray }
        
        self.certificateTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "Certificate (Example: MIIC5T...2qN146)"}
            <> { $0.delegate = self }
        
        self.macaroonTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "Macaroon (Example: AgECg...reaDXg==)"}
            <> { $0.delegate = self }
        
        self.uriTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "URI (Example: 142.x.x.x:10009)"}
            <> { $0.delegate = self }
        
        self.textFieldStackView
            |> verticalStackViewStyle
            <> { $0.addArrangedSubview(self.certificateTextField) }
            <> { $0.addArrangedSubview(self.macaroonTextField) }
            <> { $0.addArrangedSubview(self.uriTextField) }
        
        self.submitButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Add Node", for: .normal) }
            <> { $0.addTarget(self, action: #selector(self.submitPressed), for: .touchUpInside) }
        
        self.rootStackView
            |> verticalStackViewStyle
            <> { $0.addArrangedSubview(self.titleLabel) }
            <> { $0.addArrangedSubview(self.lndConnectButton) }
            <> { $0.addArrangedSubview(self.titleLabelStatic) }
            <> { $0.addArrangedSubview(self.textFieldStackView) }
            <> { $0.addArrangedSubview(self.submitButton) }
        
        let nvActivityIndicatorFrame = CGRect(
            x: (UIScreen.main.bounds.size.width / 2 - 40),
            y: (UIScreen.main.bounds.size.height / 2 - 40),
            width: 80,
            height: 80
        )
        
        self.nvActivityIndicator = NVActivityIndicatorView(
            frame: nvActivityIndicatorFrame,
            type: NVActivityIndicatorType.ballClipRotate,
            color: UIColor.mr_black,
            padding: nil
        )
        
        self.view
            |> { $0.addSubview(self.nvActivityIndicator!) }
            <> { $0.addSubview(self.rootStackView) }
            <> { $0.layoutMargins = .init(top: .mr_grid(6), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))}
        
        NSLayoutConstraint.activate([
            self.rootStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.lndConnectButton.heightAnchor.constraint(equalToConstant: 40.0),
            self.submitButton.heightAnchor.constraint(equalToConstant: 40.0),
            ])
        
    }
}

extension AddNodeViewController {
    
    @objc func cameraPressed() {
        let vc = CameraViewController()
        presentPanModal(vc)
    }
    
    // This is my workaround for refreshing after modal dismissed
    @objc func loadRNC(){
        if let lndConnect = Current.remoteNodeConnection {
            self.certificateTextField.text = lndConnect.certificate
            self.macaroonTextField.text = lndConnect.macaroon
            self.uriTextField.text = lndConnect.uri
        }
    }
    
    @objc func submitPressed() {
        self.nvActivityIndicator?.startAnimating()
        
        if let certificate = self.certificateTextField.text,
            let macaroon = self.macaroonTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let uri = self.uriTextField.text?.trimmingCharacters(in: .whitespaces),
            !certificate.isEmpty,
            !macaroon.isEmpty,
            !uri.isEmpty {
            
            let input = AddNodeViewModelInputs(
                certificateTextFieldInput: certificate,
                macaroonTextFieldInput: macaroon,
                uriTextFieldInput: uri
            )
            
            addNodeViewModel(input: input) { (output) in
                if !output.alertNeeded {
                    self.nvActivityIndicator?.stopAnimating()
                    let vc = TabBarViewController()
                    self.present(vc, animated: true, completion: nil)
                } else {
                    self.nvActivityIndicator?.stopAnimating()
                    let alertController = UIAlertController(
                        title: "Something went wrong Adding Node",
                        message: output.alertErrorMessage,
                        preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        } else {
            self.nvActivityIndicator?.stopAnimating()
            let alertController = UIAlertController(
                title: "Something went wrong in adding node.",
                message: DataError.remoteNodeInfoMissing.localizedDescription,
                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
}
