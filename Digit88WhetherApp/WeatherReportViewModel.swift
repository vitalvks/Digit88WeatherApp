//
//  WeatherReportViewModel.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import GooglePlaces

protocol WeatherReportViewProtocol: class {
    func updateAutoSuggestTable()
    func updateWeatherForeCasting()
    func updateFollowedbyWeatherCasting()
}

class WeatherReportViewModel: NSObject {
    
    var autoSuggestions = [PredictionModel]()
    weak var delegate: WeatherReportViewProtocol?
    var todayForecastDetails: WeatherReportModel?
    var foreCastDetails: ForecastCityModel?
    var selectedCityInfo: String = ""
    
    var foreCastOrder = ["CityName", "Date", "Sunrise", "Sunset", "Windspeed", "Humidity"]
    
    func getNumberofSuggestionCount() -> Int {
        return self.autoSuggestions.count
    }
    
    func getPredictionModelfor(index: Int) -> PredictionModel {
        return self.autoSuggestions[index]
    }
    
    
    func getDetailsForForeCastwith(index: Int) -> ForeCastDisplayModel {
        let val = foreCastOrder[index]
        if val == "CityName" {
            return ForeCastDisplayModel(titleStr: val, valueStr: self.todayForecastDetails?.name ?? "")
        }
        else if val == "Date" {
            return ForeCastDisplayModel(titleStr: val, valueStr: self.convertEpochValuetoDateString(val: self.todayForecastDetails?.dt ?? 0))
        }
        else if val == "Sunrise" {
            return ForeCastDisplayModel(titleStr: val, valueStr: self.convertEpochValuetoTimeString(val: self.todayForecastDetails?.sys?.sunrise ?? 0))
        }
        else if val == "Sunset" {
            return ForeCastDisplayModel(titleStr: val, valueStr: self.convertEpochValuetoTimeString(val: self.todayForecastDetails?.sys?.sunset ?? 0))
        }
        else if val == "Windspeed" {
            return ForeCastDisplayModel(titleStr: val, valueStr: "\(self.todayForecastDetails?.wind?.speed ?? 0) km/hr")
        }
        else if val == "Humidity" {
            return ForeCastDisplayModel(titleStr: val, valueStr: "\(self.todayForecastDetails?.main?.humidity ?? 0)")
        }
        else if val == "Min Temperature" {
            return ForeCastDisplayModel(titleStr: val, valueStr: "\(self.todayForecastDetails?.main?.temp_min ?? 0)")
        }
        else if val == "Max Temperature" {
            return ForeCastDisplayModel(titleStr: val, valueStr: "\(self.todayForecastDetails?.main?.temp_max ?? 0)")
        }
        else {
            return ForeCastDisplayModel(titleStr: "", valueStr: "")
        }
    }
    
    func convertEpochValuetoTimeString(val: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(val))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func convertEpochValuetoDateString(val: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(val))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func getNumberofWeatherForecastList() -> Int {
        return self.foreCastDetails?.list?.count ?? 0
    }
    
    func getCityWeatherForeCastfor(index: Int) -> ForecastModel {
        return self.foreCastDetails?.list?[index] ?? ForecastModel()
    }
}

struct ForeCastDisplayModel {
    var titleStr: String
    var valueStr: String
}


extension WeatherReportViewModel {
    
    func makeAPICalltoGetAutoSuggestion(input: String) {
        let urlToHit = URL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=geocode&language=en&key=AIzaSyAVJLuhUt6Q28ZxAcOMDwzbXshxItsdN3k")
        let task = URLSession.shared.dataTask(with: urlToHit!, completionHandler: {data, response, error -> Void in
           do {
            if error == nil {
                let result = try JSONDecoder().decode(AutoCompleteModel.self, from: data!)
                self.autoSuggestions = result.predictions ?? [PredictionModel]()
                self.delegate?.updateAutoSuggestTable()
            }
           } catch {
               print("Something went wrong")
           }
        })
        task.resume()
    }
    
    func GetPlaceDataByPlaceID(placeID: String)
    {
        if placeID.count > 0 {
            GMSPlacesClient.shared().lookUpPlaceID(placeID, callback: { (place, error) -> Void in

                if let error = error {
                    print("lookup place id query error: \(error.localizedDescription)")
                    return
                }

                if let placeDetails = place {
                    self.getWeatherReportFrom(latitude: placeDetails.coordinate.latitude, longitude: placeDetails.coordinate.longitude)
                } else {
                    print("No place details for \(placeID)")
                }
            })
        }
    }
    
    func getWeatherReportFrom(latitude: Double, longitude: Double) {
        let urlToHit = URL(string: "http://api.openweathermap.org/data/2.5/weather?APPID=224cb508ef1a476b722de2624b95f49f&lat=\(latitude)&lon=\(longitude)")
        let task = URLSession.shared.dataTask(with: urlToHit!, completionHandler: {data, response, error -> Void in
           do {
            if error == nil {
                self.todayForecastDetails = try JSONDecoder().decode(WeatherReportModel.self, from: data!)
                self.delegate?.updateWeatherForeCasting()
            }
           } catch {
               print("Something went wrong")
           }
        })
        task.resume()
    }
    
    func makeWebServiceCalltoForeCastforSelectedCity() {
        let urlToHit = URL(string: "http://api.openweathermap.org/data/2.5/forecast?APPID=224cb508ef1a476b722de2624b95f49f&q=\(selectedCityInfo.replacingOccurrences(of: " ", with: ""))")
        let task = URLSession.shared.dataTask(with: urlToHit!, completionHandler: {data, response, error -> Void in
           do {
            if error == nil {
                self.foreCastDetails = try JSONDecoder().decode(ForecastCityModel.self, from: data!)
                self.delegate?.updateFollowedbyWeatherCasting()
            }
           } catch {
               print("Something went wrong")
           }
        })
        task.resume()
    }
    
}
