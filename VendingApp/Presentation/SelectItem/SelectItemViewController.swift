//
//  SelectItemViewController.swift
//  VendingApp
//
//  Created by UN A on 14/11/20.
//

import UIKit

class SelectItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSelect(_ sender: UIButton) {
        NotificationCenter.default.post(name: .didSelectItem, object: self, userInfo: ["id":sender.tag+1])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
