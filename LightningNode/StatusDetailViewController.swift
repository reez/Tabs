//
//  StatusDetailViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/28/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import PanModal

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
            <> { $0.backgroundColor = .white }
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0)
            ])
        
    }
    
    func loadStatusDetail() {
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
                        
                        "chainsArray": \($0.chainsArray.firstObject!)
                        
                        "numActiveChannels": \($0.numActiveChannels)
                        
                        "numPeers": \($0.numPeers)
                        
                        "numPendingChannels": \($0.numPendingChannels)
                        
                        "syncedToChain": \($0.syncedToChain)
                        
                        "testnet": \($0.testnet)
                        """
                        
                        self?.infoLabel.text = text
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
    
}

extension StatusDetailViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
}
