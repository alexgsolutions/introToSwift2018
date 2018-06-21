//
//  EmptyView.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 6/11/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    var view: UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        //backgroundColor = .clear
        
        view = loadViewFromNib()
//                view.frame = bounds
//                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EmptyView", bundle: bundle)
        let myView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return myView
    }

}
