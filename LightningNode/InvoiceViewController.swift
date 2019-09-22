//
//  InvoiceViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/30/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
//import PanModal
import NVActivityIndicatorView
import Loaf

class InvoiceViewController: UIViewController {
    
    private var nvActivityIndicator: NVActivityIndicatorView?
    private let rootStackView = UIStackView()
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    private let amountTextField = UITextField()
    private let memoLabel = UILabel()
    private let memoTextField = UITextField()
    private let submitButton = UIButton()
    private let invoiceLabel = UILabel()
    private let copyButton = UIButton()
    private let textStackView = UIStackView()
    private let responseStackView = UIStackView()
    private let amountStackView = UIStackView()
    private let memoStackView = UIStackView()
    private let titleStackView = UIStackView()
    private let amountTextStackView = UIStackView()
    private let memoTextStackView = UIStackView()
    private let amountImageView = UIImageView(image: UIImage(named: "lightning"))
    private let memoImageView = UIImageView(image: UIImage(named: "message"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.copyButton.addTarget(
            self,
            action: #selector(copyButtonPressed),
            for: .touchUpInside
        )
        
        self.submitButton.addTarget(
            self,
            action: #selector(submitButtonPressed),
            for: .touchUpInside
        )
        
    }
    
}

extension InvoiceViewController {
    @objc func submitButtonPressed(_ sender: UIButton) {
        UIButton.animate(
            withDuration: 0.0,
            animations: { sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.975) }
        ) { _ in
            UIButton.animate(
                withDuration: 0.1,
                animations: { sender.transform = CGAffineTransform.identity }
            )
        }
        
        self.view.endEditing(true)
        self.nvActivityIndicator?.startAnimating()
        
        if let memo = self.memoTextField.text,
            let amount = self.amountTextField.text,
            !amount.isEmpty,
            !memo.isEmpty {
            
            let input = AddInvoiceViewModelInput(
                amountTextFieldInput: amount,
                memoTextFieldInput: memo,
                submitButtonPressed: ()
            )
            addInvoiceViewModel(input: input) { (output) in
                if !output.alertNeeded {
                    self.nvActivityIndicator?.stopAnimating()
                    self.invoiceLabel.isHidden = output.invoiceLabelHidden
                    self.copyButton.isHidden = output.copyButtonHidden
                    self.invoiceLabel.text = output.invoiceLabel
                    self.amountTextField.text = output.amountTextFieldOutput
                    self.memoTextField.text = output.memoTextFieldOutput
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    
                } else {
                    self.nvActivityIndicator?.stopAnimating()
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
            self.nvActivityIndicator?.stopAnimating()
            let alertController = UIAlertController(
                title: DataError.invoiceInfoMissing.localizedDescription,
                message: "Missing Invoice Info",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
        
    }
}


extension InvoiceViewController {
    func setupUI() {
        
        self.amountTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "Value"}
            <> { $0.keyboardType = UIKeyboardType.numbersAndPunctuation }
            <> { $0.delegate = self }
        
        self.memoTextField
            |> baseTextFieldStyle
            <> { $0.placeholder = "Memo"}
            <> { $0.delegate = self }
        
        self.titleLabel
            |> title1BoldTextStyle
            <> { $0.text = "Add an Invoice" }
        
        self.amountLabel
            |> smallCapsTextStyle
            <> { $0.text = "Amount" }
        
        self.amountTextField
            |> bodyBoldTextFieldStyle
        
        self.memoLabel
            |> smallCapsTextStyle
            <> { $0.text = "Memo" }
        
        self.memoTextField
            |> bodyBoldTextFieldStyle
        
        self.invoiceLabel
            |> smallCapsTextStyle
            <> { $0.text = "Invoice" }
            <> { $0.numberOfLines = 0 }
        
        self.submitButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Add Invoice", for: .normal) }
        
        self.copyButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Copy Invoice", for: .normal) }
        
        self.invoiceLabel
            |> map { $0.isHidden = true }
        
        self.copyButton
            |> map { $0.isHidden = true }
        
        self.amountTextStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(1) }
            <> { $0.axis = .horizontal }
        
        self.memoTextStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(1) }
            <> { $0.axis = .horizontal }
        
        self.amountStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(3) }
            <> { $0.axis = .vertical }
        
        self.memoStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(3) }
            <> { $0.axis = .vertical }
        
        self.responseStackView
            |> rootStackViewStyle
            <> { $0.axis = .vertical }
        
        self.textStackView
            |> rootStackViewStyle
            <> { $0.axis = .vertical }
        
        self.rootStackView
            |> rootStackViewStyle
            <> { $0.axis = .vertical }
            <> topLayoutMarginsStyle
        
        self.amountStackView
            |> { $0.addArrangedSubview(self.amountTextField) }
        
        self.memoStackView
            |> { $0.addArrangedSubview(self.memoTextField) }
        
        self.textStackView
            |> { $0.addArrangedSubview(self.memoStackView) }
            <> { $0.addArrangedSubview(self.amountStackView) }
            <> { $0.addArrangedSubview(self.submitButton) }
        
        self.responseStackView
            |> { $0.addArrangedSubview(self.invoiceLabel) }
            <> { $0.addArrangedSubview(self.copyButton) }
        
        self.rootStackView
            |> { $0.addArrangedSubview(self.textStackView) }
            <> { $0.addArrangedSubview(self.responseStackView) }
        
        let nvActivityIndicatorFrame = CGRect(
            x: (UIScreen.main.bounds.size.width / 2 - 40),
            y: (UIScreen.main.bounds.size.height / 2 - 40),
            width: 80,
            height: 80
        )
        
        self.nvActivityIndicator = NVActivityIndicatorView(
            frame: nvActivityIndicatorFrame,
            type: NVActivityIndicatorType.ballClipRotate,
            color: .systemGray6, //UIColor.mr_black,
            padding: nil
        )
        
        self.view
            |> { $0.addSubview(self.nvActivityIndicator!) }
            <> { $0.addSubview(self.rootStackView) }
            <> { $0.backgroundColor = .systemBackground }
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.memoTextField.heightAnchor.constraint(equalToConstant: 40.0),
            self.amountTextField.heightAnchor.constraint(equalToConstant: 40.0),
            self.memoImageView.heightAnchor.constraint(equalToConstant: 16.0),
            self.memoImageView.widthAnchor.constraint(equalToConstant: 16.0),
            self.amountImageView.heightAnchor.constraint(equalToConstant: 16.0),
            self.amountImageView.widthAnchor.constraint(equalToConstant: 16.0),
            ])
        
    }
}

extension InvoiceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.amountTextField.resignFirstResponder()
        self.memoTextField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension InvoiceViewController {
    @objc func copyButtonPressed(_ sender: UIButton) {
        Loaf("Copied Invoice", state: .success, sender: self).show()
        UIPasteboard.general.string = self.invoiceLabel.text.flatMap { $0 }
    }
}

//extension InvoiceViewController: PanModalPresentable {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//    
//    var panScrollable: UIScrollView? {
//        return nil
//    }
//    
//    var longFormHeight: PanModalHeight {
//        return .contentHeight(525)
//    }
//    
//    var anchorModalToLongForm: Bool {
//        return false
//    }
//}
