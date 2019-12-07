//
//  AppAppearenceHelper.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 24/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class AppAppearanceHelper {
    
    class func setupAppearance(window : UIWindow? = nil) {
        var appWindow : UIWindow? = window
        if window == nil {
            guard let keyWindow = UIApplication.shared.keyWindow else {
                return
            }
            appWindow = keyWindow
        }
        
        UINavigationBar.appearance().barTintColor = .toolBar
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.titleFont]
        UINavigationBar.appearance().isTranslucent = false
    }
}
