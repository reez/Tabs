//
//  InvoicesTableViewController.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 4/28/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import UIKit
import LNDrpc
import PanModal

class InvoicesTableViewController: UITableViewController {
    
    var invoicesArray: [Invoice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tableView.estimatedRowHeight = 400
        //        self.tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadList), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.refreshControl = refreshControl
        
        invoices { [weak self] (result) in
            switch result {
            case let .success(invoices):
                self?.invoicesArray = invoices
                self?.tableView.reloadData()
            case .failure(_):
                print("Nope")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        invoices { [weak self] (result) in
            switch result {
            case let .success(invoices):
                self?.invoicesArray = invoices
                self?.tableView.reloadData()
            case .failure(_):
                print("Nope")
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = CreateInvoiceCell(style: .default, reuseIdentifier: nil)
            
            cell.tapAction = { [weak self] cell in
                print("Tap action!")
                
                let vc = InvoiceViewController()
                self?.presentPanModal(vc)
            }
            
            return cell
        }
        
        let cell = InvoiceInfoCell(style: .default, reuseIdentifier: nil)
        // This reversing probably needs more global scope if want to tap on cell in the future
        // i.e. doing this in LightningAPI or when setting self.invoicesArray in View Controller
        let reversed = Array(invoicesArray.reversed())
        cell.configure(with: reversed[indexPath.row - 1])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoicesArray.count + 1
    }
    
    @objc func tappedInvoiceCreate() {
        print("tappedInvoiceCreate")
    }
    
    // This is my workaround for refreshing after modal dismissed
    // prob should use this function in vdl and vda
    @objc func loadList(){
        invoices { [weak self] (result) in
            print("Result: \(result)")
            switch result {
            case let .success(invoices):
                print("Load dat")
                self?.invoicesArray = invoices
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            case .failure(_):
                self?.tableView.refreshControl?.endRefreshing()
                print("Nope")
            }
        }
        
    }
    
}


final class CreateInvoiceCell: UITableViewCell {
    private let bodyLabel = UILabel()
    private let buttonsStackView = UIStackView()
    private let addInvoiceButton = UIButton()
    private let rootStackView = UIStackView()
    var tapAction: ((UITableViewCell) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addInvoiceButton.addTarget(
            self,
            action: #selector(tappedInvoiceCreate),
            for: .touchUpInside
        )
        
        self.selectionStyle = .none
        self.contentView.layoutMargins = .init(top: .mr_grid(12), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
        
        self.bodyLabel.text = """
        🌩
        Check out your Lightning Invoices
        - or -
        Add a new Lightning Invoice
        """
        
        self.bodyLabel.numberOfLines = 0
        self.bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        self.bodyLabel.textAlignment = .center
        
        self.rootStackView.alignment = .center
        self.rootStackView.addArrangedSubview(self.bodyLabel)
        self.rootStackView.addArrangedSubview(self.buttonsStackView)
        
        self.rootStackView.layoutMargins.top = .mr_grid(6)
        self.rootStackView.layoutMargins.left = .mr_grid(6)
        self.rootStackView.layoutMargins.bottom = .mr_grid(6)
        self.rootStackView.layoutMargins.right = .mr_grid(6)
        
        self.contentView.addSubview(self.rootStackView)
        
        self.rootStackView.spacing = .mr_grid(12)
        self.rootStackView.axis = .vertical
        self.rootStackView.isLayoutMarginsRelativeArrangement = true
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addInvoiceButton.setTitle("Add an Invoice", for: .normal)
        self.addInvoiceButton
            |> unfilledButtonStyle
//        addInvoiceButton.backgroundColor = .mr_gold
        
        self.buttonsStackView.spacing = .mr_grid(2)
        self.buttonsStackView.addArrangedSubview(self.addInvoiceButton)
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            ])
        
    }
    
    @objc func tappedInvoiceCreate() {
        print("tappedInvoiceCreate")
        tapAction?(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class InvoiceInfoCell: UITableViewCell {
    private let amountLabel = UILabel()
    private let contentStackView = UIStackView()
    private let rootStackView = UIStackView()
    private let sequenceAndDateLabel = UILabel()
    private let titleLabel = UILabel()
    private let lightningImageView = UIImageView()
    private let lightningStackView = UIStackView()
    
    private let amountLabelStatic = UILabel()
    private let titleLabelStatic = UILabel()
    private let amountStackView = UIStackView()
    private let titleStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.lightningImageView.image = UIImage(named: "lightning")
        
        self.contentStackView.layoutMargins.top = .mr_grid(6)
        self.contentStackView.layoutMargins.left = .mr_grid(6)
        self.contentStackView.layoutMargins.bottom = .mr_grid(6)
        self.contentStackView.layoutMargins.right = .mr_grid(6)
        
        self.contentStackView.spacing = .mr_grid(2)
        self.contentStackView.axis = .vertical
        self.contentStackView.isLayoutMarginsRelativeArrangement = true
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.lightningStackView.spacing = .mr_grid(2)
        self.lightningStackView.isLayoutMarginsRelativeArrangement = true
        self.lightningStackView.translatesAutoresizingMaskIntoConstraints = false
        self.lightningStackView.axis = .horizontal
        self.lightningStackView.addArrangedSubview(sequenceAndDateLabel)
        
        self.amountStackView.spacing = .mr_grid(1)
        self.amountStackView.isLayoutMarginsRelativeArrangement = true
        self.amountStackView.translatesAutoresizingMaskIntoConstraints = false
        self.amountStackView.axis = .horizontal
        self.amountStackView.addArrangedSubview(lightningImageView)
        self.amountStackView.addArrangedSubview(amountLabel)
        
        self.titleStackView.spacing = .mr_grid(1)
        self.titleStackView.isLayoutMarginsRelativeArrangement = true
        self.titleStackView.translatesAutoresizingMaskIntoConstraints = false
        self.titleStackView.axis = .horizontal
        self.titleStackView.addArrangedSubview(titleLabel)
        
        self.contentStackView.alignment = .leading
        self.contentStackView.addArrangedSubview(lightningStackView)
        self.contentStackView.addArrangedSubview(self.titleStackView)
        self.contentStackView.addArrangedSubview(self.amountStackView)
        
        self.rootStackView.layoutMargins.top = .mr_grid(2)
        self.rootStackView.layoutMargins.left = .mr_grid(2)
        self.rootStackView.layoutMargins.bottom = .mr_grid(2)
        self.rootStackView.layoutMargins.right = .mr_grid(2)
        
        self.rootStackView.spacing = .mr_grid(2)
        self.rootStackView.axis = .vertical
        self.rootStackView.isLayoutMarginsRelativeArrangement = true
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        self.rootStackView.addArrangedSubview(self.contentStackView)
        
        self.sequenceAndDateLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
        
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        self.titleLabel.numberOfLines = 0
        self.amountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabelStatic.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.amountLabelStatic.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.sequenceAndDateLabel.numberOfLines = 0

        self.contentView.addSubview(self.rootStackView)
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.rootStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.lightningImageView.heightAnchor.constraint(equalToConstant: 16.0),
            self.lightningImageView.widthAnchor.constraint(equalToConstant: 16.0),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with episode: Invoice) {
        self.titleLabel.text = "\(episode.memo ?? "")"//episode.title
        self.amountLabel.text = "\(episode.value)"//episode.blurb
        
        let creationDate = episode.creationDate
        let cDDouble = Double(creationDate)
        let dr = Date(timeIntervalSince1970: cDDouble)
        let formattedDate = monthDateHourAMPMFormatter.string(from: dr)
        self.sequenceAndDateLabel.text = "Creation date: \(formattedDate) • Invoice expiry: \(episode.expiry) • Invoice settled: \(episode.settled)"
        
        // Do I want to make the call for invoices here?
    }
    
}
