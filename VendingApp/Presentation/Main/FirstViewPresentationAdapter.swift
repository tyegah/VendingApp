//
//  FirstViewPresentationAdapter.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation


final class FirstViewPresentationAdapter:FirstViewControllerDelegate {
    var presenter: FirstViewPresenter?
    private let engine: Vending
    private var selectedItemId:Int = 0
    
    init(engine:Vending) {
        self.engine = engine
    }
    
    func insertNote(_ note: Int) {
        let result = engine.insertNote(note)
        presenter?.didInsertNote(NoteViewModel(note: result))
    }
    
    func didSelectItem(_ itemId: Int) {
        selectedItemId = itemId
        let result = engine.selectItem(itemId)
        presenter?.didSelectItem(VendingItemViewModel(price: result.price, name: result.name))
    }
    
    func makeTransaction() {
        if selectedItemId == 0 {
            return
        }
        
        let result = engine.makeTransaction(for: selectedItemId)
        switch result {
        case .success(let data):
            var changeStr = "Total Dispensed Change: \(data.change.total)"
            var changes = data.change.changes
            changes.removeAll { (item) -> Bool in
                return item.count == 0
            }
            
            for change in changes {
                changeStr = changeStr + "\n" + "\(change.note) : \(change.count)"
            }
            debugPrint("CHANGES \(changeStr)")
            presenter?.didMakeTransaction(DispensedItemViewModel(name: data.item.name,
                                                                 price: data.item.price,
                                                                 change: TotalChangeViewModel(change: changeStr)))
        case .failure(let error):
            presenter?.didFailToMakeTransaction(withError:error)
        }
    }
    
    func cancelTransaction() {
        selectedItemId = 0
        engine.cancelTransaction()
    }
    
}
