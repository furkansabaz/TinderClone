//
//  AnaGorunumAltStackView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class AnaGorunumAltStackView: UIStackView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let altSubView = [#imageLiteral(resourceName: "yenile"),#imageLiteral(resourceName: "kapat"),#imageLiteral(resourceName: "superLike"),#imageLiteral(resourceName: "like"),#imageLiteral(resourceName: "boost")].map { (goruntu) -> UIView in
            let buton = UIButton(type: .system)
            buton.setImage(goruntu.withRenderingMode(.alwaysOriginal), for: .normal)
            return buton
            
        }
        
        
        
        altSubView.forEach { (v) in
            addArrangedSubview(v)
        }
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) eklenmedi")
    }

}
