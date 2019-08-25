//
//  OturumViewModel.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import Firebase

class OturumViewModel {
    
    var oturumAciliyor = Bindable<Bool>()
    var formGecerli = Bindable<Bool>()
    
    var emailAdresi : String? {
        didSet {
            formGecerliKontrol()
        }
    }
    
    var parola : String? {
        didSet {
            formGecerliKontrol()
        }
    }
    
    fileprivate func formGecerliKontrol() {
        let gecerli = emailAdresi?.isEmpty == false && parola?.isEmpty == false
        formGecerli.deger = gecerli
    }
    func oturumAc(completion : @escaping (Error?) -> ()) {
        
        guard let emailAdresi = emailAdresi , let parola = parola else { return }
        
        oturumAciliyor.deger = true
        Auth.auth().signIn(withEmail: emailAdresi, password: parola) { (sonuc, hata) in
            completion(hata)
        }
        
    }
    
}
