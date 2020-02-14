//
//  ViewController.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/10/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import UIKit

final class CityListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    let cityVM = CityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.reloadData()
        
        //callback for db changes from CityViewModel
        cityVM.monitorDBChanges { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func alertTextField() -> UIAlertController {
        let ac = UIAlertController(title: "Enter woeid of a City", message: "Ex. London - 44418", preferredStyle: .alert)

        ac.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "2487956"
        })
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac, self] _ in
            if let textField = ac.textFields?.first, let woeid = textField.text {
                self.cityVM.addNewCity(Int(woeid) ?? 0, fail: { [weak self] error in
                    guard let self = self else { return }
                    let alert = self.setupAlert(alertText: "Woeid can not be found", alertMessage: error)
                    self.present(alert, animated: true)
                })
            }
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(submitAction)
        return ac
    }
    
    // MARK: - Button Action
    
    @IBAction func addCityButtonTap(_: Any) {
        present(NetworkMonitor.shared.isConnected() ? alertTextField() : setupAlert(alertText: "No Internet",
                                                                                    alertMessage: "Please check your internet connection"),
                animated: true)
    }
    
    deinit {
        debugPrint("\(self) deinit")
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityModel = cityVM.getCityData()[indexPath.row]

        guard let vc = storyboard?.instantiateViewController(identifier: VCIdentifiers.forecastVC, creator: { coder in
            ForecastViewController(coder: coder, woeid: cityModel.woeid)
        }) else {
            fatalError("Failed to load ForecastViewController from storyboard.")
        }

        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return cityVM.getCityData().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cityCell, for: indexPath as IndexPath)
        let cityModel = cityVM.getCityData()[indexPath.row]

        cell.textLabel!.text = cityModel.title
        cell.detailTextLabel?.text = "\(cityModel.woeid)"

        return cell
    }
}
