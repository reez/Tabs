//
//  NodeCollectionViewCell.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class NodeCollectionViewCell: UICollectionViewCell {
    
    var initialFrame: CGRect?
    var initialCornerRadius: CGFloat?
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var topButton: UIImageView!
    @IBOutlet var middleLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var hiddenButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var syncedButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.hiddenButton.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    private func configureCell() {
        
        self
            |> { $0.layer.shadowColor = UIColor.mr_black.cgColor }
            <> { $0.layer.masksToBounds = false }
            <> { $0.layer.shadowOpacity = 0.3 }
            <> { $0.layer.shadowOffset = CGSize(width: 0, height: 0) }
            <> { $0.layer.shadowRadius = self.contentView.layer.cornerRadius }
        
        self.contentView
            |> backgroundStyle(color: .white)
            <> { $0.layer.cornerRadius = 10 }
            <> { $0.layer.masksToBounds = true }
        
        self.hiddenButton
            |> roundedButtonStyle
        
        self.middleLabel
            |> baseLabelStyleSmallCaption
            <> textColorStyle(.mr_black)
        
        self.bottomLabel
            |> baseLabelStyleBoldCaption
            <> textColorStyle(.mr_black)
        
        self.syncedButton.image = nil
        
    }
    
    func configure(with info: Info) {
        
        self.topButton.image = UIImage(named: "status")
        
        self.mainView
            |> backgroundStyle(color: .mr_blue)
        
        self.topLabel
            |> map { $0.text = "Status" }
        
        blockstreamAPIRequest(testnet: info.testnet) { result in
            switch result {
            case let .success(height):
                let text = """
                "alias":
                \(info.alias)
                
                "bestHeaderTimestamp":
                \(info.bestHeaderTimestamp)
                
                refreshed -
                \(Current.date())
                
                "blockHeight":
                \(info.blockHeight)
                
                blockstream.info height -
                \(height)
                """
                DispatchQueue.main.async {
                    self.middleLabel.text = text
                }
            case .failure(_):
                let text = """
                alias:
                \(info.alias)
                
                bestHeaderTimestamp:
                \(info.bestHeaderTimestamp)
                
                refreshed:
                \(Current.date())
                
                blockHeight:
                \(info.blockHeight)
                """
                DispatchQueue.main.async {
                    self.middleLabel.text = text
                }
            }
        }
        
        info.syncedToChain ?
            (self.bottomLabel.text = "Synced") :
            (self.bottomLabel.text = "Not Synced")
        
        info.syncedToChain ?
            (self.syncedButton.image = UIImage(named: "synced")) :
            (self.syncedButton.image = UIImage(named: "close"))
        
        self.hiddenButton
            |> borderButtonStyle
            <> backgroundStyle(color: .white)
            <> { $0.setTitleColor(.mr_blue, for: .normal) }
            <> { $0.isEnabled = false }
        
        info.testnet ?
            self.hiddenButton.setTitle("Testnet", for: .normal) :
            self.hiddenButton.setTitle("Mainnet", for: .normal)
        
    }
    
    func configureInvoice(with info: Info) {
        
        self.topButton.image = UIImage(named: "lightning")
        
        self.mainView
            |> backgroundStyle(color: .mr_gold)
        
        self.topLabel
            |> map { $0.text = "Invoice" }
        
        self.middleLabel
            |> map {
                let text = """
                "identityPubKey":
                \(info.identityPubkey)
                
                "numActiveChannels":
                \(info.numActiveChannels)
                
                "numPendingChannels":
                \(info.numPendingChannels)
                
                "numPeers":
                \(info.numPeers)
                """
                
                $0.text = text
        }
        
        self.bottomLabel
            .map { $0.text = "Create An Invoice" }
        
        self.syncedButton.image = nil
        
        self.hiddenButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_gold)
            <> { $0.isEnabled = true }
            <> { $0.isHidden = false }
            <> { $0.setTitle("Invoice", for: .normal) }
            <> { $0.layer.borderColor = UIColor.mr_gold.cgColor }
        
    }
    
    func configureDelete(with info: Info) {
        
        self.topButton.image = UIImage(named: "settings")
        
        self.mainView
            |> backgroundStyle(color: .mr_red)
        
        self.topLabel
            |> map { $0.text = "Settings" }
        
        self.middleLabel
            |> map {
                let text = """
                "version":
                \(info.version)
                """
                
                $0.text = text
        }
        
        self.bottomLabel
            |> map { $0.text = "Remove Node" }
        
        self.syncedButton.image = nil
        
        self.hiddenButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_red)
            <> { $0.setTitle("Remove", for: .normal) }
            <> { $0.isEnabled = true }
            <> { $0.isHidden = false }
        
    }
    
}

extension NodeCollectionViewCell {
    
    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        self.initialFrame = self.frame
        let currentX = self.frame.origin.x
        let newX: CGFloat
        
        if currentX < frameOfSelectedCell.origin.x {
            newX = collectionView.contentOffset.x -
                (frameOfSelectedCell.origin.x - currentX)
        } else {
            newX = collectionView.contentOffset.x +
                collectionView.frame.width +
                (currentX - frameOfSelectedCell.maxX)
        }
        
        self.frame.origin.x = newX
        layoutIfNeeded()
    }
    
    func show() {
        self.frame = self.initialFrame ?? self.frame
        self.initialFrame = nil
        layoutIfNeeded()
    }
    
    func expand(in collectionView: UICollectionView) {
        self.initialFrame = self.frame
        self.initialCornerRadius = self.contentView.layer.cornerRadius
        self.contentView.layer.cornerRadius = 0
        self.frame = CGRect(
            x: collectionView.contentOffset.x,
            y: 0, width: collectionView.frame.width,
            height: collectionView.frame.height
        )
        layoutIfNeeded()
    }
    
    func collapse() {
        self.contentView.layer.cornerRadius = self.initialCornerRadius ?? self.contentView.layer.cornerRadius
        self.frame = self.initialFrame ?? self.frame
        self.initialFrame = nil
        self.initialCornerRadius = nil
        layoutIfNeeded()
    }
    
}
