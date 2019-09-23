//
//  ImageViewAspectFill.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit

class ImageViewAspectFill : UIImageView {
    convenience init() {
        
        self.init(image: nil)
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    
}
