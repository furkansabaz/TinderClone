//
//  EslesmeHeader.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 28.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit
class EslesmeHeader  : UICollectionReusableView {
    let lblYeniEslesmeler = UILabel(text: "Yeni Eşleşmeler", font: .boldSystemFont(ofSize: 19), textColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1))
    let eslesmelerYatayController = EslesmelerYatayController()
    let lblMesajlar = UILabel(text: "Mesajlar", font: .boldSystemFont(ofSize: 19), textColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
        stackViewOlustur(stackViewOlustur(lblYeniEslesmeler).padLeft(22),
                         eslesmelerYatayController.view,
                         stackViewOlustur(lblMesajlar).padLeft(22),
                         spacing: 22).withMarging(.init(top: 22, left: 0, bottom: 5, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
