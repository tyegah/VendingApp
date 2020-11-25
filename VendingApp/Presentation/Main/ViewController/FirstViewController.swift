//
//  ViewController.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import UIKit

extension Notification.Name {
    static let didInsertNote = Notification.Name("didInsertNote")
    static let didSelectItem = Notification.Name("didSelectItem")
}

public final class FirstViewController: UIViewController {
    var delegate:FirstViewControllerDelegate?
    
    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var totalCashLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidInsertNote(_:)), name: .didInsertNote, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectItem(_:)), name: .didSelectItem, object: nil)
    }
    
    public func display(_ view:NoteViewModel) {
        totalCashLabel.text = "\(view.note)"
    }
    
    public func display(_ viewModel:VendingItemViewModel) {
        itemButton.setTitle("\(viewModel.name) - \(viewModel.price)", for: .normal)
    }
    
    public func display(_ viewModel:DispensedItemViewModel) {
        displaySuccessAlert(viewModel)
    }
    
    private func displaySuccessAlert(_ viewModel:DispensedItemViewModel) {
        let message = "Bought \(viewModel.name) for \(viewModel.price).\n\(viewModel.change.change)"
        let alert = UIAlertController(title: "Transaction Success", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title:"OK", style: .default) { [weak self] _ in
            self?.clear()
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buy(_ sender: Any) {
        delegate?.makeTransaction()
    }
    
    @IBAction func cancel(_ sender: Any) {
       clear()
    }
    
    private func clear() {
        totalCashLabel.text = "0"
        itemButton.setTitle("SELECT ITEM", for: .normal)
        delegate?.cancelTransaction()
    }
    
    @objc func onDidInsertNote(_ notification:Notification) {
        if let data = notification.userInfo as? [String: Int]
        {
            delegate?.insertNote(data["note"] ?? 0)
        }
    }
    
    @objc func onDidSelectItem(_ notification:Notification) {
        if let data = notification.userInfo as? [String: Int]
        {
            delegate?.didSelectItem(data["id"] ?? 0)
        }
    }
}

extension FirstViewController:ErrorView {
    public func display(_ viewModel: ErrorViewModel) {
        let alert = UIAlertController(title: "ERROR", message: viewModel.message, preferredStyle: UIAlertController.Style.alert)

        let cancel = UIAlertAction(title:"OK", style: .default, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

