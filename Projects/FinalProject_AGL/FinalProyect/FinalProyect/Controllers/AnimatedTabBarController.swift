//
//  AnimatedTabBarController.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/26/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//
//https://medium.com/@werry_paxman/bring-your-uitabbar-to-life-animating-uitabbaritem-images-with-swift-and-coregraphics-d3be75eb8d4d



import UIKit

class AnimatedTabBarController: UITabBarController {

    var secondItemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let secondItemView = self.tabBar.subviews[1]
        self.secondItemImageView = secondItemView.subviews.first as! UIImageView
        self.secondItemImageView.contentMode = .center
        
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 2{
            self.secondItemImageView.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.secondItemImageView.transform = rotation
                
            }, completion: nil)
            UIView.animate(withDuration: 0.7, delay: 0.45, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                let rotation = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
                self.secondItemImageView.transform = rotation
                
            }, completion: nil)
            
            
        }
    }



}
