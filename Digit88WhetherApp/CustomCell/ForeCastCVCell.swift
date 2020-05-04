//
//  ForeCastCVCell.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class ForeCastCVCell: UICollectionViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    
    func configureForeCastingDetailsinCell(dateStr: String, timeStr: String, iconPath: String) {
        self.dateLbl.text = dateStr
        self.timeLbl.text = timeStr
        DownloadImageUtil.downloadImageFrom(urlStr: iconPath) { (img, err) in
            DispatchQueue.main.async {
                self.iconImg.image = img
            }
        }
        
    }
}
