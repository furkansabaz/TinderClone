//
//  OzelTextField.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 5.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class OzelTextField : UITextField {
    
    
    let padding : CGFloat
     init(padding : CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
}
