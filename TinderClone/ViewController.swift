//
//  ViewController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ustStackView = AnaGorunumUstStackView()
    let profilDiziniView = UIView()
    //MARK:- ÜST MENÜDEKİ bUTONLARI TUTAR
    let butonlarStackView = AnaGorunumAltStackView()
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
        print("Profil Görünümü Ayarlanıyor")
        
        let pView = ProfilView(frame: .zero)
        profilDiziniView.addSubview(pView)
        
        pView.doldurSuperView()
    }


}

