//
//  DownloadImageUtil.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class DownloadImageUtil {
    
    static func downloadImageFrom(urlStr: String, completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void)  {
        let url = URL(string: "http://openweathermap.org/img/w/" + urlStr + ".png")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                if let data = data {
                    let image: UIImage = UIImage(data:data,scale:1.0)!
                    completionHandler(image, nil)
                }
            }
        }).resume()
    }

}
