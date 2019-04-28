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
        setupUInvoice()
        setupView()
        self.view.backgroundColor = .white
        
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
    func setupView() {
        
        self.amountTextStackView.spacing = .mr_grid(1)
        self.amountTextStackView.isLayoutMarginsRelativeArrangement = true
        self.amountTextStackView.translatesAutoresizingMaskIntoConstraints = false
        self.amountTextStackView.axis = .horizontal
        
        self.memoTextStackView.spacing = .mr_grid(1)
        self.memoTextStackView.isLayoutMarginsRelativeArrangement = true
        self.memoTextStackView.translatesAutoresizingMaskIntoConstraints = false
        self.memoTextStackView.axis = .horizontal
        
        self.amountStackView.spacing = .mr_grid(3)
        self.amountStackView.axis = .vertical
        self.amountStackView.isLayoutMarginsRelativeArrangement = true
        self.amountStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.memoStackView.spacing = .mr_grid(3)
        self.memoStackView.axis = .vertical
        self.memoStackView.isLayoutMarginsRelativeArrangement = true
        self.memoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.responseStackView.spacing = .mr_grid(6)
        self.responseStackView.axis = .vertical
        self.responseStackView.isLayoutMarginsRelativeArrangement = true
        self.responseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textStackView.spacing = .mr_grid(6)
        self.textStackView.axis = .vertical
        self.textStackView.isLayoutMarginsRelativeArrangement = true
        self.textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.rootStackView.layoutMargins.top = .mr_grid(12)
        self.rootStackView.layoutMargins.left = .mr_grid(6)
        self.rootStackView.layoutMargins.bottom = .mr_grid(6)
        self.rootStackView.layoutMargins.right = .mr_grid(6)
        
        self.rootStackView.spacing = .mr_grid(12)
        self.rootStackView.axis = .vertical
        self.rootStackView.isLayoutMarginsRelativeArrangement = true
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.textAlignment = .center
        self.titleStackView.addArrangedSubview(titleLabel)
        self.rootStackView.addArrangedSubview(titleStackView)
        
        self.amountTextStackView.addArrangedSubview(amountImageView)
        self.amountTextStackView.addArrangedSubview(amountLabel)
        self.memoTextStackView.addArrangedSubview(memoImageView)
        self.memoTextStackView.addArrangedSubview(memoLabel)
        
        self.amountStackView.addArrangedSubview(amountTextStackView)
        self.amountStackView.addArrangedSubview(amountTextField)
        self.memoStackView.addArrangedSubview(memoTextStackView)
        self.memoStackView.addArrangedSubview(memoTextField)
        self.textStackView.addArrangedSubview(memoStackView)
        self.textStackView.addArrangedSubview(amountStackView)
        self.textStackView.addArrangedSubview(submitButton)
        self.rootStackView.addArrangedSubview(textStackView)
        
        self.responseStackView.addArrangedSubview(invoiceLabel)
        self.responseStackView.addArrangedSubview(copyButton)
        self.rootStackView.addArrangedSubview(responseStackView)
        
        self.view.addSubview(rootStackView)
        
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
        
        self.titleLabel.text = "Add an Invoice"
        self.amountLabel.text = "Amount"
        self.memoLabel.text = "Memo"
        self.invoiceLabel.text = "Invoice"
        self.submitButton.setTitle("Submit", for: .normal)
        self.copyButton.setTitle("Copy", for: .normal)
        
        self.amountTextField.borderStyle = .roundedRect
        self.memoTextField.borderStyle = .roundedRect
        
        self.invoiceLabel.numberOfLines = 0
        
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
        self.amountTextField.delegate = self
        self.memoTextField.delegate = self
        
        //        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        //        swipeDown.direction = .down
        //        self.view.addGestureRecognizer(swipeDown)
        
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
        
        self.titleLabel
            |> baseLabelStyleBoldTitle
        
        self.amountLabel
            |> baseLabelStyleSmallCaption
        
        self.amountTextField
            |> baseTextFieldStyleBoldBody
        
        self.memoLabel
            |> baseLabelStyleSmallCaption
        
        self.memoTextField
            |> baseTextFieldStyleBoldBody
        
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

//extension InvoiceViewController: PanModalPresentable {
//
//    var panScrollable: UIScrollView? {
//        return nil
//    }
//
//    var shortFormHeight: PanModalHeight {
//        return .contentHeight(400) //300
//    }
//
//    var longFormHeight: PanModalHeight {
//        return .maxHeightWithTopInset(100) // 40
//    }
//
//}

extension InvoiceViewController: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(100)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}
