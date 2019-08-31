//
//  GezinmeyiSurdurButonu.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit


class GezinmeyiSurdurButonu : UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gLayer = CAGradientLayer()
        let baslangicRenk = #colorLiteral(red: 0.9484000802, green: 0.1511048377, blue: 0.4636765718, alpha: 1)
        let bitisRenk = #colorLiteral(red: 0.9971984029, green: 0.4618438482, blue: 0.3304074407, alpha: 1)
        gLayer.colors = [baslangicRenk.cgColor, bitisRenk.cgColor]
        
        gLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let cornerRad = rect.height / 2
        
        let maskLayer = CAShapeLayer()
        let maskPath = CGMutablePath()
        
        maskPath.addPath(UIBezierPath(roundedRect: rect, cornerRadius: cornerRad).cgPath)
        maskPath.addPath(UIBezierPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerRadius: cornerRad).cgPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = maskPath
        
        gLayer.mask = maskLayer
        
        self.layer.insertSublayer(gLayer, at: 0)
        self.layer.cornerRadius = cornerRad
        clipsToBounds = true
        gLayer.frame = rect
        
    }
    
}
