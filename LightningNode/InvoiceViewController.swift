//
//  InvoiceViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/30/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import PanModal
import NVActivityIndicatorView

class InvoiceViewController: UIViewController {
    
    //    private let activityIndicator: NVActivityIndicatorView?
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
//        setupUInvoice()
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
        //self.nvActivityIndicator?.startAnimating()
        
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        //self.nvActivityIndicator?.stopAnimating()
                    }
                    self.invoiceLabel.isHidden = output.invoiceLabelHidden
                    self.copyButton.isHidden = output.copyButtonHidden
                    self.invoiceLabel.text = output.invoiceLabel
                    self.amountTextField.text = output.amountTextFieldOutput
                    self.memoTextField.text = output.memoTextFieldOutput
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    
                } else {
                    //self.nvActivityIndicator?.stopAnimating()
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
            //self.nvActivityIndicator?.stopAnimating()
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
        
//        self.amountTextField.delegate = self
//        self.memoTextField.delegate = self
        
        let textFieldStyle: (UITextField) -> Void = {
            $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
            $0.borderStyle = .roundedRect
        }
        
        self.amountTextField
            |> textFieldStyle
            <> { $0.placeholder = "Value"}
            <> { $0.keyboardType = UIKeyboardType.numbersAndPunctuation }
            <> { $0.delegate = self }

        self.memoTextField
            |> textFieldStyle
            <> { $0.placeholder = "Memo"}
            <> { $0.delegate = self }

//        self.amountTextField.placeholder = "Value"
//        self.amountTextField.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        self.amountTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
//        self.amountTextField.borderStyle = .roundedRect

//        self.memoTextField.placeholder = "Memo"
//        self.memoTextField.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        self.memoTextField.borderStyle = .roundedRect
        
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
            <> { $0.text = "Add an Invoice" }
        
        self.amountLabel
            |> baseLabelStyleSmallCaption
            <> { $0.text = "Amount" }

        self.amountTextField
            |> baseTextFieldStyleBoldBody
        
        self.memoLabel
            |> baseLabelStyleSmallCaption
            <> { $0.text = "Memo" }

        self.memoTextField
            |> baseTextFieldStyleBoldBody
        
        self.invoiceLabel
            |> baseLabelStyleSmallCaption
            <> { $0.text = "Invoice" }

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

//        self.titleLabel.text = "Add an Invoice"
//        self.amountLabel.text = "Amount"
//        self.memoLabel.text = "Memo"
//        self.invoiceLabel.text = "Invoice"
//        self.submitButton.setTitle("Add Invoice", for: .normal)
//        self.copyButton.setTitle("Copy Invoice", for: .normal)
        self.invoiceLabel.numberOfLines = 0
        
        
        func autolayoutStyle(_ view: UIView) -> Void {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let baseLayoutMargins: (UIView) -> Void = {
            $0.layoutMargins = UIEdgeInsets(top: .mr_grid(12), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
        }
        
        let rootStackViewStyle: (UIStackView) -> Void =
            autolayoutStyle
                <> {
//                    $0.axis = .vertical
                    $0.isLayoutMarginsRelativeArrangement = true
                    //$0.layoutMargins = UIEdgeInsets(top: .mr_grid(12), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
                    $0.spacing = .mr_grid(6)
        }
        
        self.amountTextStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(1) }
            <> { $0.axis = .horizontal }
//            <> baseLayoutMargins
        
//        self.amountTextStackView.spacing = .mr_grid(1)
//        self.amountTextStackView.isLayoutMarginsRelativeArrangement = true
//        self.amountTextStackView.translatesAutoresizingMaskIntoConstraints = false
//        self.amountTextStackView.axis = .horizontal
        
        self.memoTextStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(1) }
            <> { $0.axis = .horizontal }
        
//        self.memoTextStackView.spacing = .mr_grid(1)
//        self.memoTextStackView.isLayoutMarginsRelativeArrangement = true
//        self.memoTextStackView.translatesAutoresizingMaskIntoConstraints = false
//        self.memoTextStackView.axis = .horizontal
        
        self.amountStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(3) }
            <> { $0.axis = .vertical }
        
//        self.amountStackView.spacing = .mr_grid(3)
//        self.amountStackView.axis = .vertical
//        self.amountStackView.isLayoutMarginsRelativeArrangement = true
//        self.amountStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.memoStackView
            |> rootStackViewStyle
            <> { $0.spacing = .mr_grid(3) }
            <> { $0.axis = .vertical }
        
//        self.memoStackView.spacing = .mr_grid(3)
//        self.memoStackView.axis = .vertical
//        self.memoStackView.isLayoutMarginsRelativeArrangement = true
//        self.memoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.responseStackView
            |> rootStackViewStyle
            <> { $0.axis = .vertical }
        
//        self.responseStackView.spacing = .mr_grid(6)
//        self.responseStackView.axis = .vertical
//        self.responseStackView.isLayoutMarginsRelativeArrangement = true
//        self.responseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textStackView
            |> rootStackViewStyle
            <> { $0.axis = .vertical }
        
        self.textStackView.spacing = .mr_grid(6)
        self.textStackView.axis = .vertical
        self.textStackView.isLayoutMarginsRelativeArrangement = true
        self.textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.rootStackView
            |> rootStackViewStyle
            <> { $0.axis = .vertical }
            <> baseLayoutMargins

//        self.rootStackView.layoutMargins.top = .mr_grid(12)
//        self.rootStackView.layoutMargins.left = .mr_grid(6)
//        self.rootStackView.layoutMargins.bottom = .mr_grid(6)
//        self.rootStackView.layoutMargins.right = .mr_grid(6)
        
//        self.rootStackView.spacing = .mr_grid(6)
//        self.rootStackView.axis = .vertical
//        self.rootStackView.isLayoutMarginsRelativeArrangement = true
//        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
//        self.amountStackView.addArrangedSubview(amountTextField)
//        self.memoStackView.addArrangedSubview(memoTextField)
//        self.textStackView.addArrangedSubview(memoStackView)
//        self.textStackView.addArrangedSubview(amountStackView)
//        self.textStackView.addArrangedSubview(submitButton)
//        self.rootStackView.addArrangedSubview(textStackView)
        
//        self.responseStackView.addArrangedSubview(invoiceLabel)
//        self.responseStackView.addArrangedSubview(copyButton)
//        self.rootStackView.addArrangedSubview(responseStackView)
        
//        self.view.addSubview(rootStackView)
//        self.view.backgroundColor = .white
//
        self.view
            |> { $0.addSubview(self.rootStackView) }
            <> { $0.backgroundColor = .white }

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

extension InvoiceViewController  {
    func setupUInvoice() {
//        self.amountTextField.delegate = self
//        self.memoTextField.delegate = self
        
        //        let nvActivityIndicatorframe = CGRect(
        //            x: (UIScreen.main.bounds.size.width / 2 - 40),
        //            y: (UIScreen.main.bounds.size.height / 2 - 40),
        //            width: 80,
        //            height: 80
        //        )
        //        self.nvActivityIndicator = NVActivityIndicatorView(
        //            frame: nvActivityIndicatorframe,
        //            type: NVActivityIndicatorType.ballClipRotate,
        //            color: UIColor.mr_black,
        //            padding: nil
        //        )
        //        self.view.addSubview(self.nvActivityIndicator!)
        
//        self.titleLabel
//            |> baseLabelStyleBoldTitle
//
//        self.amountLabel
//            |> baseLabelStyleSmallCaption
//
//        self.amountTextField
//            |> baseTextFieldStyleBoldBody
//
//        self.memoLabel
//            |> baseLabelStyleSmallCaption
//
//        self.memoTextField
//            |> baseTextFieldStyleBoldBody
//
//        self.invoiceLabel
//            |> baseLabelStyleSmallCaption
//
//        self.submitButton
//            |> unfilledButtonStyle
//
//        self.copyButton
//            |> unfilledButtonStyle
//
//        self.invoiceLabel
//            |> map { $0.isHidden = true }
//
//        self.copyButton
//            |> map { $0.isHidden = true }
    }
}


extension InvoiceViewController {
    @objc func copyButtonPressed(_ sender: UIButton) {
        UIButton.animate(
            withDuration: 0.0,
            animations: { sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.975) }
        ) { _ in
            UIButton.animate(
                withDuration: 0.1,
                animations: { sender.transform = CGAffineTransform.identity }
            )
        }
        
        UIPasteboard.general.string = self.invoiceLabel.text.flatMap { $0 }
    }
}

extension InvoiceViewController: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(525)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}
