//
//  Uzanti+UIStackView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit



extension UIStackView {
    
    
    @discardableResult
    func withMarging(_ margin : UIEdgeInsets) -> UIStackView {
        layoutMargins = margin
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    func padTop(_ top : CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    func padBottom(_ bottom : CGFloat) -> UIStackView {
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
        
    }
    
    @discardableResult
    func padRight(_ right : CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
    
    
    @discardableResult
    func padLeft(_ left  : CGFloat) -> UIStackView {
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    
    
}
