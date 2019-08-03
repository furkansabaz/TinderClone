//
//  Reklam.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 4.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit


struct Reklam  : ProfilViewModelOlustur {
    
    let baslik : String
    let markaAdi : String
    let afisGoruntuAdi : String
    
    
    func kullaniciProfilViewModelOlustur() -> KullaniciProfilViewModel {
        
        let attrText = NSMutableAttributedString(string: baslik, attributes: [.font : UIFont.systemFont(ofSize: 35, weight: .heavy)])
        
        attrText.append(NSAttributedString(string: "\n\(markaAdi)", attributes: [.font : UIFont.systemFont(ofSize: 25, weight: .bold)]))
        
        return KullaniciProfilViewModel(attrString: attrText, goruntuAdi: afisGoruntuAdi, bilgiKonumu: .center)
    }
    
    
}
