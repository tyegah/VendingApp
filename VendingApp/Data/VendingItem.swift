//
//  VendingItem.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation

public enum AppError: Swift.Error {
    case insufficientBalance
    case itemOutOfStock
    case unexpectedError
}

public struct TotalChange {
    let changes:[Change]
    let total:Int
}

public struct Change {
    let note:Int
    let count:Int
}

public struct DispensedItem {
    let item:VendingItem
    let change:TotalChange
}

public protocol Vending {
    typealias Result = Swift.Result<DispensedItem, Error>
    func insertNote(_ note:Int) -> Int
    func selectItem(_ itemId:Int) -> VendingItem
    func makeTransaction(for itemId:Int) -> Result
    func cancelTransaction()
}

public struct VendingItem:Equatable {
    let id:Int
    let name:String
    let price:Int
}

public class VendingItemStock {
    let item:VendingItem
    private var stock:Int = 0
    
    init(item:VendingItem, stock:Int = 5) {
        self.item = item
        self.stock = stock
    }
    
    func updateStock(_ value:Int) {
        stock = stock + value
    }
    
    var isAvailable:Bool {
        return stock > 0
    }
}

let dispensableNotes = [50000, 20000, 10000, 5000, 2000, 1000]
