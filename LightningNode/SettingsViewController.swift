//
//  SettingsViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/27/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var viewModel: LightningViewModel!
    private let staticAliasLabel = UILabel()
    private let aliasLabel = UILabel()
    private let aliasStackView = UIStackView()
    private let staticIdentityPubkeyLabel = UILabel()
    private let identityPubkeyLabel = UILabel()
    private let identityPubkeyStackView = UIStackView()
    private let identityStackView = UIStackView()
    private let lndVersionLabel = UILabel()
    private let tabsVersionLabel = UILabel()
    private let versionStackView = UIStackView()
    private let textStackView = UIStackView()
    private let removeNodeButton = UIButton()
    private let buttonStackView = UIStackView()
    private let rootStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadSettingsVC()
    }
    
    func loadSettingsVC() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            self.viewModel = LightningViewModel { [weak self] _ in
                self?.aliasLabel.text = "Getting Node Alias..."
                self?.identityPubkeyLabel.text = "Getting Pubkey..."
                self?.lndVersionLabel.text = "Getting LND Version..."
            }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        self?.viewModel.lightningNodeInfo = $0
                        self?.aliasLabel.text = "\($0.alias)"
                        self?.identityPubkeyLabel.text = "\($0.identityPubkey)"
                        self?.lndVersionLabel.text = "LND Version: \($0.version)"
                }
            }
        case .failure(_):
            if (self.navigationController != nil) {
                print("self.navigationController != nil")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("self.navigationController = nil")
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func deleteButtonPressed() {
        let alertController = UIAlertController(
            title: "Remove Node",
            message: "Are you sure you want to remove the node?",
            preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { (action: UIAlertAction!) in
                    deleteFromKeychain()
                    if (self.navigationController != nil) {
                        print("self.navigationController != nil")
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        print("self.navigationController = nil")
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
            }
            )
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { _ in }
            )
        )
        present(alertController, animated: true, completion: nil)
    }
    
}

extension SettingsViewController {
    func setupUI() {
        
        self.staticAliasLabel
            |> { $0.text = "Alias" }
            <> { $0.textAlignment = .center }
            <> { $0.textColor = .mr_gray }
        
        self.aliasLabel
            |> title3TextStyle
            <> { $0.textAlignment = .center }
            <> { $0.numberOfLines = 0 }
        
        self.aliasStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(2)}
            <> { $0.addArrangedSubview(self.staticAliasLabel) }
            <> { $0.addArrangedSubview(self.aliasLabel) }
        
        self.staticIdentityPubkeyLabel
            |> { $0.text = "Identity Pubkey" }
            <> { $0.textAlignment = .center }
            <> { $0.textColor = .mr_gray }
        
        self.identityPubkeyLabel
            |> title3TextStyle
            <> { $0.numberOfLines = 0 }
            <> { $0.textAlignment = .center }
        
        self.identityPubkeyStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(2)}
            <> { $0.addArrangedSubview(self.staticIdentityPubkeyLabel) }
            <> { $0.addArrangedSubview(self.identityPubkeyLabel) }
        
        self.identityStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(2)}
            <> { $0.addArrangedSubview(self.aliasStackView) }
            <> { $0.addArrangedSubview(self.identityPubkeyStackView) }
        
        self.lndVersionLabel
            |> { $0.textAlignment = .center }
            <> { $0.numberOfLines = 0 }
            <> smallCapsTextStyle
        
        self.tabsVersionLabel
            |> { $0.textAlignment = .center }
            <> { $0.text = "(Tabs LND Target Version: 0.7.1-beta)" }
            <> { $0.numberOfLines = 0 }
            <> smallCapsTextStyle
        
        self.versionStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(1)}
            <> { $0.addArrangedSubview(self.lndVersionLabel) }
            <> { $0.addArrangedSubview(self.tabsVersionLabel) }
        
        self.textStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(4)}
            <> { $0.addArrangedSubview(self.identityStackView) }
            <> { $0.addArrangedSubview(self.versionStackView) }
        
        self.removeNodeButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Remove Node", for: .normal) }
            <> { $0.setTitleColor(.mr_red, for: .normal) }
        
        self.removeNodeButton.addTarget(
            self,
            action: #selector(deleteButtonPressed),
            for: .touchUpInside
        )
        
        self.buttonStackView
            |> verticalStackViewStyle
            <> { $0.addArrangedSubview(self.removeNodeButton) }
        
        
        self.rootStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(32) }
            <> leftLayoutMarginsStyle
            <> { $0.addArrangedSubview(self.textStackView) }
            <> { $0.addArrangedSubview(self.buttonStackView) }
        
        self.view
            |> { $0.addSubview(self.rootStackView) }
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -45),
            ])
        
    }
    
}
