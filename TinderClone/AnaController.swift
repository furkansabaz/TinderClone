//
//  ViewController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class AnaController: UIViewController {

    let ustStackView = AnaGorunumUstStackView()
    let profilDiziniView = UIView()
    //MARK:- ÜST MENÜDEKİ bUTONLARI TUTAR
    let butonlarStackView = AnaGorunumAltStackView()
    
    
    var kullanicilar = [
    Kullanici(kullaniciAdi: "Sinem", meslek: "Kuaför", yasi: 25, goruntuAdi: "kisi1"),
    Kullanici(kullaniciAdi: "Murat", meslek: "DJ", yasi: 18, goruntuAdi: "kisi2"),
    Kullanici(kullaniciAdi: "Tuba", meslek: "Aktör", yasi: 24, goruntuAdi: "kisi3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        layoutDuzenle()
        profilGorunumuAyarla()
    }
    
    
    //MARK:- LAYOUT DÜZENLEYEN FONKSİYON
    func layoutDuzenle() {
        let genelStackView = UIStackView(arrangedSubviews: [ustStackView, profilDiziniView,butonlarStackView])
        genelStackView.axis = .vertical
        view.addSubview(genelStackView)
        
        
        genelStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        genelStackView.isLayoutMarginsRelativeArrangement = true
        genelStackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        genelStackView.bringSubviewToFront(profilDiziniView)
    }
    
    func profilGorunumuAyarla() {
        
        
        kullanicilar.forEach { (k) in
            let pView = ProfilView(frame: .zero)
            
            pView.imgProfil.image = UIImage(named: k.goruntuAdi)
            
            let attrText = NSMutableAttributedString(string: k.kullaniciAdi, attributes: [.font : UIFont.systemFont(ofSize: 30, weight: .heavy)])
            
            attrText.append(NSAttributedString(string: " \(k.yasi)", attributes: [.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
            
            attrText.append(NSAttributedString(string: "\n\(k.meslek)", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .regular)]))
            
            pView.lblKullaniciBilgileri.attributedText = attrText
            
            
            
            profilDiziniView.addSubview(pView)
            pView.doldurSuperView()
        }
        
        
        
    }


}

