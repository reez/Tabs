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
    private let imageView = UIImageView()
    private let infoButton = UIButton()
    private let infoLabel = UILabel()
    private let refreshedLabel = UILabel()
    private let rootStackView = UIStackView()
    private let checkbox = M13Checkbox()
    private let syncedStackView = UIStackView()
    private let moreInfoStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            self.viewModel = LightningViewModel { [weak self] _ in
                
            }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        self?.viewModel.lightningNodeInfo = $0
                        
                        let creationDate = Current.date()
                        let formattedDate = monthDateHourAMPMFormatter.string(from: creationDate)
                        
                        self?.refreshedLabel.text = "Refreshed: \(formattedDate)"
                        
                        $0.syncedToChain ?
                            (self?.imageView.image = UIImage(named: "synced")) :
                            (self?.imageView.image = UIImage(named: "close"))
                        
                        $0.syncedToChain ?
                            (self?.checkbox.setCheckState(.checked, animated: true)) :
                            (self?.checkbox.setCheckState(.unchecked, animated: true))
                        
                        $0.syncedToChain ?
                            (self?.infoLabel.text = "Synced") :
                            (self?.infoLabel.text = "Not Synced")
                        
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
    
    @objc private func modalButtonPressed() {
        let vc = StatusDetailViewController()
        presentPanModal(vc)
    }
    
}

extension StatusViewController {
    func setupUI() {
        self.rootStackView.layoutMargins.top = .mr_grid(12)
        self.rootStackView.layoutMargins.left = .mr_grid(6)
        self.rootStackView.layoutMargins.bottom = .mr_grid(12)
        self.rootStackView.layoutMargins.right = .mr_grid(6)
        
        self.rootStackView.spacing = .mr_grid(48) //
        self.rootStackView.axis = .vertical
        self.rootStackView.isLayoutMarginsRelativeArrangement = true
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.syncedStackView.spacing = .mr_grid(6)
        self.syncedStackView.axis = .vertical
        self.syncedStackView.isLayoutMarginsRelativeArrangement = true
        self.syncedStackView.translatesAutoresizingMaskIntoConstraints = false
        self.syncedStackView.alignment = .center
        
        self.infoLabel.numberOfLines = 0
        self.infoLabel.textAlignment = .center
        self.infoLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        self.moreInfoStackView.spacing = .mr_grid(6)
        self.moreInfoStackView.axis = .vertical
        self.moreInfoStackView.isLayoutMarginsRelativeArrangement = true
        self.moreInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.refreshedLabel.text = "Refreshing..."
        self.refreshedLabel.numberOfLines = 0
        self.refreshedLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
        
        self.imageView.image = nil
        
        self.infoButton.addTarget(
            self,
            action: #selector(modalButtonPressed),
            for: .touchUpInside
        )
        self.infoButton.setTitle("Get Info", for: .normal)
        self.infoButton
            |> unfilledButtonStyle
//            <> backgroundStyle(color: .mr_gold)
        
        checkbox.setCheckState(.unchecked, animated: true)
        checkbox.animationDuration = 0.50
        checkbox.tintColor = .mr_green
        checkbox.secondaryTintColor = .mr_gray
        checkbox.checkmarkLineWidth = 6.0
        checkbox.boxLineWidth = 3.0
        checkbox.boxType = .circle
        
        self.syncedStackView.addArrangedSubview(infoLabel)
        self.syncedStackView.addArrangedSubview(refreshedLabel)
        self.syncedStackView.addArrangedSubview(checkbox)
        
        self.moreInfoStackView.addArrangedSubview(infoButton)

        self.rootStackView.addArrangedSubview(syncedStackView)
        self.rootStackView.addArrangedSubview(moreInfoStackView)
        
        self.view.addSubview(self.rootStackView)
        self.view.layoutMargins = .init(top: .mr_grid(6), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -0),
            self.checkbox.heightAnchor.constraint(equalToConstant: 150.0),
            self.checkbox.widthAnchor.constraint(equalToConstant: 150.0),
            ])
    }
}
