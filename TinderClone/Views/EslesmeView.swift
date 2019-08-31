//
//  EslesmeView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class EslesmeView : UIView {
    
    fileprivate let imgGecerliKullanici : UIImageView = {
       let img = UIImageView(image: #imageLiteral(resourceName: "kisi4"))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 2
        return img
    }()
    fileprivate let imgKarsiProfil : UIImageView = {
       let img = UIImageView(image: #imageLiteral(resourceName: "kisi5"))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 2
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        blurEfektEkle()
        duzenleLayout()
    }
    
    fileprivate func duzenleLayout() {
        
        addSubview(imgGecerliKullanici)
        addSubview(imgKarsiProfil)
        let goruntuBoyut : CGFloat = 135
        _ = imgGecerliKullanici.anchor(top: nil, bottom: nil, leading: nil, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), boyut: .init(width: goruntuBoyut, height: goruntuBoyut))
        
        imgGecerliKullanici.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        imgGecerliKullanici.layer.cornerRadius = goruntuBoyut / 2
        
        _ = imgKarsiProfil.anchor(top: nil, bottom: nil, leading: centerXAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), boyut: .init(width: goruntuBoyut, height: goruntuBoyut))
        imgKarsiProfil.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgKarsiProfil.layer.cornerRadius = goruntuBoyut / 2
        
        
    }
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate func blurEfektEkle() {
        
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureEslesme)))
        addSubview(visualEffectView)
        visualEffectView.doldurSuperView()
        
        visualEffectView.alpha = 0
        
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        }) { (_) in
            
        }
    }
    
    
    @objc fileprivate func tapGestureEslesme() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
