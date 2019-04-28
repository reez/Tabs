//
//  AddNodeViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AddNodeViewController: UIViewController {
    
    private var nvActivityIndicator: NVActivityIndicatorView?
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
        
        print(Current.remoteNodeConnection)
        
        if let lndConnect = Current.remoteNodeConnection {
            self.certificateTextField.text = lndConnect.certificate
            self.macaroonTextField.text = lndConnect.macaroon
            self.uriTextField.text = lndConnect.uri
            
        } else {
            print("what happened")
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
        
        let nvActivityIndicatorframe = CGRect(
            x: (UIScreen.main.bounds.size.width / 2 - 40),
            y: (UIScreen.main.bounds.size.height / 2 - 40),
            width: 80,
            height: 80
        )
        self.nvActivityIndicator = NVActivityIndicatorView(
            frame: nvActivityIndicatorframe,
            type: NVActivityIndicatorType.ballClipRotate,
            color: UIColor.mr_black,
            padding: nil
        )
        self.view.addSubview(self.nvActivityIndicator!)
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
        
        self.certificateLabel
            |> baseLabelStyleSmallCaption
        
        self.certificateTextField
            |> baseTextFieldStyleBoldBody
        
        self.macaroonLabel
            |> baseLabelStyleSmallCaption
        
        self.macaroonTextField
            |> baseTextFieldStyleBoldBody
        
        self.uriLabel
            |> baseLabelStyleSmallCaption
        
        self.uriTextField
            |> baseTextFieldStyleBoldBody
        
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
                    let bundle = Bundle(for: TabBarViewController.self)
                    let nodeIdentifier = Reusing<TabBarViewController>().identifier()
                    let storyboard = UIStoryboard(name: nodeIdentifier, bundle: bundle)
                    let vc = storyboard.instantiateViewController(withIdentifier: nodeIdentifier) as! TabBarViewController
                    self.navigationController?.pushViewController(vc, animated: true)
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
