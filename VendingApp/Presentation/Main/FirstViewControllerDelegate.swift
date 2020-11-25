//
//  FirstViewControllerDelegate.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation

public protocol FirstViewControllerDelegate {
    func insertNote(_ note:Int)
    func didSelectItem(_ itemId:Int)
    func makeTransaction()
    func cancelTransaction()
}
