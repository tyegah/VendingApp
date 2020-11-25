//
//  FirstViewAdapter.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation

final class FirstViewAdapter:FirstView {
    private weak var controller: FirstViewController?
    
    init(controller: FirstViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: NoteViewModel) {
        controller?.display(viewModel)
    }
    
    func display(_ viewModel: DispensedItemViewModel) {
        controller?.display(viewModel)
    }
    
    func display(_ viewModel: VendingItemViewModel) {
        controller?.display(viewModel)
    }
    
    
}
