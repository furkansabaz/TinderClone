//
//  ProfilView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 1.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class ProfilView: UIView {

    var kullaniciViewModel : KullaniciProfilViewModel! {
        
        didSet {
            imgProfil.image = UIImage(named: kullaniciViewModel.goruntuAdi)
            
            lblKullaniciBilgileri.attributedText = kullaniciViewModel.attrString
            
            lblKullaniciBilgileri.textAlignment = kullaniciViewModel.bilgiKonumu
        }
    }
    
    
   
    fileprivate let imgProfil = UIImageView(image:#imageLiteral(resourceName: "kisi1") )
    fileprivate let gradientLayer = CAGradientLayer()
    let lblKullaniciBilgileri = UILabel()
    fileprivate let sinirDegeri : CGFloat = 120
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imgProfil.contentMode = .scaleAspectFill
        
        addSubview(imgProfil)
        imgProfil.doldurSuperView()
        
        
        olusturGradientLayer()
        
        addSubview(lblKullaniciBilgileri)
        
        lblKullaniciBilgileri.anchor(top: nil,
                                     bottom: bottomAnchor,
                                     leading: leadingAnchor,
                                     trailing: trailingAnchor,
                                     padding: .init(top: 0, left: 15, bottom: 15, right: 15))
        
        
        
        lblKullaniciBilgileri.textColor = .white
        lblKullaniciBilgileri.numberOfLines = 0
        
        
        let panG = UIPanGestureRecognizer(target: self, action: #selector(profilPanYakala))
        addGestureRecognizer(panG)
    }
    
    
    fileprivate func olusturGradientLayer() {
        
        
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        gradientLayer.locations = [0.4,1.2]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        
        layer.addSublayer(gradientLayer)
        
    }
    
    
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
        
    }
    
    
    @objc func profilPanYakala(panGesture : UIPanGestureRecognizer) {
       
        
        
        
        switch panGesture.state {
        
        case .began :
            superview?.subviews.forEach({ (subView) in
                subView.layer.removeAllAnimations()
            })
            
        case .changed :
            degisiklikPanYakala(panGesture)
            
        case .ended :
            bitisPanAnimasyon(panGesture)
            
            
        default :
            break
        }
        
    }
    
    fileprivate func bitisPanAnimasyon(_ panGesture : UIPanGestureRecognizer) {
        
        let translationYonu : CGFloat = panGesture.translation(in: nil).x > 0 ? 1 : -1
        
        let profilKaybet : Bool =  abs(panGesture.translation(in: nil).x) > sinirDegeri
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if profilKaybet {

                
                self.frame = CGRect(x: 600*translationYonu, y: 0, width: self.frame.width, height: self.frame.height)
                
                
//                let ekranDisiTransform = self.transform.translatedBy(x: 900, y: 0)
//                self.transform = ekranDisiTransform
                
                
            } else {
                self.transform = .identity
            }
            
            
           
        }) { (_) in
            print("Animasyon Bitti. Kart Geri Gelsin")
            self.transform = .identity
            
            if profilKaybet {
                self.removeFromSuperview()
            }
            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
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
