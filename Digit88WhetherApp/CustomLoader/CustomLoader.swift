//
//  CustomLoader.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class CustomLoader: UIView {
    
    static let instance = CustomLoader()
    
    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.5
    var gifName: String = ""
    var loadingCounter = 0
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: gifName)
        return gifImage
    }()
    
    func showLoaderView() {
        loadingCounter += 1
        if loadingCounter == 1 {
            self.addSubview(self.transparentView)
            self.transparentView.addSubview(self.gifImage)
            self.transparentView.bringSubviewToFront(self.gifImage)
            UIApplication.shared.keyWindow?.addSubview(transparentView)
        }        
    }
    
    func hideLoaderView() {
        loadingCounter -= 1
        if loadingCounter == 0 {
        self.transparentView.removeFromSuperview()
        }
    }
    
}
