//
//  UIViewController.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 06.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

extension UIViewController {
    
    func showAlert(with message: String) {
        let title = NSLocalizedString("Sorry", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        present(alert, animated: true)
    }
    
}
