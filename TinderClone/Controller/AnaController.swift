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
    
    
    var kullanicilarPorfilViewModel : [KullaniciProfilViewModel] = {
        let profiller = [
            Kullanici(kullaniciAdi: "Sinem", meslek: "Kuaför", yasi: 25, goruntuAdlari: ["kisi1"]),
            Kullanici(kullaniciAdi: "Murat", meslek: "DJ", yasi: 18, goruntuAdlari: ["kisi2"]),
            Kullanici(kullaniciAdi: "Tuba", meslek: "Aktör", yasi: 24, goruntuAdlari: ["kisi3"]),
            Reklam(baslik: "Steve Jobs", markaAdi: "Apple", afisGoruntuAdi: "apple"),
            Kullanici(kullaniciAdi: "Shakira", meslek: "Şarkıcı", yasi: 40, goruntuAdlari: ["shakira1","shakira2","shakira3","shakira4"])
        ] as [ProfilViewModelOlustur]
       let viewModeller =  profiller.map({ $0.kullaniciProfilViewModelOlustur()  })
        return viewModeller
    }()
    
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
        
        kullanicilarPorfilViewModel.forEach { (kullaniciVM) in
            
            let profilView  = ProfilView(frame: .zero)
            profilView.kullaniciViewModel = kullaniciVM
            profilDiziniView.addSubview(profilView)
            profilView.doldurSuperView()
            
        }
        
    }


}
