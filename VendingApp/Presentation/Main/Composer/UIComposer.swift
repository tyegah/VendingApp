//
//  UIComposer.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import Foundation
import UIKit

public final class FirstUIComposer {
    private init() {}
    
    public static func composedWith(engine: Vending) -> FirstViewController {
        let presentationAdapter = FirstViewPresentationAdapter(engine: engine)
        
        let controller = makeViewController(
            delegate: presentationAdapter)

        presentationAdapter.presenter = FirstViewPresenter(
            view: FirstViewAdapter(
                controller: controller),
            errorView: WeakRefVirtualProxy(controller))
        
        return controller
    }

    private static func makeViewController(delegate: FirstViewControllerDelegate) -> FirstViewController {
        let bundle = Bundle(for: FirstViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier:"FirstViewController") as! FirstViewController
        viewController.delegate = delegate
        return viewController
    }
}
