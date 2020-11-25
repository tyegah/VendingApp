//
//  InsertNoteViewController.swift
//  VendingApp
//
//  Created by UN A on 14/11/20.
//

import UIKit

class InsertNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSelect(_ sender: UIButton) {
        let note:Int = dispensableNotes[sender.tag]
        NotificationCenter.default.post(name: .didInsertNote, object: self, userInfo: ["note":note])
        dismiss(animated: true, completion: nil)
    }
}
