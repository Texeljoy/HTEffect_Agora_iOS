//
//  ThirdBeautify.swift
//  APIExample
//
//  Created by zhaoyongqiang on 2022/10/21.
//  Copyright © 2022 Agora Corp. All rights reserved.
//

import UIKit

enum ThirdBeautifyType: String {
    case htEffect = "HTEffectBeautify"
}

class ThirdBeautifyEntry: UIViewController {

    @IBOutlet weak var channelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapJoinChannle(_ sender: Any) {
        if let text = channelTextField.text, text.isEmpty {
            return
        }
        //resign channel text field
        channelTextField.resignFirstResponder()
        
        let actionSheetVC = UIAlertController(title: "Third Beautify".localized, message: nil, preferredStyle: .actionSheet)
        
        let htEffect = UIAlertAction(title: "HT Effect".localized, style: .default) { _ in
            self.jumpHandler(type: .htEffect)
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        actionSheetVC.addAction(htEffect)
        actionSheetVC.addAction(cancel)
        present(actionSheetVC, animated: true, completion: nil)
    }
    
    private func jumpHandler(type: ThirdBeautifyType) {
        guard let channelName = channelTextField.text else {return}
        let storyBoard: UIStoryboard = UIStoryboard(name: type.rawValue, bundle: nil)
        // create new view controller every time to ensure we get a clean vc
        let newViewController = storyBoard.instantiateViewController(withIdentifier: type.rawValue)
        newViewController.title = channelName
//        newViewController.configs = ["channelName":channelName]
        navigationController?.pushViewController(newViewController, animated: true)
    }
}
