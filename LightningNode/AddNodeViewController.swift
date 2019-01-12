//
//  AddNodeViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class AddNodeViewController: UIViewController {
    
    private var remoteNodeConnection: RemoteNodeConnection?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        macaroonTextField.delegate = self
        certificateTextField.delegate = self
        uriTextField.delegate = self
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
        
        self.certificateLabel
            |> baseLabelStyleSmall
        
        self.certificateTextField
            |> baseTextFieldStyleBold

        self.macaroonLabel
            |> baseLabelStyleSmall
        
        self.macaroonTextField
            |> baseTextFieldStyleBold

        self.uriLabel
            |> baseLabelStyleSmall
        
        self.uriTextField
            |> baseTextFieldStyleBold
        
        self.submitButton
            |> filledButtonStyle
            <> backgroundStyle(color: .black)

        // This is just to make sure I don't have anything in keychain and its deleted if user pressed delete button
        print("Load from keychain: \(loadFromKeychain())")
    }
    
    private func submitPressed() {
        activityIndicator.startAnimating()
        
        if let certificate =
            certificateTextField.text,
            let macaroon =
            macaroonTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let uri =
            uriTextField.text?.trimmingCharacters(in: .whitespaces) {
            
            
            let cert = Pem(key: certificate).string
            let formattedMacaroon = macaroon.replacingOccurrences(of: " ", with: "")
            guard let data = Data(base64Encoded: formattedMacaroon) else { return print("mac error") } // This needs to not just silently return
            let mac = data.hexDescription
            
            let rnc = RemoteNodeConnection(
                uri: uri,
                certificate: cert,
                macaroon: mac
            )
            
            remoteNodeConnection = rnc
            
            guard let remoteNodeConnection = remoteNodeConnection else { return }
            let resultSavedPost = Current.keychain.save(remoteNodeConnection)

            switch resultSavedPost {
            case .success(_):
                self.activityIndicator.stopAnimating()
                let bundle = Bundle(for: NodeCollectionViewController.self)
                let storyboard = UIStoryboard(name: "NodeCollectionViewController", bundle: bundle)
                let vc = storyboard.instantiateViewController(withIdentifier: "NodeCollectionViewController") as! NodeCollectionViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case let .failure(error):
                self.activityIndicator.stopAnimating()
                let alert = UIAlertController(
                    title: "Something went wrong adding node",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                self.present(alert, animated: true, completion: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Something went wrong in adding node",
                    message: DataError.remoteNodeInfoMissing.localizedDescription,
                    preferredStyle: .alert
                )
                self.present(alert, animated: true, completion: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        submitPressed()
    }

}

extension AddNodeViewController:  UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitPressed()
        return true
    }
}
