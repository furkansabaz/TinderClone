//
//  Kullanici.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 1.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
struct Kullanici : ProfilViewModelOlustur {
    let kullaniciAdi : String
    let meslek : String
    let yasi : Int
    let goruntuAdlari : [String]
    
    
    func kullaniciProfilViewModelOlustur() -> KullaniciProfilViewModel {
        
        let attrText = NSMutableAttributedString(string: kullaniciAdi, attributes: [.font : UIFont.systemFont(ofSize: 30, weight: .heavy)])
        
        attrText.append(NSAttributedString(string: " \(yasi)", attributes: [.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
        
        attrText.append(NSAttributedString(string: "\n\(meslek)", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return KullaniciProfilViewModel(attrString: attrText, goruntuAdlari: goruntuAdlari, bilgiKonumu: .left)
    }
}
