//
//  VendingEngine.swift
//  VendingApp
//
//  Created by UN A on 14/11/20.
//

import Foundation

let biskuit = VendingItem(id: 1,name: "Biskuit", price: 6000)
let chips = VendingItem(id: 2,name: "Chips", price: 8000)
let oreo = VendingItem(id: 3,name: "Oreo", price: 10000)
let tango = VendingItem(id: 4,name: "Tango", price: 12000)
let cokelat = VendingItem(id: 5,name: "Cokelat", price: 15000)

let items = [biskuit, chips, oreo, tango, cokelat]

protocol Changeable {
    func handleChange(_ change:Int) -> TotalChange
}

public final class ChangeCalculator:Changeable {
    func handleChange(_ change: Int) -> TotalChange {
        var totalChange = change
        var changes = [Change]()
        dispensableNotes.forEach { note in
            let resultCount = calculateChange(for: note, totalChange: totalChange)
            totalChange = totalChange - (resultCount * note)
            changes.append(Change(note: note, count: resultCount))
        }
    
        return TotalChange(changes: changes, total: change)
    }
    
    private func calculateChange(for note:Int, totalChange:Int) -> Int {
        if totalChange >= note {
            let modulo = totalChange%note
            if isModuloDividable(modulo: modulo, currentNote: note) {
                return (1 + calculateChange(for: note, totalChange: totalChange - note))
            }
        }
        return 0
    }
    
    private func isModuloDividable(modulo:Int, currentNote:Int) -> Bool {
        var result:Bool = false
        for note in dispensableNotes {
            if note <= currentNote {
                result = (modulo%note == 0)
            }
        }
        return result
    }
}

public final class VendingEngine:Vending {
    private let changeHandler:Changeable
    private var snacks:[VendingItemStock]
    private var totalCash:Int = 0
    
    init(changeHandler:Changeable) {
        self.changeHandler = changeHandler
        self.snacks = items.map { VendingItemStock(item: $0) }
    }
    
    public func insertNote(_ note:Int) -> Int {
        totalCash = totalCash + note
        return totalCash
    }
    
    public func selectItem(_ itemId: Int) -> VendingItem {
        let snack = snacks.first { (snack) -> Bool in
            return snack.item.id == itemId
        }
        
        return snack!.item
    }
    
    public func makeTransaction(for itemId:Int) -> Vending.Result {
        let snack = snacks.first { (snack) -> Bool in
            return snack.item.id == itemId
        }
        
        if snack == nil {
            return .failure(AppError.unexpectedError)
        }
        
        let change = totalCash - snack!.item.price
        if snack!.isAvailable {
            if change >= 0 {
                snack!.updateStock(-1)
                reset()
                return .success(DispensedItem(item: snack!.item,
                                              change: changeHandler.handleChange(change)))
            }
            else {
                return .failure(AppError.insufficientBalance)
            }
        }
        
        return .failure(AppError.itemOutOfStock)
    }
    
    public func cancelTransaction() {
        reset()
    }
    
    private func reset() {
        totalCash = 0
    }
}
