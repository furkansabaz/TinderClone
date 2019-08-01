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
            bitisPanAnimasyon()
            
            
        default :
            break
        }
        
    }
    
    fileprivate func bitisPanAnimasyon() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (_) in
            
        }
    }
    
    fileprivate func degisiklikPanYakala(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
