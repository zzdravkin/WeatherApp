//
//  SpinnerViewController.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/13/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIViewController {
    func spinnerIndicator(child: SpinnerViewController, add: Bool) {
        if add {
            addChild(child)
            child.view.frame = view.frame
            view.addSubview(child.view)
            child.didMove(toParent: self)
        } else {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
