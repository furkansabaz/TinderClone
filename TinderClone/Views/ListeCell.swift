//
//  ListeCell.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit


open class ListeCell<T> : UICollectionViewCell {
    
    var veri : T!
    
    var eklenecekController : UIViewController?
    
    public let ayracView = UIView(arkaPlanRenk: UIColor(white: 0.65, alpha: 0.55))
    
    func ayracEkle(solBosluk : CGFloat = 0) {
        addSubview(ayracView)
        
        ayracView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: solBosluk, bottom: 0, right: 0), boyut: .init(width: 0, height: 0.5))
    }
    
    func ayracEkle(leadingAnchor : NSLayoutXAxisAnchor) {
        addSubview(ayracView)
        ayracView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,  boyut: .init(width: 0, height: 0.5))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
