//
//  WeatherReportViewController.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import GooglePlaces

class WeatherReportViewController: UIViewController, UISearchBarDelegate, WeatherReportViewProtocol {
    
    var userName: String?
    var weatherReportViewModel = WeatherReportViewModel()
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var autoSuggestTableView: UITableView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherForeCastHolderView: UIView!
    @IBOutlet weak var weatherForeCastInfoTableView: UITableView!
    @IBOutlet weak var weatherForeCastCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherReportViewModel.delegate = self
        searchbar.placeholder = "Hi \(userName ?? ""), please enter city name here"
        self.autoSuggestTableView.isHidden = true
        
        self.weatherForeCastHolderView.layer.cornerRadius = 5.0
        self.weatherForeCastHolderView.layer.borderWidth = 1.0
        self.weatherForeCastHolderView.layer.borderColor = UIColor(displayP3Red: 229/255.0, green: 173/255.0, blue: 40/255.0, alpha: 1.0).cgColor
    }
     
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            self.weatherForeCastHolderView.isHidden = true
            CustomLoader.instance.showLoaderView()
            weatherReportViewModel.makeAPICalltoGetAutoSuggestion(input: searchText)
        }
        else {
            self.autoSuggestTableView.isHidden = true
        }
    }
    
    func updateAutoSuggestTable() {
        DispatchQueue.main.async {
            CustomLoader.instance.hideLoaderView()
            self.autoSuggestTableView.isHidden = false
            self.autoSuggestTableView.reloadData()
        }
    }
    
    func updateWeatherForeCasting() {
        DispatchQueue.main.async {
            CustomLoader.instance.hideLoaderView()
            self.autoSuggestTableView.isHidden = true
            self.weatherForeCastHolderView.isHidden = false
            self.weatherForeCastInfoTableView.reloadData()
        }
        self.weatherReportViewModel.makeWebServiceCalltoForeCastforSelectedCity()
    }
    
    func updateFollowedbyWeatherCasting() {
        DispatchQueue.main.async {
            self.weatherForeCastCollectionView.reloadData()
        }
    }
}

extension WeatherReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.autoSuggestTableView {
            return self.weatherReportViewModel.getNumberofSuggestionCount()
        }
        else {
            return self.weatherReportViewModel.foreCastOrder.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.autoSuggestTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutoSuggestCell", for: indexPath) as? AutoSuggestTableViewCell
            cell?.configureCellWith(model: self.weatherReportViewModel.getPredictionModelfor(index: indexPath.row))
            return cell ?? UITableViewCell()
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? WeatherMessageCell
            cell?.configureMessageCellWith(mdl: self.weatherReportViewModel.getDetailsForForeCastwith(index: indexPath.row))
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.autoSuggestTableView {
            CustomLoader.instance.showLoaderView()
            let placeMdl = self.weatherReportViewModel.getPredictionModelfor(index: indexPath.row)
            self.weatherReportViewModel.GetPlaceDataByPlaceID(placeID: placeMdl.place_id ?? "")
            self.autoSuggestTableView.isHidden = true
            self.weatherReportViewModel.selectedCityInfo = placeMdl.description ?? ""
        }
    }
}

extension WeatherReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherReportViewModel.getNumberofWeatherForecastList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForeCastCVCell", for: indexPath) as! ForeCastCVCell
        let mdl = self.weatherReportViewModel.getCityWeatherForeCastfor(index: indexPath.row)
        

        cell.configureForeCastingDetailsinCell(dateStr: self.weatherReportViewModel.convertEpochValuetoDateString(val: mdl.dt!), timeStr: self.weatherReportViewModel.convertEpochValuetoTimeString(val: mdl.dt!), iconPath: mdl.weather?.last?.icon ?? "")
        
        cell.layer.borderColor = UIColor(displayP3Red: 229/255.0, green: 173/255.0, blue: 40/255.0, alpha: 1.0).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        return cell
    }
    
    
}
