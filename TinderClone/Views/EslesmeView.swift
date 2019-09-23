//
//  EslesmeView.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
class EslesmeView : UIView {
    var gecerliKullanici : Kullanici!
    var profilID : String! {
        didSet {
         
            
            let sorgu = Firestore.firestore().collection("Kullanicilar")
            sorgu.document(profilID).getDocument { (snapshot, hata) in
                if let hata = hata {
                    print("Eşleşmesi Yapılan Profilin Bilgileri Getirilemedi : \(hata.localizedDescription)")
                    return
                }
                
                guard let profilVerisi = snapshot?.data() else { return }
                let kullanici = Kullanici(bilgiler: profilVerisi)
                
                guard let url = URL(string: kullanici.goruntuURL1 ?? "") else { return }
                
                self.imgKarsiProfil.sd_setImage(with: url)
                
                guard let gecerliKullaniciGoruntuURL = URL(string : self.gecerliKullanici.goruntuURL1 ?? "") else { return }
                
                self.imgGecerliKullanici.sd_setImage(with: gecerliKullaniciGoruntuURL) { (_, _, _, _) in
                    self.animasyonlariOlustur()
                }
                self.lblAciklama.text = "Sen ve \(kullanici.kullaniciAdi ?? "Bilinmiyor") karşılıklı\nolarak birbirinizi beğendiniz"
            
            }
            
            
        }
    }
    fileprivate let btnGezinmeyiSurdur : UIButton = {
        let btn =  GezinmeyiSurdurButonu()
        btn.setTitle("Gezinmeyi Sürdür", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    fileprivate let btnMesajGonder : UIButton = {
        let btn = MesajGonderButonu()
        btn.setTitle("MESAJ GÖNDER", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    fileprivate let imgEslesme : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "eslesme"))
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    fileprivate let lblAciklama : UILabel = {
        let lbl = UILabel()
        lbl.text = "Sen ve A karşılıklı\nolarak birbirinizi beğendiniz"
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 21)
        return lbl
    }()
    
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
        img.alpha = 0
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        blurEfektEkle()
        duzenleLayout()
        
    }
    
    
    fileprivate func animasyonlariOlustur() {
        views.forEach({ $0.alpha = 1 })
        
        let aci = 25 * CGFloat.pi / 180
        
        imgGecerliKullanici.transform = CGAffineTransform(rotationAngle: -aci).concatenating(CGAffineTransform(translationX: 220, y: 0))
        
        imgKarsiProfil.transform = CGAffineTransform(rotationAngle: aci).concatenating(CGAffineTransform(translationX: -220, y: 0))
        
        
        btnMesajGonder.transform = CGAffineTransform(translationX: -450, y: 0)
        btnGezinmeyiSurdur.transform = CGAffineTransform(translationX: 450, y: 0)
        
        
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            //Animasyon 1 - Nesnelerin Orijinal Konumlarına Dönmesi
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                
                self.imgGecerliKullanici.transform = CGAffineTransform(rotationAngle: -aci)
                self.imgKarsiProfil.transform = CGAffineTransform(rotationAngle: aci)
            }
            
            //Animasyon 2 - Döndürme İşlemi
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                self.imgGecerliKullanici.transform = .identity
                self.imgKarsiProfil.transform = .identity
                
            }
            
        }) { (_) in
            
        }
        
        UIView.animate(withDuration: 0.9, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
            self.btnMesajGonder.transform = .identity
            self.btnGezinmeyiSurdur.transform = .identity
        })
        
        
    }
    
    lazy var views = [
    imgEslesme,
    lblAciklama,
    imgGecerliKullanici,
    imgKarsiProfil,
    btnMesajGonder,
    btnGezinmeyiSurdur
    ]
    
    fileprivate func duzenleLayout() {
        
        views.forEach({ (v) in
            addSubview(v)
            v.alpha = 0
        })
        addSubview(btnGezinmeyiSurdur)
        let goruntuBoyut : CGFloat = 135
        _ = imgGecerliKullanici.anchor(top: nil, bottom: nil, leading: nil, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), boyut: .init(width: goruntuBoyut, height: goruntuBoyut))
        
        imgGecerliKullanici.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        imgGecerliKullanici.layer.cornerRadius = goruntuBoyut / 2
        
        _ = imgKarsiProfil.anchor(top: nil, bottom: nil, leading: centerXAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), boyut: .init(width: goruntuBoyut, height: goruntuBoyut))
        imgKarsiProfil.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgKarsiProfil.layer.cornerRadius = goruntuBoyut / 2
        
        _ = imgEslesme.anchor(top: nil, bottom: lblAciklama.topAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 15, right: 0), boyut: .init(width: 290, height: 80))
        
        imgEslesme.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = lblAciklama.anchor(top: nil, bottom: imgGecerliKullanici.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 35, right: 0), boyut: .init(width: 0, height: 60))
        
        _ = btnMesajGonder.anchor(top: imgGecerliKullanici.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 30, left: 45, bottom: 0, right: 45), boyut: .init(width: 0, height: 60))
        
        _ = btnGezinmeyiSurdur.anchor(top: btnMesajGonder.bottomAnchor, bottom: nil, leading: btnMesajGonder.leadingAnchor, trailing: btnMesajGonder.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), boyut: .init(width: 0, height: 60))
        
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
