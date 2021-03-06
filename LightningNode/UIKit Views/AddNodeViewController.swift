//
//  AddNodeViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

class AddNodeViewController: UIViewController {
    
    let titleLabel = UILabel()
    let lndConnectButton = UIButton()
    let titleLabelStatic = UILabel()
    let rootStackView = UIStackView()
    let certificateTextField = UITextField()
    let macaroonTextField = UITextField()
    let uriTextField = UITextField()
    let submitButton = UIButton()
    let textFieldStackView = UIStackView()
    
    private var addNodeViewModelCombine = AddNodeViewModelCombine()
    private var submitButtonSubscriber: AnyCancellable? // calls cancel on deinit
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadRNC),
            name: NSNotification.Name(rawValue: "loadRNC"),
            object: nil
        )
        
        switch loadFromKeychain() {
        case let .success(value):
            Current.remoteNodeConnectionFormatted = value
            //            let vc = TabBarViewController()
            let swiftUIView = TabUIView()
            let vc = UIHostingController(rootView: swiftUIView)
            self.navigationController?.pushViewController(vc, animated: true)
        case let .failure(error):
            print(error)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
        loadRNC()
        
        submitButtonSubscriber = addNodeViewModelCombine.readyToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \UIButton.isEnabled, on: submitButton)
        
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
            <> { $0.addTarget(self, action: #selector(self.cameraPressed), for: .touchUpInside) }
        
        self.titleLabelStatic
            |> { $0.numberOfLines = 0 }
            <> centerTextStyle
            <> subheadlineTextStyle
            <> { $0.text = "Or paste info manually below" }
            <> { $0.textColor = .secondaryLabel }
        
        self.certificateTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "Certificate (Example: MIIC5T...2qN146)"}
            <> { $0.delegate = self }
            <> { $0.addTarget(self, action: #selector(self.certificateDidChange), for: .allEvents) }
        
        self.macaroonTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "Macaroon (Example: AgECg...reaDXg==)"}
            <> { $0.delegate = self }
            <> { $0.addTarget(self, action: #selector(self.macaroonDidChange), for: .allEvents) }
        
        self.uriTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "URI (Example: 142.x.x.x:10009)"}
            <> { $0.delegate = self }
            <> { $0.addTarget(self, action: #selector(self.uriDidChange), for: .allEvents) }
        
        self.textFieldStackView
            |> verticalStackViewStyle
            <> { $0.addArrangedSubview(self.certificateTextField) }
            <> { $0.addArrangedSubview(self.macaroonTextField) }
            <> { $0.addArrangedSubview(self.uriTextField) }
        
        self.submitButton
            |> unfilledButtonStyle
            <> { $0.isEnabled = false }
            <> { $0.setTitle("...", for: .disabled) }
            <> { $0.setTitle("Add Node", for: .normal) }
            <> { $0.addTarget(self, action: #selector(self.submitPressed), for: .touchUpInside) }
        
        self.rootStackView
            |> verticalStackViewStyle
            <> { $0.addArrangedSubview(self.titleLabel) }
            <> { $0.addArrangedSubview(self.lndConnectButton) }
            <> { $0.addArrangedSubview(self.titleLabelStatic) }
            <> { $0.addArrangedSubview(self.textFieldStackView) }
            <> { $0.addArrangedSubview(self.submitButton) }
        
        self.view
            |> { $0.addSubview(self.rootStackView) }
            <> { $0.layoutMargins = .init(top: .mr_grid(6), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))}
        
        NSLayoutConstraint.activate(
            [
                self.rootStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
                self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
                self.lndConnectButton.heightAnchor.constraint(equalToConstant: 60.0),
                self.submitButton.heightAnchor.constraint(equalToConstant: 60.0),
            ]
        )
        
    }
}

extension AddNodeViewController {
    
    @objc func certificateDidChange(_ sender: UITextField) {
        addNodeViewModelCombine.certificateTextFieldInput = sender.text ?? ""
    }
    
    @objc func macaroonDidChange(_ sender: UITextField) {
        addNodeViewModelCombine.macaroonTextFieldInput = sender.text ?? ""
    }
    
    @objc func uriDidChange(_ sender: UITextField) {
        addNodeViewModelCombine.uriTextFieldInput = sender.text ?? ""
    }
    
    @objc func cameraPressed() {
        let vc = CameraViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    // This is my workaround for refreshing after modal dismissed
    // And enabling button
    @objc func loadRNC(){
        if let lndConnect = Current.remoteNodeConnection {
            self.certificateTextField.text = lndConnect.certificate
            self.macaroonTextField.text = lndConnect.macaroon
            self.uriTextField.text = lndConnect.uri
            self.certificateDidChange(self.certificateTextField)
            self.macaroonDidChange(self.macaroonTextField)
            self.uriDidChange(self.uriTextField)
        }
        
    }
    
    @objc func submitPressed() {
//        self.nvActivityIndicator?.startAnimating()
        
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
//                    self.nvActivityIndicator?.stopAnimating()
                    //                    let vc = TabBarViewController()
                    let swiftUIView = TabUIView()//SettingsViewController()
                    let vc = UIHostingController(rootView: swiftUIView)
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
//                    self.nvActivityIndicator?.stopAnimating()
                    let alertController = UIAlertController(
                        title: "Something went wrong Adding Node",
                        message: output.alertErrorMessage,
                        preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        } else {
//            self.nvActivityIndicator?.stopAnimating()
            let alertController = UIAlertController(
                title: "Something went wrong in adding node.",
                message: DataError.remoteNodeInfoMissing.localizedDescription,
                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
        
        
    }
}

import SwiftUI
struct AddNodeViewControllerRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return AddNodeViewController.init().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

struct AddNodeViewController_Preview: PreviewProvider {
    static var previews: some View {
        AddNodeViewControllerRepresentable()
    }
}
