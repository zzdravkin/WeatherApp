//
//  ForecastViewController.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import RealmSwift
import UIKit

class ForecastViewController: UIViewController {
    var weatherVM = WeatherViewModel()
    var woeid: Int
    
    var consolidatedWeather = List<ConsolidatedWeatherModel>()
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var mainImage: UIImageView!
    @IBOutlet private var applicableDate: UILabel!
    @IBOutlet private var titleCity: UILabel!
    
    // Dependency Injection with init
    init?(coder: NSCoder, woeid: Int) {
        self.woeid = woeid
        super.init(coder: coder)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("You must create this view controller with woeid.")
    }
    
    override func viewWillAppear(_: Bool) {
        fetchData()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData() {
        let spinner = SpinnerViewController()
        spinnerIndicator(child: spinner, add: true)
        weatherVM.fetchPrimaryData(woeid) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(weatherData):
                self.spinnerIndicator(child: spinner, add: false)
                self.consolidatedWeather = weatherData.consolidatedWeather
                self.updateTodayData()
                self.tableView.reloadData()
            case .failure(let error):
                let alert = self.setupAlert(alertText: "Error", alertMessage: error.errorDescriptionCustom)
                self.present(alert, animated: true)
            }
        }
    }
    
    private func updateTodayData() {
        if let todayInfo = consolidatedWeather.first {
            mainImage.urlImageWithPlaceholder(imageAbbr: todayInfo.weatherStateAbbr)
            applicableDate.text = todayInfo.applicableDate
            titleCity.text = todayInfo.weatherStateName
        }
    }
    
    deinit {
        debugPrint("\(self) deinit")
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: VCIdentifiers.dayInformationsVC, creator: { coder in
            DayInformationsViewController(coder: coder, data: self.consolidatedWeather[indexPath.row])
        }) else {
            fatalError("Failed to load ForecastViewController from storyboard.")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return consolidatedWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.forecastCell, for: indexPath as IndexPath)
        
        if let data = consolidatedWeather[indexPath.row].applicableDate {
            cell.imageView?.urlImageWithPlaceholder(imageAbbr: consolidatedWeather[indexPath.row].weatherStateAbbr)
            cell.textLabel!.text = data
        }
        return cell
    }
}
