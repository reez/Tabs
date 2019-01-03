//
//  AddInvoiceViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class AddInvoiceViewController: UIViewController {
    var remoteNodeConnection: RemoteNodeConnection?
    
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var memoTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var invoiceLabel: UILabel!
    @IBOutlet var copyButton: UIButton!
    @IBOutlet var zapButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        memoTextField.delegate = self
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
        
        self.amountLabel
            |> baseLabelStyleSmall
        
        self.amountTextField
            |> baseTextFieldStyleBold
        
        self.memoLabel
            |> baseLabelStyleSmall
        
        self.memoTextField
            |> baseTextFieldStyleBold
        
        self.invoiceLabel
            |> baseLabelStyleSmall
        
        self.submitButton
            |> filledButtonStyle
            <> backgroundStyle(color: .purple)
        
        self.copyButton
            |> filledButtonStyle
            <> backgroundStyle(color: .purple)
        
        self.zapButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_gold)
            <> { $0.setTitle("Open in Zap", for: .normal)}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.invoiceLabel
            |> map { $0.isHidden = true }
        
        self.copyButton
            |> map { $0.isHidden = true }
        
        self.zapButton
            |> map { $0.isHidden = true }
    }
    
    func requestInvoice(invoiceRequest: InvoiceRequest) {
        activityIndicator.startAnimating()
        
        remoteNodeConnection.flatMap {
            Current.lightningAPIRPC = LightningApiRPC.init(configuration: $0)
            
            Current.lightningAPIRPC?.addInvoice(
                value: invoiceRequest.value,
                memo: invoiceRequest.memo) { [weak self] result in
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case let .success(invoice):
                    DispatchQueue.main.async {
                        self?.invoiceLabel
                            |> flatMap { $0.isHidden = false }
                        self?.copyButton
                            |> flatMap { $0.isHidden = false }
                        self?.zapButton
                            |> flatMap { $0.isHidden = false }
                        self?.invoiceLabel
                            |> flatMap { $0.text = invoice }
                        self?.amountTextField
                            |> flatMap { $0.text = "" }
                        self?.memoTextField
                            |> flatMap { $0.text = "" }
                    }
                case let .failure(error):
                    self?.activityIndicator.stopAnimating()
                    let alert = UIAlertController(
                        title: DataError.fetchInfoFailure.localizedDescription,
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    self?.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    @IBAction func goBackPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if let memo = self.memoTextField.text,
            let amount = self.amountTextField.text,
            let value = Int(amount) {
            let request = InvoiceRequest(memo: memo, value: value)
            requestInvoice(invoiceRequest: request)
        } else {
            let alert = UIAlertController(
                title: DataError.invoiceInfoMissing.localizedDescription,
                message: "Missing Info",
                preferredStyle: .alert
            )
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func copyButtonPressed(_ sender: Any) {
        self.invoiceLabel.text.flatMap { print("Copied invoice: \($0)") }
        UIPasteboard.general.string = self.invoiceLabel.text.flatMap { $0 }
    }
    
    @IBAction func zapButtonPressed(_ sender: Any) {
        print("Open in Zap...")

        self.invoiceLabel.text.flatMap {
            guard let url = URL(string: "lightning:\($0)") else { return }
            UIApplication.shared.open(
                url,
                options: [:],
                completionHandler: { print("Open Success?: \($0)") }
            )
        }
    
    }
    
}

extension AddInvoiceViewController:  UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountTextField.resignFirstResponder()
        memoTextField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
