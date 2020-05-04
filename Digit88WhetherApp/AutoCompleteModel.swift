//
//  AutoCompleteModel.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import Foundation

struct AutoCompleteModel: Codable {
    var predictions: [PredictionModel]?
    var status: String?
}

struct PredictionModel: Codable {
    var description: String?
    var place_id: String?
    var types: [String]?
}


