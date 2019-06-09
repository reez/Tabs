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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadInvoices), name: NSNotification.Name(rawValue: "load"), object: nil)
        setupUI()
        loadInvoices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadInvoices()
    }
    
}

extension InvoicesTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = CreateInvoiceCell(style: .default, reuseIdentifier: nil)
            
            cell.tapAction = { [weak self] cell in
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
    
}

extension InvoicesTableViewController {
    
    func setupUI() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadInvoices), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.refreshControl = refreshControl
    }
    
    // This is my workaround for refreshing after modal dismissed
    @objc func loadInvoices(){
        invoices { [weak self] (result) in
            switch result {
            case let .success(invoices):
                self?.invoicesArray = invoices
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            case .failure(_):
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
        
    }
    
}

final class CreateInvoiceCell: UITableViewCell {
    private let bodyLabel = UILabel()
    private let addInvoiceButton = UIButton()
    private let rootStackView = UIStackView()
    var tapAction: ((UITableViewCell) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bodyText = """
        🌩
        Check out your Lightning Invoices
        - or -
        Add a new Lightning Invoice
        """
        
        self.bodyLabel
            |> baseTextStyle
            <> title3TextStyle
            <> { $0.textAlignment = .center }
            <> { $0.text = bodyText }
        
        self.addInvoiceButton
            |> unfilledButtonStyle
            <> { $0.setTitle("Add an Invoice", for: .normal) }
        
        self.addInvoiceButton.addTarget(
            self,
            action: #selector(tappedInvoiceCreate),
            for: .touchUpInside
        )
        
        self.rootStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(12) }
            <> baseLayoutMarginsStyle
            <> centerStackViewStyle
            <> { $0.addArrangedSubview(self.bodyLabel) }
            <> { $0.addArrangedSubview(self.addInvoiceButton) }
        
        self.contentView
            |> { $0.addSubview(self.rootStackView) }
        
        self
            |> { $0.selectionStyle = .none }
            <> { $0.contentView.layoutMargins = .init(top: .mr_grid(12), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6)) }
        
        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.rootStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.rootStackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            ])
        
    }
    
    @objc func tappedInvoiceCreate() {
        tapAction?(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class InvoiceInfoCell: UITableViewCell {
    private let sequenceAndDateLabel = UILabel()
    private let sequenceAndDateStackView = UIStackView()
    private let memoLabel = UILabel()
    private let memoStackView = UIStackView()
    private let amountLabel = UILabel()
    private let amountStackView = UIStackView()
    private let rootStackView = UIStackView()
    private let lightningImageView = UIImageView(image: UIImage(named: "lightning"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sequenceAndDateLabel
            |> smallCapsTextStyle
            <> { $0.numberOfLines = 0 }
        
        self.sequenceAndDateStackView
            |> horizontalStackViewStyle
            <> { $0.spacing = .mr_grid(2) }
            <> { $0.addArrangedSubview(self.sequenceAndDateLabel) }
        
        self.memoLabel
            |> title3TextStyle
            <> { $0.numberOfLines = 0 }
        
        self.memoStackView
            |> horizontalStackViewStyle
            <> { $0.spacing = .mr_grid(1) }
            <> { $0.addArrangedSubview(self.memoLabel) }
        
        self.amountLabel
            |> subheadlineTextStyle
        
        self.amountStackView
            |> horizontalStackViewStyle
            <> { $0.spacing = .mr_grid(1) }
            <> { $0.addArrangedSubview(self.lightningImageView) }
            <> { $0.addArrangedSubview(self.amountLabel) }
        
        self.rootStackView
            |> verticalStackViewStyle
            <> { $0.spacing = .mr_grid(2) }
            <> { $0.alignment = .leading }
            <> mediumLayoutMarginsStyle
            <> { $0.addArrangedSubview(self.sequenceAndDateStackView) }
            <> { $0.addArrangedSubview(self.memoStackView) }
            <> { $0.addArrangedSubview(self.amountStackView) }
        
        self.contentView
            |> { $0.addSubview(self.rootStackView) }
        
        self
            |> { $0.selectionStyle = .none }
        
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
    
    func configure(with invoice: Invoice) {
        self.memoLabel.text = "\(invoice.memo ?? "")"
        self.amountLabel.text = "\(invoice.value)"
        
        let creationDate = invoice.creationDate
        let cDDouble = Double(creationDate)
        let dr = Date(timeIntervalSince1970: cDDouble)
        let formattedDate = mrDateFormatter.string(from: dr)
        let invoiceState = InvoiceState(state: invoice.state).invoiceState
        self.sequenceAndDateLabel.text = "Creation date: \(formattedDate) • Invoice state: \(invoiceState)"

        // Do I want to make the call for invoices here?
    }
    
}
