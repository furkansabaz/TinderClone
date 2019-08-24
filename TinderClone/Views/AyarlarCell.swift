//
//  AyarlarCell.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 24.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class AyarlarCell: UITableViewCell {

    
    class AyarlarTextField : UITextField {
        
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 25, dy: 0)
        }
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 25, dy: 0)
        }
        
        override var intrinsicContentSize: CGSize {
            return .init(width: 0, height: 45)
        }
    }
    
    let textField : UITextField = {
       let txt = AyarlarTextField()
        txt.placeholder = "Yaşınızı Giriniz"
        return txt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
        textField.doldurSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
