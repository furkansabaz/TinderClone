//
//  ProfilView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 1.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import SDWebImage
class ProfilView: UIView {

    var sonrakiProfilView : ProfilView?
    
    var delegate : ProfilViewDelegate?
    var kullaniciViewModel : KullaniciProfilViewModel! {
        
        didSet {
            
            
            fotoGecisController.kullaniciViewModel = kullaniciViewModel
            
            
            lblKullaniciBilgileri.attributedText = kullaniciViewModel.attrString
            
            lblKullaniciBilgileri.textAlignment = kullaniciViewModel.bilgiKonumu
            
            
            (0..<kullaniciViewModel.goruntuAdlari.count).forEach { (_) in
                let bView = UIView()
                
                bView.backgroundColor = seciliOlmayanRenk
                goruntuBarStackView.addArrangedSubview(bView)
            }
            
            goruntuBarStackView.arrangedSubviews.first?.backgroundColor = .white
            ayarlaGoruntuIndexGozlemci()
        }
    }
    fileprivate func ayarlaGoruntuIndexGozlemci() {
        
        kullaniciViewModel.goruntuIndexGozlemci = { (index, goruntuURL) in
            
            
            
            
            self.goruntuBarStackView.arrangedSubviews.forEach({ sView in
                sView.backgroundColor = self.seciliOlmayanRenk
            })
            
            self.goruntuBarStackView.arrangedSubviews[index].backgroundColor = .white
            
            
        }
        
    }
    
   
    //fileprivate let imgProfil = UIImageView(image:#imageLiteral(resourceName: "kisi1") )
    fileprivate let fotoGecisController = FotoGecisController(kullaniciViewModelMi: true)
    fileprivate let gradientLayer = CAGradientLayer()
    let lblKullaniciBilgileri = UILabel()
    fileprivate let sinirDegeri : CGFloat = 120
    
    fileprivate let seciliOlmayanRenk = UIColor(white: 0, alpha: 0.2)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
        duzenleLayout()
        
        let panG = UIPanGestureRecognizer(target: self, action: #selector(profilPanYakala))
        addGestureRecognizer(panG)
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(yakalaTapGesture))
        addGestureRecognizer(tapG)
    }
    
    fileprivate let btnDetayliBilgi : UIButton = {
        let buton = UIButton(type: .system)
        buton.setImage(UIImage(named: "detayliBilgi")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buton.addTarget(self, action: #selector(btnDetayliBilgiPressed), for: .touchUpInside)
        return buton
    }()
    
    @objc fileprivate func btnDetayliBilgiPressed() {
        print("Kullanıcı Detay SAyfasına Gitmelisin")
        delegate?.detayliBilgiPressed(kullaniciVM: kullaniciViewModel)
        
    }
    fileprivate func duzenleLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        let fotoGecisView = fotoGecisController.view!
        addSubview(fotoGecisView)
        fotoGecisView.doldurSuperView()
        
        
        olusturGradientLayer()
        
        addSubview(lblKullaniciBilgileri)
        
        _ = lblKullaniciBilgileri.anchor(top: nil,
                                     bottom: bottomAnchor,
                                     leading: leadingAnchor,
                                     trailing: trailingAnchor,
                                     padding: .init(top: 0, left: 15, bottom: 15, right: 15))
        
        
        
        lblKullaniciBilgileri.textColor = .white
        lblKullaniciBilgileri.numberOfLines = 0
        
        addSubview(btnDetayliBilgi)
        _ = btnDetayliBilgi.anchor(top: nil, bottom: bottomAnchor, leading: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 20), boyut: .init(width: 45, height: 45))
    }
    
    var goruntuIndex = 0
    @objc fileprivate func yakalaTapGesture(tapG : UITapGestureRecognizer) {
    
        let konum = tapG.location(in: nil)
        
        let sonrakiGoruntuGecis = konum.x > frame.width / 2 ? true : false
        
        if sonrakiGoruntuGecis {
            kullaniciViewModel.sonrakiGoruntuyeGit()
        } else {
            kullaniciViewModel.oncekiGoruntuyeGit()
        }
        
        
    }
    
    fileprivate let goruntuBarStackView = UIStackView()
    
    fileprivate func olusturBarStackView() {
        addSubview(goruntuBarStackView)
        
        _ = goruntuBarStackView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), boyut: .init(width: 0, height: 4))
        
        goruntuBarStackView.spacing = 4
        
        goruntuBarStackView.distribution = .fillEqually
        
        
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
            superview?.subviews.forEach({ (subView) in
                subView.layer.removeAllAnimations()
            })
            
        default :
            break
        }
        
    }
    
    fileprivate func bitisPanAnimasyon(_ panGesture : UIPanGestureRecognizer) {
        
        let translationYonu : CGFloat = panGesture.translation(in: nil).x > 0 ? 1 : -1
        
        let profilKaybet : Bool =  abs(panGesture.translation(in: nil).x) > sinirDegeri
        
        if profilKaybet {
            guard let anaController = self.delegate as? AnaController else { return }
            
            if translationYonu == 1 {
                anaController.btnBegenPressed()
            } else {
                anaController.btnKapatPressed()
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
            })
        }
        
        
        
        
        
        
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
//
//            if profilKaybet {
//
//
//                self.frame = CGRect(x: 600*translationYonu, y: 0, width: self.frame.width, height: self.frame.height)
//
//
////                let ekranDisiTransform = self.transform.translatedBy(x: 900, y: 0)
////                self.transform = ekranDisiTransform
//
//
//            } else {
//                self.transform = .identity
//            }
//
//
//
//        }) { (_) in
//            print("Animasyon Bitti. Kart Geri Gelsin")
//            self.transform = .identity
//
//            if profilKaybet {
//                self.removeFromSuperview()
//                self.delegate?.profiliSiradanCikar(profil: self)
//            }
//            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
//        }
        
        
        
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
protocol ProfilViewDelegate {
    func profiliSiradanCikar(profil : ProfilView)
    func detayliBilgiPressed(kullaniciVM :  KullaniciProfilViewModel)
}
