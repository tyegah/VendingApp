//
//  WeakRefVirtualProxy.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: ErrorView where T: ErrorView {
    func display(_ viewModel: ErrorViewModel) {
        object?.display(viewModel)
    }
}
