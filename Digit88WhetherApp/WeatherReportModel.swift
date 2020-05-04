//
//  WeatherReportModel.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

struct WeatherReportModel: Codable {
    var coord: CoordinateModel?
    var weather: [WeatherDetail]?
    var base: String?
    var main: TemperatureDetails?
    var visibility: Int?
    var wind: WindDetails?
    var dt: Int64?
    var sys: SunRiseDetails?
    var timezone: Int64?
    var name: String?
}

struct CoordinateModel: Codable {
    var lon: Double?
    var lat: Double?
}

struct WeatherDetail: Codable {
    var main: String?
    var description: String?
    var icon: String?
}

struct TemperatureDetails: Codable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Float?
    var humidity: Float?
}

struct WindDetails: Codable {
    var speed: Float?
    var deg: Int?
}

struct SunRiseDetails: Codable {
    var sunrise: Int64?
    var sunset: Int64?
    var country: String?
}
