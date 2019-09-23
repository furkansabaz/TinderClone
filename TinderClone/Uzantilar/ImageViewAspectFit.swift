//
//  ImageViewAspectFit.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import  UIKit


class ImageViewAspectFit : UIImageView {
    
    convenience init(image : UIImage? = nil, cornerRadius : CGFloat = 0 ) {
        self.init(image : image)
        self.layer.cornerRadius = cornerRadius
    }
    
    convenience init() {
        self.init(image: nil)
    }
    
    
    override init(image: UIImage?) {
        super.init(image: image)
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
