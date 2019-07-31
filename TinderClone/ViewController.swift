//
//  ViewController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let subViews = [UIColor.red, UIColor.blue, UIColor.purple].map { (renk) -> UIView in
            
            let v = UIView()
            v.backgroundColor = renk
            return v
        }
        
        
        let ustStackView = UIStackView(arrangedSubviews: subViews)
        ustStackView.distribution = .fillEqually
        
        ustStackView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        let yesilView = UIView()
        yesilView.backgroundColor = .green
        
        let griView = UIView()
        griView.backgroundColor = .darkGray
        griView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [ustStackView, yesilView,griView])
        
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        
        stackView.doldurSuperView()
    }


}

