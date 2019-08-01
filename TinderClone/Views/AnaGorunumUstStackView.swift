//
//  AnaGorunumUstStackView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 1.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class AnaGorunumUstStackView: UIStackView {

    let imgAlev = UIImageView(image: #imageLiteral(resourceName: "alev"))
    let btnMesaj = UIButton(type: .system)
    let btnAyarlar = UIButton(type: .system)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgAlev.contentMode = .scaleAspectFit
        
        btnMesaj.setImage( #imageLiteral(resourceName: "mesaj").withRenderingMode(.alwaysOriginal), for: .normal)
        btnAyarlar.setImage( #imageLiteral(resourceName: "profil").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [btnAyarlar, UIView() ,imgAlev, UIView() ,btnMesaj].forEach { (b) in
            addArrangedSubview(b)
            
        }
        distribution = .equalCentering
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 18, bottom: 0, right: 18)
        
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
