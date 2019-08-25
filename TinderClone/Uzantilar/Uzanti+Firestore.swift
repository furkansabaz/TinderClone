//
//  Uzanti+Firestore.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import Firebase

extension Firestore {
    
    func gecerliKullaniciyiGetir(completion : @escaping (Kullanici? , Error?) -> ()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("Kullanicilar").document(uid).getDocument { (snapshot, hata) in
            if let hata = hata {
                completion(nil,hata)
                return
            }
            
            guard let bilgiler = snapshot?.data() else {
                let hata = NSError(domain: "furkansabaz.com.TinderClone", code: 450, userInfo: [NSLocalizedDescriptionKey : "Kullanıcı Bulunamadı"])
                completion(nil,hata)
                return
            }
            let kullanici = Kullanici(bilgiler: bilgiler)
            completion(kullanici,nil)
        }
    }
    
}
