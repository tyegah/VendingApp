//
//  FirstView.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation

public struct NoteViewModel {
    let note:Int
}

public struct VendingItemViewModel {
    let price:Int
    let name:String
}

public struct TotalChangeViewModel {
    let change:String
}

public struct DispensedItemViewModel {
    let name:String
    let price:Int
    let change:TotalChangeViewModel
}

public struct ErrorViewModel {
    let message:String
}

public protocol FirstView {
    func display(_ viewModel:NoteViewModel)
    func display(_ viewModel:VendingItemViewModel)
    func display(_ viewModel:DispensedItemViewModel)
}

public protocol ErrorView {
    func display(_ viewModel:ErrorViewModel)
}


final class ErrorMapper {
    private init() {}
    
    static func map(_ error:Error, defaultMessage:String = "Unexpected error occured") -> String {
        switch error {
        case AppError.insufficientBalance:
            return "Insufficient Balance"
        case AppError.itemOutOfStock:
            return "Item is out of stock"
        default:
            return defaultMessage
        }
    }
}
