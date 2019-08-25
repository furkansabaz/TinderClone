//
//  YasAralikCell.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class YasAralikCell: UITableViewCell {

    
    let minSlider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 90
        return slider
    }()
    
    let maksSlider : UISlider = {
        
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 90
        return slider
    }()
    
    let lblMin : UILabel = {
        
        let lbl = YasAralikLabel()
        lbl.text = "Min 18"
        return lbl
    }()
    let lblMaks : UILabel = {
        
        let lbl = YasAralikLabel()
        lbl.text = "Maks 18"
        return lbl
    }()
    
    class YasAralikLabel : UILabel {
        override var intrinsicContentSize: CGSize {
            return .init(width: 80, height: 0)
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let genelStackView = UIStackView(arrangedSubviews: [
        UIStackView(arrangedSubviews: [lblMin,minSlider]),
        UIStackView(arrangedSubviews: [lblMaks,maksSlider])
        ])
        
        genelStackView.axis = .vertical
        genelStackView.spacing = 16
        
        addSubview(genelStackView)

        _ = genelStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
