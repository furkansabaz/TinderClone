//
//  KayitViewModel.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 5.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase

class KayitViewModel {
    
    var bindableKayitOluyor = Bindable<Bool>()
    var bindableKayitVerileriGecerli = Bindable<Bool>()
    var bindableImg = Bindable<UIImage>()
    
    var emailAdresi : String? {
        didSet {
            veriGecerliKontrol()
        }
    }
    var adiSoyadi : String? {
        didSet {
            veriGecerliKontrol()
        }
    }
    var parola : String? {
        didSet {
            veriGecerliKontrol()
        }
    }
    
    fileprivate func veriGecerliKontrol() {
        
        let gecerli = emailAdresi?.isEmpty == false && adiSoyadi?.isEmpty == false && parola?.isEmpty == false
        bindableKayitVerileriGecerli.deger = gecerli
        
    }
    
    func kullaniciKayitGerceklestir(completion : @escaping (Error?) -> ()){
        
        guard let emailAdresi = emailAdresi , let parola = parola else {return}
        bindableKayitOluyor.deger = true
        
        Auth.auth().createUser(withEmail: emailAdresi, password: parola) { (sonuc, hata) in
            
            if let hata = hata {
                print("Kullanıcı Kayıt Olurken Hata Meydana Geldi : \(hata.localizedDescription)")
                completion(hata)
                return
            }
            
            print("Kullanıcı Kaydı Başarılı. Kullanıcı ID : \(sonuc?.user.uid ?? "Bulunamadı")")
            self.goruntuFirebaseKaydet(completion: completion)
            
        }
    }
    
    
    fileprivate func goruntuFirebaseKaydet(completion : @escaping (Error?) -> ()) {
        let goruntuAdi = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/Goruntuler/\(goruntuAdi)")
        
        let goruntuData = self.bindableImg.deger?.jpegData(compressionQuality: 0.8) ?? Data()
        
        ref.putData(goruntuData, metadata: nil) { (_, hata) in
            
            if let hata = hata {
                completion(hata)
                return
            }
            print("Görüntü Başarıyla Upload edildi")
            
            ref.downloadURL { (url, hata) in
                if let hata = hata {
                    completion(hata)
                    return
                }
                
                
                self.bindableKayitOluyor.deger = false
                print("Görüntü URL : \(url?.absoluteString ?? "")")
                
                let goruntuURL = url?.absoluteString ?? ""
                
                self.kullaniciBilgileriniFireStoreKaydet(goruntuURL: goruntuURL, completion: completion)
            }
        }
    }
    
    
    fileprivate func kullaniciBilgileriniFireStoreKaydet(goruntuURL : String , completion : @escaping (Error?) -> ()) {
        
        let kullaniciID = Auth.auth().currentUser?.uid ?? ""
        
        let eklenecekVeri = ["AdiSoyadi" : adiSoyadi ?? "", "GoruntuURL" : goruntuURL, "KullaniciID" : kullaniciID]
        
        Firestore.firestore().collection("Kullanicilar").document(kullaniciID).setData(eklenecekVeri) { (hata) in
            
            if let hata = hata {
                completion(hata)
                return
            }
            completion(nil)
        }
        
        
    }
    
    
    
}
