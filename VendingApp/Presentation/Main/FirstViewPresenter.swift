//
//  FirstViewPresenter.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation

final class FirstViewPresenter {
    private let view: FirstView
    private let errorView:ErrorView
    
    init(view:FirstView, errorView:ErrorView) {
        self.view = view
        self.errorView = errorView
    }
    
    func didInsertNote(_ note:NoteViewModel) {
        view.display(note)
    }
    
    func didSelectItem(_ item:VendingItemViewModel) {
        view.display(item)
    }
    
    func didMakeTransaction(_ item:DispensedItemViewModel) {
        view.display(item)
    }
    
    func didFailToMakeTransaction(withError error:Error) {
        errorView.display(ErrorViewModel(message:ErrorMapper.map(error)))
    }
}
