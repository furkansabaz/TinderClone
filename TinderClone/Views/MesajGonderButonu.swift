//
//  MesajGonderButonu.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class MesajGonderButonu : UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gLayer = CAGradientLayer()
        let baslangicRenk = #colorLiteral(red: 0.9484000802, green: 0.1511048377, blue: 0.4636765718, alpha: 1)
        let bitisRenk = #colorLiteral(red: 0.9971984029, green: 0.4618438482, blue: 0.3304074407, alpha: 1)
        gLayer.colors = [baslangicRenk.cgColor, bitisRenk.cgColor]
        
        gLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gLayer.endPoint = CGPoint(x: 1, y: 0.5)
        //self.layer.addSublayer(gLayer)
        self.layer.insertSublayer(gLayer, at: 0)
        self.layer.cornerRadius = rect.height / 2
        clipsToBounds = true
        gLayer.frame = rect
        
    }
    
    
}
