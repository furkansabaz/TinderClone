//
//  KullaniciProfilViewModel.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 3.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit


class KullaniciProfilViewModel {
    
    let attrString : NSAttributedString
    let goruntuAdlari : [String]
    let bilgiKonumu : NSTextAlignment
    
    init(attrString : NSAttributedString,  goruntuAdlari : [String] , bilgiKonumu : NSTextAlignment) {
        self.goruntuAdlari = goruntuAdlari
        self.attrString = attrString
        self.bilgiKonumu = bilgiKonumu
    }
    
    
    fileprivate var goruntuIndex = 0 {
        didSet {
            let goruntuAdi = goruntuAdlari[goruntuIndex]
            
            let imgProfil = UIImage(named: goruntuAdi)
            goruntuIndexGozlemci?(goruntuIndex, imgProfil ?? UIImage())
        }
    }
    
    var goruntuIndexGozlemci : ( (Int, UIImage) -> () )?
    
     func sonrakiGoruntuyeGit() {
        goruntuIndex = goruntuIndex + 1 >= goruntuAdlari.count ? 0  : goruntuIndex + 1
    }
    func oncekiGoruntuyeGit() {
        goruntuIndex = goruntuIndex - 1 < 0 ? goruntuAdlari.count - 1 : goruntuIndex - 1
    }
}



protocol ProfilViewModelOlustur {
    func kullaniciProfilViewModelOlustur() -> KullaniciProfilViewModel
}
