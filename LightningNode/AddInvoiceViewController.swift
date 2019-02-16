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
        setupUI()
    }
    
    @IBAction func goBackPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        self.activityIndicator.startAnimating()
        
        if let memo = self.memoTextField.text,
            let amount = self.amountTextField.text,
            !amount.isEmpty,
            !memo.isEmpty {
            
            let input = AddInvoiceViewModelInput(
                amountTextFieldInput: amount,
                memoTextFieldInput: memo
            )
            addInvoiceViewModel(input: input) { (output) in
                if !output.alertNeeded {
                    self.activityIndicator.stopAnimating()
                    self.invoiceLabel.isHidden = output.invoiceLabelHidden
                    self.copyButton.isHidden = output.copyButtonHidden
                    self.invoiceLabel.text = output.invoiceLabel
                    self.amountTextField.text = output.amountTextFieldOutput
                    self.memoTextField.text = output.memoTextFieldOutput
                } else {
                    self.activityIndicator.stopAnimating()
                    let alertController = UIAlertController(
                        title: DataError.fetchInfoFailure.localizedDescription,
                        message: output.alertErrorMessage,
                        preferredStyle: .alert
                    )
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
            }
            
        } else {
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(
                title: DataError.invoiceInfoMissing.localizedDescription,
                message: "Missing Invoice Info",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
        
    }
    
    @IBAction func copyButtonPressed(_ sender: Any) {
        UIPasteboard.general.string = self.invoiceLabel.text.flatMap { $0 }
    }
    
}

extension AddInvoiceViewController:  UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.amountTextField.resignFirstResponder()
        self.memoTextField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AddInvoiceViewController {
    
    func addInvoiceViewModel(
        input: AddInvoiceViewModelInput,
        output: @escaping (AddInvoiceViewModelOutput) -> Void
        )
    {
        var viewModelOutput = AddInvoiceViewModelOutput(
            alertErrorMessage: "",
            alertNeeded: false,
            amountTextFieldOutput: "",
            copyButtonHidden: true,
            invoiceLabel: "",
            invoiceLabelHidden: true,
            memoTextFieldOutput: ""
        )
        
        if let value = Int(input.amountTextFieldInput) {
            let request = InvoiceRequest(memo: input.memoTextFieldInput, value: value)
            remoteNodeConnection.flatMap {
                Current.lightningAPIRPC = LightningApiRPC.init(configuration: $0)
                Current.lightningAPIRPC?.addInvoice(value: request.value, memo: request.memo) { result in
                    switch result {
                    case let .success(invoice):
                        viewModelOutput.invoiceLabelHidden = false
                        viewModelOutput.copyButtonHidden = false
                        viewModelOutput.invoiceLabel = invoice
                        viewModelOutput.amountTextFieldOutput = ""
                        viewModelOutput.memoTextFieldOutput = ""
                        output(viewModelOutput)
                    case let .failure(errorMessage):
                        viewModelOutput.alertNeeded = true
                        viewModelOutput.alertErrorMessage = errorMessage.localizedDescription
                        output(viewModelOutput)
                    }
                }
            }
        } else {
            viewModelOutput.alertNeeded = true
            viewModelOutput.alertErrorMessage = "Value for Invoice must be a number"
            output(viewModelOutput)
        }
        
    }
    
}

extension AddInvoiceViewController {
    func setupUI() {
        self.amountTextField.delegate = self
        self.memoTextField.delegate = self
        self.view.addSubview(activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = self.view.center
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
        
        self.amountLabel
            |> baseLabelStyleSmallCaption
        
        self.amountTextField
            |> baseTextFieldStyleBold
        
        self.memoLabel
            |> baseLabelStyleSmallCaption
        
        self.memoTextField
            |> baseTextFieldStyleBold
        
        self.invoiceLabel
            |> baseLabelStyleSmallCaption
        
        self.submitButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_gold)
        
        self.copyButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_gold)
        
        self.invoiceLabel
            |> map { $0.isHidden = true }
        self.copyButton
            |> map { $0.isHidden = true }
    }
}
