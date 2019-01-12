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
    @IBOutlet var middleLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var hiddenButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        
        self
            |> { $0.layer.shadowColor = UIColor.black.cgColor }
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
            |> baseLabelStyleSmall
            <> textColorStyle(.white)
        
        self.bottomLabel
            |> baseLabelStyleBoldCaption
            <> textColorStyle(.white)
        
    }
    
    func configure(with info: Info) {
        
        self.mainView
            |> backgroundStyle(color: .mr_blue)
        
        self.topLabel
            |> map { $0.text = "Status" }
    
        blockstreamAPIRequest(testnet: info.testnet) { result in
            
            switch result {
                
            case let .success(height):
                let text = """
                alias:
                \(info.alias)
                
                bestHeaderTimestamp:
                \(info.bestHeaderTimestamp)
                
                blockHeight:
                \(info.blockHeight)
                
                Blockstream.info:
                \(height)
                
                refreshed:
                \(Current.date())
                """
                
                DispatchQueue.main.async {
                    self.middleLabel.text = text
                }
            case .failure(_):
                self.middleLabel
                    |> map {
                        let text = """
                        alias:
                        \(info.alias)
                        
                        bestHeaderTimestamp:
                        \(info.bestHeaderTimestamp)
                        
                        blockHeight:
                        \(info.blockHeight)
                        
                        refreshed:
                        \(Current.date())
                        """
                        
                        $0.text = text
                }
            }
            
        }
        
        info.syncedToChain ?
            (self.bottomLabel.text = "Synced: ✅") :
            (self.bottomLabel.text = "Synced: ❌")
        
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
        
        self.mainView
            |> backgroundStyle(color: .mr_purple)
        
        self.topLabel
            |> map { $0.text = "Invoice" }
        
        self.middleLabel
            |> map {
                let text = """
                identityPubKey:
                \(info.identityPubkey)
                
                numActiveChannels:
                \(info.numActiveChannels)
                
                numPendingChannels:
                \(info.numPendingChannels)
                
                numPeers:
                \(info.numPeers)
                """
                
                $0.text = text
        }
        
        self.bottomLabel
            .map { $0.text = "Create An Invoice" }
        
        self.hiddenButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_purple)
            <> { $0.isEnabled = true }
            <> { $0.isHidden = false }
            <> { $0.setTitle("Invoice", for: .normal) }
        
    }
    
    func configureDelete(with info: Info) {
        
        self.mainView
            |> backgroundStyle(color: .mr_red)
        
        self.topLabel
            |> map { $0.text = "Settings" }
        
        self.middleLabel
            |> map {
                let text = """
                version:
                \(info.version)
                
                urisArray:
                \(info.urisArray
                    .map { $0.absoluteString }
                    .joined(separator: ", "))
                
                chainsArray:
                \(info.chainsArray
                    .componentsJoined(by: ", "))
                """
                
                $0.text = text
        }
        
        self.bottomLabel
            |> map { $0.text = "Delete Node" }
        
        self.hiddenButton
            |> filledButtonStyle
            <> backgroundStyle(color: .mr_red)
            <> { $0.setTitle("Delete", for: .normal) }
            <> { $0.isEnabled = true }
            <> { $0.isHidden = false }
        
    }
    
}

extension NodeCollectionViewCell {
    
    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        initialFrame = self.frame
        
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
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        
        layoutIfNeeded()
    }
    
    func expand(in collectionView: UICollectionView) {
        initialFrame = self.frame
        initialCornerRadius = self.contentView.layer.cornerRadius
        
        self.contentView.layer.cornerRadius = 0
        self.frame = CGRect(x: collectionView.contentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        
        layoutIfNeeded()
    }
    
    func collapse() {
        self.contentView.layer.cornerRadius = initialCornerRadius ?? self.contentView.layer.cornerRadius
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        initialCornerRadius = nil
        
        layoutIfNeeded()
    }
    
}
