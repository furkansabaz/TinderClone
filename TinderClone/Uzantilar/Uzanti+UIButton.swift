//
//  Uzanti+UIButton.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(baslik : String, baslikRenk : UIColor, baslikFont : UIFont = .systemFont(ofSize: 15), arkaPlanRenk : UIColor = .clear, target : Any? = nil, action: Selector? = nil) {
        
        self.init(type: .system)
        
        setTitle(baslik, for: .normal)
        
        setTitleColor(baslikRenk, for: .normal)
        
        self.titleLabel?.font = baslikFont
        self.backgroundColor = arkaPlanRenk
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    convenience init(image : UIImage, tintColor : UIColor? = nil, target : Any? = nil, action : Selector? = nil) {
        self.init(type: .system)
        
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
}
