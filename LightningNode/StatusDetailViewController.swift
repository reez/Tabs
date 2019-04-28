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
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mr_black
        label.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.nameLabel.numberOfLines = 0
        self.view.addSubview(nameLabel)
        
        setupConstraints()
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            
            self.viewModel = LightningViewModel { [weak self] _ in
                //self?.infoLabel.text = "..."
            }
            
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
                        
                        self?.nameLabel.text = text
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
    
    func setupConstraints() {
        // This should just go in layoutConstraints
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
    }
    
}

extension StatusDetailViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    //    var shortFormHeight: PanModalHeight {
    //        return .contentHeight(400) //300
    //    }
    //
    //    var longFormHeight: PanModalHeight {
    //        return .maxHeightWithTopInset(50) // 40
    //    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(400)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
}
