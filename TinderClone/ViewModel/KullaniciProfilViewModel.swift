//
//  KullaniciProfilViewModel.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 3.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit


class KullaniciProfilViewModel {
    let kullaniciID : String
    let attrString : NSAttributedString
    let goruntuAdlari : [String]
    let bilgiKonumu : NSTextAlignment
    
    init(attrString : NSAttributedString,  goruntuAdlari : [String] , bilgiKonumu : NSTextAlignment, kullaniciID : String) {
        self.goruntuAdlari = goruntuAdlari
        self.attrString = attrString
        self.bilgiKonumu = bilgiKonumu
        self.kullaniciID = kullaniciID
    }
    
    
    fileprivate var goruntuIndex = 0 {
        didSet {
            let goruntuURL = goruntuAdlari[goruntuIndex]
            
            
            goruntuIndexGozlemci?(goruntuIndex, goruntuURL)
        }
    }
    
    var goruntuIndexGozlemci : ( (Int, String?) -> () )?
    
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
