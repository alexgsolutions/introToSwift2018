//
//  UIViewControllerExtention.swift
//  Homework8_Class
//
//  Created by Alexis Gonzalez on 5/10/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppConfig.appTiltColor
    }
    
    func configureRightButtonStyle() {
        navigationItem.rightBarButtonItem?.tintColor = AppConfig.appTiltColor
    }
}
