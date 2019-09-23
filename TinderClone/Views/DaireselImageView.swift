//
//  DaireselImageView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit


open class DaireselImageView : UIImageView {
    public  init(genislik : CGFloat, image: UIImage? = nil) {
        super.init(image : image)
        
        contentMode = .scaleAspectFill
        
        if genislik != 0 {
            widthAnchor.constraint(equalToConstant: genislik).isActive = true
        }
        
        heightAnchor.constraint(equalToConstant: genislik).isActive = true
        clipsToBounds = true
    }
    
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
   
    
    }

    
    
    
