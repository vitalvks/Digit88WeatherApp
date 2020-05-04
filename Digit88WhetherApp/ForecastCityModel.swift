//
//  ForecastCityModel.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

struct ForecastCityModel: Codable {
    var list: [ForecastModel]?
}

struct ForecastModel: Codable {
    var dt: Int64?
    var main: TempDetails?
    var weather:[WeatherInfo]?
}

struct TempDetails: Codable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Float?
    var humidity: Float?
}

struct WeatherInfo: Codable {
    var description: String?
    var icon: String?
}
