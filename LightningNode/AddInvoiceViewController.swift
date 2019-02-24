//
//  AddInvoiceViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AddInvoiceViewController: UIViewController {
    
    private var nvActivityIndicator: NVActivityIndicatorView?
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var memoTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var invoiceLabel: UILabel!
    @IBOutlet var copyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        let slideDown = UISwipeGestureRecognizer(
//            target: self,
//            action: #selector(dismissView(gesture:))
//        )
//            slideDown.direction = .down
//            view.addGestureRecognizer(slideDown)

    }
    

    
    
//
//    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
//        UIView.animate(withDuration: 0.4) {
//            if let theWindow = UIApplication.shared.keyWindow {
//                gesture.view?.frame = CGRect(x:theWindow.frame.width - 15 , y: theWindow.frame.height - 15, width: 10 , height: 10)
//            }
//        }
//    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
//        _ = navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.nvActivityIndicator?.stopAnimating()
                    }
                    self.invoiceLabel.isHidden = output.invoiceLabelHidden
                    self.copyButton.isHidden = output.copyButtonHidden
                    self.invoiceLabel.text = output.invoiceLabel
                    self.amountTextField.text = output.amountTextFieldOutput
                    self.memoTextField.text = output.memoTextFieldOutput
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
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
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
    func setupUI() {
        self.amountTextField.delegate = self
        self.memoTextField.delegate = self

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
