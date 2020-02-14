//
//  DayInformationsViewController.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import UIKit

// Support screen rotation from Portrait to Landscape

class DayInformationsViewController: UIViewController {
    var dayData: ConsolidatedWeatherModel?

    @IBOutlet var temp: UILabel!
    @IBOutlet var minTemp: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var windDirection: UILabel!
    @IBOutlet var airPresure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var visibility: UILabel!
    @IBOutlet var predictability: UILabel!

    init?(coder: NSCoder, data: ConsolidatedWeatherModel) {
        dayData = data
        super.init(coder: coder)
    }

    required init?(coder _: NSCoder) {
        fatalError("You must create this view controller with woeid.")
    }

    override func viewDidLoad() {
        guard let dayData = dayData else { return }

        title = dayData.applicableDate
        temp.text = String(dayData.theTemp)
        minTemp.text = String(dayData.minTemp)
        maxTemp.text = String(dayData.maxTemp)
        windSpeed.text = String(dayData.windSpeed)
        windDirection.text = String(dayData.windDirection)
        airPresure.text = String(dayData.airPressure)
        humidity.text = String(dayData.humidity)
        visibility.text = String(dayData.visibility)
        predictability.text = String(dayData.predictability)
    }
    
    deinit {
        debugPrint("\(self) deinit")
    }
}
