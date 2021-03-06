//
//  StatusDetailViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/28/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class StatusDetailViewController: UIViewController {
    
    private var viewModel: LightningViewModel!
    let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadStatusDetail()
    }
    
}

extension StatusDetailViewController {
    
    func setupUI() {
        
        self.infoLabel
            |> infoTextStyle
        
        self.view
            |> { $0.addSubview(self.infoLabel) }
            <> { $0.backgroundColor = .systemBackground }
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
    }
    
    func loadStatusDetail() {
//        self.nvActivityIndicator?.startAnimating()
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            self.viewModel = LightningViewModel { _ in }
            
            Current.remoteNodeConnectionFormatted = savedConfig
            Current.lightningAPIRPC.info { [weak self] result in
                try? result.get()
                    |> flatMap {
                        self?.viewModel.lightningNodeInfo = $0
                        
                        let text = """
                        "alias": \($0.alias)
                        
                        "blockHeight": \($0.blockHeight)
                        
                        "chain": \($0.chainsArray)
                        
                        "network": \($0.network)
                        
                        "numActiveChannels": \($0.numActiveChannels)
                        
                        "numPeers": \($0.numPeers)
                        
                        "numPendingChannels": \($0.numPendingChannels)
                        
                        "syncedToChain": \($0.syncedToChain)
                        """
                        
                        self?.infoLabel.text = text
//                        self?.nvActivityIndicator?.stopAnimating()
                }
            }
        case .failure(_):
//            self.nvActivityIndicator?.stopAnimating()
            if (self.navigationController != nil) {
                print("self.navigationController != nil")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("self.navigationController = nil")
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
