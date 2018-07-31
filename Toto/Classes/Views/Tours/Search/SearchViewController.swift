//
//  SearchViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import AMTextFieldPickerExtension

enum FieldType {
    case duration
    case departure
    case destination
}

class SearchViewController: UIViewController {

    @IBOutlet var tfDuration: SkyFloatingLabelTextField!
    @IBOutlet var tfDeparture: SkyFloatingLabelTextField!
    @IBOutlet var tfDestination: SkyFloatingLabelTextField!
    @IBOutlet var btnSearch: UIButton!
    
    var pickerView: UIPickerView?
    
    var data: [FieldType: [String: String]] = [
        .duration: [
            "1 day": "1",
            "2 days 1 nights": "2",
            "3 days 2 nights": "3",
            "4 days 3 nights": "4",
            "5 days 4 nights": "5"
        ],
        .departure: [
            "New Your": "1",
            "Paris": "2",
            "Tokyo": "3",
            "Ha Noi": "4"
        ],
        .destination: [
            "Egypt": "16",
            "London": "17",
            "Istanbul": "18",
            "Paris": "19"
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        title = localizedString(forKey: "title_search")
        
        tfDuration.delegate = self
        tfDeparture.delegate = self
        tfDestination.delegate = self
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
    }
    
    @IBAction func btnSearchClicked() {
        displayLoading()
        HttpService.shared.search(duration: data[.duration]?[tfDuration.text ?? ""],
                                  departure: data[.departure]?[tfDeparture.text ?? ""],
                                  destination: data[.destination]?[tfDestination.text ?? ""]) { [weak self] (tours, error) in
                                    
                                    guard let `self` = self else { return }
                                    self.hideLoading()
                                    if let tours = tours?.list, tours.count > 0 {
                                        self.showTours(tours)
                                    } else {
                                        self.showToast("No result is found")
                                    }
        }
    }
    
    func showTours(_ tours: [Tour]) {
        let category = Category()
        category.tours = tours
        let controller = storyboard?.instantiateViewController(withIdentifier: "ToursViewController") as! ToursViewController
        controller.title = localizedString(forKey: "title_search")
        controller.data = [category]
        controller.showAll = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.pickerView = pickerView
        textField.showPickerClearButton = true
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.pickerView?.reloadAllComponents()
    }
}

extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func getFieldType() -> FieldType? {
        if tfDuration.isFirstResponder {
            return .duration
        }
        if tfDeparture.isFirstResponder {
            return .departure
        }
        if tfDestination.isFirstResponder {
            return .destination
        }
        return nil
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if let _ = getFieldType() {
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let type = getFieldType() {
            return data[type]!.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let type = getFieldType() {
            let keys = data[type]!.keys.sorted()
            return keys[row]
        }
        return nil
    }
}
