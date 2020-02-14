//
//  UIViewController+Alert.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/13/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setupAlert(alertText: String, alertMessage: String) -> UIAlertController {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        return alert
    }
}
