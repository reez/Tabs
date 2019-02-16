//
//  AddNodeViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class AddNodeViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var certificateStackView: UIStackView!
    @IBOutlet var macaroonStackView: UIStackView!
    @IBOutlet var uriStackView: UIStackView!
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var certificateLabel: UILabel!
    @IBOutlet var certificateTextField: UITextField!
    @IBOutlet var macaroonLabel: UILabel!
    @IBOutlet var macaroonTextField: UITextField!
    @IBOutlet var uriLabel: UILabel!
    @IBOutlet var uriTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var lndConnectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let lndConnect = Current.remoteNodeConnection {
            self.certificateTextField.text = lndConnect.certificate
            self.macaroonTextField.text = lndConnect.macaroon
            self.uriTextField.text = lndConnect.uri
        }
        
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        submitPressed()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let bundle = Bundle(for: CameraViewController.self)
        let cameraIdentifier = Reusing<CameraViewController>().identifier()
        let storyboard = UIStoryboard(name: cameraIdentifier, bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: cameraIdentifier) as! CameraViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.macaroonTextField.delegate = self
        self.certificateTextField.delegate = self
        self.uriTextField.delegate = self
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
        
        self.certificateLabel
            |> baseLabelStyleSmallCaption
        
        self.certificateTextField
            |> baseTextFieldStyleBold
        
        self.macaroonLabel
            |> baseLabelStyleSmallCaption
        
        self.macaroonTextField
            |> baseTextFieldStyleBold
        
        self.uriLabel
            |> baseLabelStyleSmallCaption
        
        self.uriTextField
            |> baseTextFieldStyleBold
        
        self.lndConnectButton
            |> filledButtonStyle
            <> backgroundStyle(color: .white)
            <> { $0.setTitleColor(.mr_gold, for: .normal) }
        
        self.submitButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_black)
    }
}

extension AddNodeViewController {
    func submitPressed() {
        self.activityIndicator.startAnimating()
        
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
                    self.activityIndicator.stopAnimating()
                    let bundle = Bundle(for: NodeCollectionViewController.self)
                    let nodeIdentifier = Reusing<NodeCollectionViewController>().identifier()
                    let storyboard = UIStoryboard(name: nodeIdentifier, bundle: bundle)
                    let vc = storyboard.instantiateViewController(withIdentifier: nodeIdentifier) as! NodeCollectionViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.activityIndicator.stopAnimating()
                    let alertController = UIAlertController(
                        title: "Something went wrong Adding Node",
                        message: output.alertErrorMessage,
                        preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        } else {
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(
                title: "Something went wrong in adding node.",
                message: DataError.remoteNodeInfoMissing.localizedDescription,
                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
}
