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
    private let activityIndicator = UIActivityIndicatorView(style: .gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = self.view.center
        
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
            <> backgroundStyle(color: .mr_purple)
        
        self.copyButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_purple)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.invoiceLabel
            |> map { $0.isHidden = true }
        
        self.copyButton
            |> map { $0.isHidden = true }
    }
    
    func requestInvoice(invoiceRequest: InvoiceRequest) {
        activityIndicator.startAnimating()
        
        remoteNodeConnection.flatMap {
            Current.lightningAPIRPC = LightningApiRPC.init(configuration: $0)
            
            Current.lightningAPIRPC?.addInvoice(
                value: invoiceRequest.value,
                memo: invoiceRequest.memo) { [weak self] result in
                switch result {
                case let .success(invoice):
                    DispatchQueue.main.async {
                        self?.invoiceLabel
                            |> flatMap { $0.isHidden = false }
                        self?.copyButton
                            |> flatMap { $0.isHidden = false }
                        self?.invoiceLabel
                            |> flatMap { $0.text = invoice }
                        self?.amountTextField
                            |> flatMap { $0.text = "" }
                        self?.memoTextField
                            |> flatMap { $0.text = "" }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                        self?.activityIndicator.stopAnimating()
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                    }
                    
                    let alertController = UIAlertController(
                        title: DataError.fetchInfoFailure.localizedDescription,
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alertController, animated: true)
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
            let alertController = UIAlertController(
                title: DataError.invoiceInfoMissing.localizedDescription,
                message: "Missing Info",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
        
    }
    
    @IBAction func copyButtonPressed(_ sender: Any) {
        self.invoiceLabel.text.flatMap { print("Copied invoice: \($0)") }
        UIPasteboard.general.string = self.invoiceLabel.text.flatMap { $0 }
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
