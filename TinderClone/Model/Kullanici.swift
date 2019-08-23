//
//  Kullanici.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 1.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
struct Kullanici : ProfilViewModelOlustur {
    var kullaniciAdi : String?
    var meslek : String?
    var yasi : Int?
    //let goruntuAdlari : [String]
    var goruntuURL1 : String
    
    var kullaniciID : String
    
    init(bilgiler : [String : Any]){
        self.kullaniciAdi = bilgiler["AdiSoyadi"] as? String ?? ""
        self.yasi = bilgiler["Yasi"] as? Int
        self.meslek = bilgiler["Meslek"] as? String
        
        self.goruntuURL1 = bilgiler["GoruntuURL"] as? String ?? ""
        self.kullaniciID = bilgiler["KullaniciID"] as? String ?? ""
    }
    
    func kullaniciProfilViewModelOlustur() -> KullaniciProfilViewModel {
        
        let attrText = NSMutableAttributedString(string: kullaniciAdi ?? "", attributes: [.font : UIFont.systemFont(ofSize: 30, weight: .heavy)])
        
        let yasStr = yasi != nil ? "\(yasi!)" : "**"
        
        attrText.append(NSAttributedString(string: " \(yasStr)", attributes: [.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
        
        let meslekStr = meslek != nil ? meslek! : "Girilmedi"
        attrText.append(NSAttributedString(string: "\n\(meslekStr)", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return KullaniciProfilViewModel(attrString: attrText, goruntuAdlari: [goruntuURL1], bilgiKonumu: .left)
    }
}
