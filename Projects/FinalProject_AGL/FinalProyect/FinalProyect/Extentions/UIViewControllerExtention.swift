//
//  UIViewControllerExtention.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/18/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func configureBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppConfig.ThemeFontColor
    }
    
    func configureRightButtonStyle() {
        navigationItem.rightBarButtonItem?.tintColor = AppConfig.ThemeFontColor
    }
    func configureLeftButtonStyle() {
        navigationItem.leftBarButtonItem?.tintColor = AppConfig.ThemeFontColor
    }
    func applyNavigationShadow() {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }
}
