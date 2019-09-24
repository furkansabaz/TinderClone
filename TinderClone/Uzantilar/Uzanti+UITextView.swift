//
//  Uzanti+UITextView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit


extension UITextView {
    
    convenience init(text: String?, font : UIFont? = UIFont.systemFont(ofSize: 15), textColor : UIColor = .black, textAlignment : NSTextAlignment = .left) {
        
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
