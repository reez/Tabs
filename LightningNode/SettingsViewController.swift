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
        self.tabsVersionLabel.text = "(Tabs LND Version: 0.5.2-beta)"
        self.staticAliasLabel.text = "Alias"
        self.staticIdentityLabel.text = "Identity Pubkey"
        self.staticIdentityLabel.textColor = .gray
        self.staticAliasLabel.textColor = .gray

        
        self.removeNodeButton.setTitle("Remove Node", for: .normal)
        self.removeNodeButton
            |> removeButtonStyle
        
        self.removeNodeButton.addTarget(
            self,
            action: #selector(deleteButtonPressed),
            for: .touchUpInside
        )
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
        self.rootStackView.layoutMargins.top = .mr_grid(6)
        self.rootStackView.layoutMargins.left = .mr_grid(12)
        self.rootStackView.layoutMargins.bottom = .mr_grid(0)
        self.rootStackView.layoutMargins.right = .mr_grid(12)
        
        self.rootStackView.spacing = .mr_grid(32)
        self.rootStackView.axis = .vertical
        self.rootStackView.isLayoutMarginsRelativeArrangement = true
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonStackView.spacing = .mr_grid(6)
        self.buttonStackView.axis = .vertical
        self.buttonStackView.isLayoutMarginsRelativeArrangement = true
        self.buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textStackView.spacing = .mr_grid(4)
        self.textStackView.axis = .vertical
        self.textStackView.isLayoutMarginsRelativeArrangement = true
        self.textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.identityStackView.spacing = .mr_grid(2)
        self.identityStackView.axis = .vertical
        self.identityStackView.isLayoutMarginsRelativeArrangement = true
        self.identityStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.versionStackView.spacing = .mr_grid(1)
        self.versionStackView.axis = .vertical
        self.versionStackView.isLayoutMarginsRelativeArrangement = true
        self.versionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.pubkeyStackView.spacing = .mr_grid(2)
        self.pubkeyStackView.axis = .vertical
        self.pubkeyStackView.isLayoutMarginsRelativeArrangement = true
        self.pubkeyStackView.translatesAutoresizingMaskIntoConstraints = false

        self.aliasStackView.spacing = .mr_grid(2)
        self.aliasStackView.axis = .vertical
        self.aliasStackView.isLayoutMarginsRelativeArrangement = true
        self.aliasStackView.translatesAutoresizingMaskIntoConstraints = false

        self.lndVersionLabel.numberOfLines = 0
        self.aliasLabel.numberOfLines = 0
        self.tabsVersionLabel.numberOfLines = 0
        self.identityPubkeyLabel.numberOfLines = 0
        
        self.lndVersionLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
        self.tabsVersionLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
        self.aliasLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        self.identityPubkeyLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        
        self.aliasLabel.textAlignment = .center
        self.staticAliasLabel.textAlignment = .center
        self.identityPubkeyLabel.textAlignment = .center
        self.staticIdentityLabel.textAlignment = .center
        
        self.lndVersionLabel.textAlignment = .center
        self.tabsVersionLabel.textAlignment = .center
        
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
