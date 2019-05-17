//
//  StatusViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/27/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import PanModal
import M13Checkbox

class StatusViewController: UIViewController {
    
    private var viewModel: LightningViewModel!
    private let syncedLabel = UILabel()
    private let refreshedLabel = UILabel()
    private let checkbox = M13Checkbox()
    private let syncedStackView = UIStackView()
    private let infoButton = UIButton()
    private let infoStackView = UIStackView()
    private let rootStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func loadStatusVC() {
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            self.viewModel = LightningViewModel { _ in }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        self?.viewModel.lightningNodeInfo = $0
                        
                        let creationDate = Current.date()
                        let formattedDate = mrDateFormatter.string(from: creationDate)
                        self?.refreshedLabel.text = "Refreshed: \(formattedDate)"
                        
                        $0.syncedToChain ?
                            (self?.checkbox.setCheckState(.checked, animated: true)) :
                            (self?.checkbox.setCheckState(.unchecked, animated: true))
                        
                        $0.syncedToChain ?
                            (self?.syncedLabel.text = "Synced") :
                            (self?.syncedLabel.text = "Not Synced")
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
        
        loadStatusVC()
        
    }
    
    @objc private func modalButtonPressed() {
        let vc = StatusDetailViewController()
        presentPanModal(vc)
    }
    
}

extension StatusViewController {
    func setupUI() {
        
        self.syncedLabel
            |> finePrintStyle
        
        self.refreshedLabel
            |> baseTextStyle
            <> smallCapsText
            <> { $0.text = "Refreshing..." }
        
        self.checkbox
            |> checkboxStyle
        
        self.syncedStackView
            |> verticalStackViewStyle
            <> centerStackViewStyle
            <> { $0.addArrangedSubview(self.syncedLabel) }
            <> { $0.addArrangedSubview(self.refreshedLabel) }
            <> { $0.addArrangedSubview(self.checkbox) }
        
        self.infoButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Get Info", for: .normal) }
        
        self.infoButton.addTarget(
            self,
            action: #selector(modalButtonPressed),
            for: .touchUpInside
        )
        
        self.infoStackView
            |> verticalStackViewStyle
            <> { $0.addArrangedSubview(self.infoButton) }
        
        self.rootStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(32) }
            <> topLayoutMargins
            <> { $0.addArrangedSubview(self.syncedStackView) }
            <> { $0.addArrangedSubview(self.infoStackView) }
        
        self.view
            |> { $0.addSubview(self.rootStackView) }
            <> { $0.layoutMargins = .init(top: .mr_grid(6), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))}

        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -0),
            self.checkbox.heightAnchor.constraint(equalToConstant: 150.0),
            self.checkbox.widthAnchor.constraint(equalToConstant: 150.0),
            ])
        
    }
}
