//
//  UIViewController+Alert.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 17..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(for error: Error, defaultButtonHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
            defaultButtonHandler?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, defaultButtonHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
            defaultButtonHandler?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showGenericAlert(defaultButtonHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Something went wrong. Please try again!", comment: ""), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
            defaultButtonHandler?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
