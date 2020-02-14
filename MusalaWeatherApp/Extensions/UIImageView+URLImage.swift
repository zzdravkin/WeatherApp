//
//  UIImageView+URLImage.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/13/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func urlImageWithPlaceholder(imageAbbr: String) {
        sd_setImage(with: URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(imageAbbr).png"), placeholderImage: UIImage(named: "placeholderWeatherImage.png"))
    }
}
