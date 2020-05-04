//
//  AutoSuggestTableViewCell.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class AutoSuggestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWith(model: PredictionModel) {
        self.placesLbl.text = model.description
    }

}
