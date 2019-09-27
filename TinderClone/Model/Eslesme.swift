//
//  Eslesme.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 27.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
struct Eslesme {
    let kullaniciAdi : String
    let profilGoruntuUrl : String
    let kullaniciID: String
    init(veri : [String : Any]) {
        self.kullaniciAdi = veri["KullaniciAdi"] as? String ?? ""
        self.profilGoruntuUrl = veri["ProfilGoruntuUrl"] as? String ?? ""
        self.kullaniciID = veri["KullaniciID"] as? String ?? ""
    }
}
