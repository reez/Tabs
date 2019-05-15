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
    private let rootStackView = UIStackView()
    private let removeNodeButton = UIButton()
    private let lndVersionLabel = UILabel()
    private let tabsVersionLabel = UILabel()
    private let aliasLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let textStackView = UIStackView()
    private let identityPubkeyLabel = UILabel()
    private let identityStackView = UIStackView()
    private let versionStackView = UIStackView()
    private let staticAliasLabel = UILabel()
    private let staticIdentityLabel = UILabel()
    private let pubkeyStackView = UIStackView()
    private let aliasStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadSettingsVC()
    }
    
    func loadSettingsVC() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            self.viewModel = LightningViewModel { [weak self] _ in
                self?.lndVersionLabel.text = "Getting LND Version..."
                self?.aliasLabel.text = "Getting Node Alias..."
                self?.identityPubkeyLabel.text = "Getting Pubkey..."
            }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        self?.viewModel.lightningNodeInfo = $0
                        
                        self?.lndVersionLabel.text = "LND Version: \($0.version)"
                        self?.aliasLabel.text = "\($0.alias)"
                        self?.identityPubkeyLabel.text = "\($0.identityPubkey)"
                }
            }
        case .failure(_):
            let bundle = Bundle(for: AddNodeViewController.self)
            let addNodeIdentifier = Reusing<AddNodeViewController>().identifier()
            let storyboard = UIStoryboard.init(name: addNodeIdentifier, bundle: bundle)
            let vc = storyboard.instantiateViewController(withIdentifier: addNodeIdentifier) as! AddNodeViewController
            self.navigationController?.pushViewController(vc, animated: true)
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
                    let bundle = Bundle(for: AddNodeViewController.self)
                    let addNodeIdentifier = Reusing<AddNodeViewController>().identifier()
                    let storyboard = UIStoryboard.init(name: addNodeIdentifier, bundle: bundle)
                    let vc = storyboard.instantiateViewController(withIdentifier: addNodeIdentifier) as! AddNodeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
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
        
        self.rootStackView
            |> settingsLayoutMargins
            <> statusRootStackViewStyle
        
        self.buttonStackView
            |> settingsStackViewStyle
        
        self.textStackView
            |> settingsStackViewStyle
            <> { $0.spacing = .mr_grid(4)}

        self.identityStackView
            |> settingsStackViewStyle
            <> { $0.spacing = .mr_grid(2)}

        self.versionStackView
            |> settingsStackViewStyle
            <> { $0.spacing = .mr_grid(1)}
        
        self.pubkeyStackView
            |> settingsStackViewStyle
            <> { $0.spacing = .mr_grid(2)}
        
        self.aliasStackView
            |> settingsStackViewStyle
            <> { $0.spacing = .mr_grid(2)}
        
//        self.tabsVersionLabel.text = "(Tabs LND Version: 0.5.2-beta)"
        
//        self.staticAliasLabel.text = "Alias"
//        self.staticAliasLabel.textColor = .mr_gray
//        self.staticAliasLabel.textAlignment = .center
        
        self.staticAliasLabel
            |> { $0.text = "Alias" }
            <> { $0.textAlignment = .center }
            <> { $0.textColor = .mr_gray }

//        self.staticIdentityLabel.text = "Identity Pubkey"
//        self.staticIdentityLabel.textColor = .mr_gray
//        self.staticIdentityLabel.textAlignment = .center

        self.staticIdentityLabel
            |> { $0.text = "Identity Pubkey" }
            <> { $0.textAlignment = .center }
            <> { $0.textColor = .mr_gray }

//        self.lndVersionLabel.numberOfLines = 0
//        self.lndVersionLabel.textAlignment = .center
        
        self.lndVersionLabel
            |> { $0.textAlignment = .center }
            <> { $0.numberOfLines = 0 }

//        self.tabsVersionLabel.numberOfLines = 0
        
//        self.lndVersionLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
//
//        self.tabsVersionLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
//        self.tabsVersionLabel.textAlignment = .center

        self.tabsVersionLabel
            |> smallCapsText
            <> { $0.textAlignment = .center }

        self.lndVersionLabel
            |> smallCapsText
        
//        self.aliasLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
//        self.aliasLabel.textAlignment = .center
        //        self.aliasLabel.numberOfLines = 0

        self.aliasLabel
            |> title3Text
            <> { $0.textAlignment = .center }
            <> { $0.numberOfLines = 0 }

//        self.identityPubkeyLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        //        self.identityPubkeyLabel.numberOfLines = 0
        //        self.identityPubkeyLabel.textAlignment = .center

        self.identityPubkeyLabel
            |> title3Text
            <> { $0.numberOfLines = 0 }
            <> { $0.textAlignment = .center }

        self.tabsVersionLabel
            |> baseLabelStyleSmallCaption
            <> { $0.text = "(Tabs LND Version: 0.5.2-beta)" }
            <> { $0.numberOfLines = 0 }
        
        
//        self.removeNodeButton.setTitle("Remove Node", for: .normal)
        self.removeNodeButton
            |> removeButtonStyle
            <> { $0.setTitle("Remove Node", for: .normal) }
        
        self.removeNodeButton.addTarget(
            self,
            action: #selector(deleteButtonPressed),
            for: .touchUpInside
        )

        

        
        self.aliasStackView.addArrangedSubview(staticAliasLabel)
        self.aliasStackView.addArrangedSubview(aliasLabel)
        self.identityStackView.addArrangedSubview(aliasStackView)
        self.pubkeyStackView.addArrangedSubview(staticIdentityLabel)
        self.pubkeyStackView.addArrangedSubview(identityPubkeyLabel)
        self.identityStackView.addArrangedSubview(pubkeyStackView)

        self.textStackView.addArrangedSubview(identityStackView)
        self.versionStackView.addArrangedSubview(lndVersionLabel)
        self.versionStackView.addArrangedSubview(tabsVersionLabel)
        self.textStackView.addArrangedSubview(versionStackView)

        self.buttonStackView.addArrangedSubview(removeNodeButton)
    
        self.rootStackView.addArrangedSubview(textStackView)
        self.rootStackView.addArrangedSubview(buttonStackView)
        
        self.view.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -45),
            ])
        
    }}
