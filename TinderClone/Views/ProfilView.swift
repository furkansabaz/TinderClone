//
//  ProfilView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 1.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class ProfilView: UIView {

    
    fileprivate let imgProfil = UIImageView(image:#imageLiteral(resourceName: "kisi1") )
    let sinirDegeri : CGFloat = 120
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        
        addSubview(imgProfil)
        imgProfil.doldurSuperView()
        
        
        let panG = UIPanGestureRecognizer(target: self, action: #selector(profilPanYakala))
        addGestureRecognizer(panG)
    }
    
    
    @objc func profilPanYakala(panGesture : UIPanGestureRecognizer) {
       
        
        
        
        switch panGesture.state {
            
        case .changed :
            degisiklikPanYakala(panGesture)
            
        case .ended :
            bitisPanAnimasyon(panGesture)
            
            
        default :
            break
        }
        
    }
    
    fileprivate func bitisPanAnimasyon(_ panGesture : UIPanGestureRecognizer) {
        
        
        let profilKaybet : Bool =  panGesture.translation(in: nil).x > sinirDegeri
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if profilKaybet {

                
                self.frame = CGRect(x: 1000, y: 0, width: self.frame.width, height: self.frame.height)
                
                
//                let ekranDisiTransform = self.transform.translatedBy(x: 900, y: 0)
//                self.transform = ekranDisiTransform
                
                
            } else {
                self.transform = .identity
            }
            
            
           
        }) { (_) in
            print("Animasyon Bitti. Kart Geri Gelsin")
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
        
        
        
    }
    
    fileprivate func degisiklikPanYakala(_ panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: nil)
        
        let derece : CGFloat = translation.x / 15
        let radyanAci = (derece * .pi) / 180
        
        
        let dondurmeTransform = CGAffineTransform(rotationAngle: radyanAci)
        self.transform = dondurmeTransform.translatedBy(x: translation.x, y: translation.y)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
