//
//  NodeCollectionViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit

class NodeCollectionViewController: UICollectionViewController {
    
    private var hiddenCells: [NodeCollectionViewCell] = []
    private var expandedCell: NodeCollectionViewCell?
    private var remoteNodeConnection: RemoteNodeConnection?
    private var viewModel: LightningViewModel!
    private var height: String?
    private let activityIndicator = UIActivityIndicatorView(style: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let imageView : UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named:"Background.png")
            iv.contentMode = .scaleAspectFit
            return iv
        }()
        self.collectionView?.backgroundView = imageView

        self.view.addSubview(activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = self.view.center
        
        viewModel = LightningViewModel { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            remoteNodeConnection = savedConfig
            Current.lightningAPIRPC = LightningApiRPC.init(configuration: savedConfig) // was using saved config
            Current.lightningAPIRPC?.info { [weak self] result in
                result.value
                    |> flatMap {
                        self?.viewModel.lightningNodeInfo = $0
                        self?.collectionView.reloadData()
                }
            }
        case .failure(_):
            let alertController = UIAlertController(
                title: DataError.fetchInfoFailure.localizedDescription,
                message: DataError.fetchInfoFailure.errorDescription,
                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
        
    }
        
    @IBAction func refreshButtonAction(_ sender: Any) {
        refreshButtonPressed()
    }
    
}

extension NodeCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nodeCellIdentifier = Reusing<NodeCollectionViewCell>().identifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nodeCellIdentifier, for: indexPath) as! NodeCollectionViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: viewModel.lightningNodeInfo)
            
            return cell
        }
        else if indexPath.row == 1 {
            cell.configureInvoice(with: viewModel.lightningNodeInfo)
            cell.hiddenButton.addTarget(
                self,
                action: #selector(invoiceButtonPressed),
                for: .touchUpInside
            )
            
            return cell
        }
        else if indexPath.row == 2 {
            cell.configureDelete(with: viewModel.lightningNodeInfo)
            cell.hiddenButton.addTarget(
                self,
                action: #selector(deleteButtonPressed),
                for: .touchUpInside
            )
            
            return cell
        }
        else {
            fatalError()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.contentOffset.x < 0 ||
            collectionView.contentOffset.x >
            collectionView.contentSize.width - collectionView.frame.width { return }
        
        let dampingRatio: CGFloat = 0.8
        let initialVelocity: CGVector = CGVector.zero
        let springParameters = UISpringTimingParameters(
            dampingRatio: dampingRatio,
            initialVelocity: initialVelocity
        )
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
        self.view.isUserInteractionEnabled = false
        
        if let selectedCell = expandedCell {
            
            selectedCell.refreshButton.isHidden = false
            
            animator.addAnimations {
                selectedCell.collapse()
                
                self.hiddenCells.forEach{ $0.show() }
            }
            
            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true
                
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            
            collectionView.isScrollEnabled = false
            
            let selectedCell = collectionView.cellForItem(at: indexPath)! as! NodeCollectionViewCell
            let frameOfSelectedCell = selectedCell.frame
            
            selectedCell.refreshButton.isHidden = true
            
            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells
                .map { $0 as! NodeCollectionViewCell }
                .filter { $0 != selectedCell }
            
            animator.addAnimations {
                selectedCell.expand(in: collectionView)
                
                self.hiddenCells
                    .forEach {
                        $0.hide(
                            in: collectionView,
                            frameOfSelectedCell: frameOfSelectedCell
                        )
                }
            }
            
        }
        
        
        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        animator.addCompletion { _ in self.view.isUserInteractionEnabled = true }
        
        animator.startAnimation()
    }
    
}

extension NodeCollectionViewController {
    
    @objc private func refreshButtonPressed() {
        self.activityIndicator.startAnimating()
        
        switch Current.keychain.load() {
        case let .success(savedConfig):
            Current.lightningAPIRPC = LightningApiRPC.init(configuration: savedConfig)
            Current.lightningAPIRPC?.info { [weak self] result in
                result.value.flatMap {
                    self?.viewModel.lightningNodeInfo = $0
                    self?.collectionView.reloadData()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                self.activityIndicator.stopAnimating()
            }
        case .failure(_):
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(
                title: DataError.fetchInfoFailure.localizedDescription,
                message: DataError.fetchInfoFailure.errorDescription,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
    
    @objc private func invoiceButtonPressed() {
        let bundle = Bundle(for: AddInvoiceViewController.self)
        let addInvoiceIdentifier = Reusing<AddInvoiceViewController>().identifier()
        let storyboard = UIStoryboard(name: addInvoiceIdentifier, bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: addInvoiceIdentifier) as! AddInvoiceViewController
        print("Remote Node Connection invoice: \(String(describing: remoteNodeConnection))")
        
        vc.remoteNodeConnection = remoteNodeConnection //fakeRemoteNodeConnection
        self.navigationController?.pushViewController(vc, animated: true)
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
                handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
            }
            )
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
}
