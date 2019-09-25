//
//  ViewController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
class AnaController: UIViewController {

    let ustStackView = AnaGorunumUstStackView()
    let profilDiziniView = UIView()
    //MARK:- ÜST MENÜDEKİ bUTONLARI TUTAR
    let altButonlarStackView = AnaGorunumAltStackView()
    
    var kullanicilarPorfilViewModel = [KullaniciProfilViewModel]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        ustStackView.btnMesaj.addTarget(self, action: #selector(btnMesajlarPressed), for: .touchUpInside)
        ustStackView.btnAyarlar.addTarget(self, action: #selector(btnAyarlarPressed), for: .touchUpInside)
        altButonlarStackView.btnYenile.addTarget(self, action: #selector(btnYenilePressed), for: .touchUpInside)
        altButonlarStackView.btnBegen.addTarget(self, action: #selector(btnBegenPressed), for: .touchUpInside)
        altButonlarStackView.btnKapat.addTarget(self, action: #selector(btnKapatPressed), for: .touchUpInside)
        layoutDuzenle()
        
        gecerliKullaniciyiGetir()
    }
    
    @objc fileprivate func btnMesajlarPressed() {
        
        let viewController =  EslesmelerMesajlarController()
        viewController.view.backgroundColor = .blue
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser == nil {
            let kayitController = KayitController()
            kayitController.delegate = self
            
            let navController = UINavigationController(rootViewController: kayitController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        }
    }
    
    fileprivate var gecerliKullanici : Kullanici?
    fileprivate func gecerliKullaniciyiGetir() {
        profilDiziniView.subviews.forEach({ $0.removeFromSuperview()})
 
        
        Firestore.firestore().gecerliKullaniciyiGetir { (kullanici, hata) in
            if let hata = hata {
                print("Oturum Açan Kullanıcın Bilgileri Getirilirken Hata Meydana Geldi : \(hata)")
                return
            }
            self.gecerliKullanici = kullanici
            self.gecisleriGetir()
        }
        
    }
    
     
    var gecisVerileri = [String : Int]()
    fileprivate func gecisleriGetir() {
        
        guard let kullaniciID = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("Gecisler").document(kullaniciID).getDocument { (snapshot, hata) in
            
            if let hata = hata {
                print("Oturum Açmış Kullanıcının Geçiş Verileri Getirilirken Hata Oluştu : \(hata.localizedDescription)")
                return
            }
            
            print("Geçiş Verisi : ", snapshot?.data() ?? "")
            
            guard let gecisVerisi = snapshot?.data() as? [String : Int] else {
                self.gecisVerileri.removeAll()
                self.kullanicilariGetirFS()
                return
                
            }
            self.gecisVerileri = gecisVerisi
            self.kullanicilariGetirFS()
            
        }
        
    }
    
    
    
    
    
    var sonGetirilenKullanici : Kullanici?
    fileprivate func kullanicilariGetirFS() {
        
        
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Profiller Getiriliyor"
        hud.show(in: view)
        

        
        
        let arananMinYas = gecerliKullanici?.arananMinYas ?? AyarlarController.varsayilanArananMinYas
        let arananMaksYas = gecerliKullanici?.arananMaksYas ?? AyarlarController.varsayilanArananMaksYas
        
        
        let sorgu = Firestore.firestore().collection("Kullanicilar")
            .whereField("Yasi", isGreaterThanOrEqualTo: arananMinYas)
            .whereField("Yasi", isLessThanOrEqualTo: arananMaksYas).limit(to: 7)
        gorunenEnUstProfilView = nil
        sorgu.getDocuments { (snapshot, hata) in
            hud.dismiss()
            if let hata = hata {
                print("Kullanıcılar Getirilirken Hata Meydana Geldi : \(hata)")
                return
            }
            
            var oncekiProfilView : ProfilView?
            snapshot?.documents.forEach({ (dSnapshot) in
                let kullaniciVeri = dSnapshot.data()
                let kullanici = Kullanici(bilgiler: kullaniciVeri)
                
                self.kullanicilar[kullanici.kullaniciID ?? ""] = kullanici
                
                let gecerliKullaniciMi = kullanici.kullaniciID == Auth.auth().currentUser?.uid
                
                //let gecisVerisiVarMi = self.gecisVerileri[kullanici.kullaniciID] != nil
                
                let gecisVerisiVarMi = false
                print("Geçiş Verisi Var Mı  : \(gecisVerisiVarMi)      -    Geçerli Kullanıcı Mı : \(gecerliKullaniciMi)")
                
                
                
                if !gecerliKullaniciMi && !gecisVerisiVarMi{
                    let pView = self.kullanicidanProfilOlustur(kullanici: kullanici)
                    
                    if self.gorunenEnUstProfilView == nil {
                        self.gorunenEnUstProfilView = pView
                    }
                    
                    oncekiProfilView?.sonrakiProfilView = pView
                    oncekiProfilView = pView
                }
                
            })
            
            //self.kullaniciProfilleriAyarlaFireStore()
        }
    }
    
    fileprivate func kullanicidanProfilOlustur(kullanici : Kullanici) -> ProfilView {
        
        let pView = ProfilView(frame: .zero)
        pView.delegate = self
        pView.kullaniciViewModel = kullanici.kullaniciProfilViewModelOlustur()
        profilDiziniView.addSubview(pView)
        profilDiziniView.sendSubviewToBack(pView)
        pView.doldurSuperView()
        return pView
    }
    
    @objc func btnYenilePressed() {
        
        profilDiziniView.subviews.forEach({ $0.removeFromSuperview()})
        gecerliKullaniciyiGetir()
    }
    
    @objc func btnAyarlarPressed() {
        
        let ayarlarController = AyarlarController()
        ayarlarController.delegate = self
        let navController = UINavigationController(rootViewController: ayarlarController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
        
    }
    
    @objc  func btnKapatPressed() {
        gecisleriKaydetFirestore(begeniDurumu: -1)
        profilGecisAnimasyonu(translation: -800, angle: -16)
        
    }
    
    
    fileprivate func gecisleriKaydetFirestore(begeniDurumu : Int) {
        
        guard let kullaniciID = Auth.auth().currentUser?.uid else {return}
        
        guard let profilID = gorunenEnUstProfilView?.kullaniciViewModel.kullaniciID else {return}
        
        let eklenecekVeri = [profilID : begeniDurumu]
        
        
        Firestore.firestore().collection("Gecisler").document(kullaniciID).getDocument { (snapshot, hata) in
            
            if let hata = hata {
                print("Geçiş Verisi Alınamadı : \(hata.localizedDescription)")
                return
            }
            
            if snapshot?.exists == true {
                // veri zaten vardır güncelleyebiliriz
                Firestore.firestore().collection("Gecisler").document(kullaniciID).updateData(eklenecekVeri) { (hata) in
                    if let hata = hata {
                        print("Geçiş Verisi Güncellemesi Başarısız : \(hata.localizedDescription)")
                        return
                    }
                    print("Profili Beğenin Güncellendi")
                    if begeniDurumu == 1 {
                        self.eslesmeKontrol(profilID: profilID)
                    }
                    
                }
            } else {
                //böyle bir veri yok. Veriyi eklemelisin
                Firestore.firestore().collection("Gecisler").document(kullaniciID).setData(eklenecekVeri) { (hata) in
                    
                    if let hata = hata {
                        print("Geçiş Verisi Kaydı Başarısız : \(hata.localizedDescription)")
                        return
                    }
                    print("Profili Beğenin Kaydedildi")
                    if begeniDurumu == 1 {
                        self.eslesmeKontrol(profilID: profilID)
                    }
                    
                }
            }
        }
        
    }
    
    fileprivate func eslesmeKontrol(profilID : String) {
        print("Eşleşme Kontrol Ediliyor")
        
        Firestore.firestore().collection("Gecisler").document(profilID).getDocument { (snapshot, hata) in
            
            if let hata = hata {
                print("Beğenilen Profilin Beğeni Bilgileri Getirilemedi : \(hata.localizedDescription)")
                return
            }
            
            guard let veri = snapshot?.data() else { return }
            print(veri)
            
            guard let kullaniciID = Auth.auth().currentUser?.uid else { return }
            let eslesmeVarMi = veri[kullaniciID] as? Int == 1
            if eslesmeVarMi {
                print("Eşleşme Var")
                self.getirEslesmeView(profilID: profilID)
                
                //eşleşme varsa eşleşme verileri Firestore'a kaydet
                //oturumu açan kullanıcı için eşleşme verisinin eklenmesi
                guard let eslesilenKullanici = self.kullanicilar[profilID] else {return}
                
                let eklenecekVeri = ["KullaniciAdi" : eslesilenKullanici.kullaniciAdi ?? "",
                                     "ProfilGoruntuUrl" : eslesilenKullanici.goruntuURL1 ?? "",
                                     "KullaniciID" : profilID,
                "Timestamp" : Timestamp(date: Date())] as [String : Any]
                
                Firestore.firestore().collection("Eslesmeler_Mesajlar").document(kullaniciID).collection("Eslesmeler").document(profilID).setData(eklenecekVeri) { (hata) in
                    if let hata = hata {
                        print("Eşleşme Verileri Kaydedilirken Hata Oluştu : ",hata)
                    }
                }
                
                
                //Eşleşilen kullanıcı için eşleşme verisinin eklenmesi
                guard let gecerliKullanici = self.gecerliKullanici else { return }
                print("Geçerli Kullanıcı")
                let eklenecekVeri2 = ["KullaniciAdi" : gecerliKullanici.kullaniciAdi ?? "",
                                      "ProfilGoruntuUrl" : gecerliKullanici.goruntuURL1 ?? "",
                                      "KullaniciID" : gecerliKullanici.kullaniciID,
                                      "Timestamp" : Timestamp(date: Date())] as [String : Any]
                
                Firestore.firestore().collection("Eslesmeler_Mesajlar").document(profilID).collection("Eslesmeler").document(kullaniciID).setData(eklenecekVeri2) { (hata) in
                    
                    if let hata = hata {
                        print("Eşleşilen Kullanıcının Eşleşme Verisi Kaydedilemedi : ",hata)
                    }
                }
            }
        }
        
    }
    
    
    fileprivate func getirEslesmeView(profilID : String) {
        
        let eslesmeView = EslesmeView()
        eslesmeView.profilID = profilID
        eslesmeView.gecerliKullanici = gecerliKullanici
        view.addSubview(eslesmeView)
        eslesmeView.doldurSuperView()
    }
    
    var kullanicilar = [String : Kullanici]()
    var gorunenEnUstProfilView : ProfilView?
    //MARK:- KULLANICI BİR PROFİLİ BEĞENİRSE ÇALIŞIR
    @objc  func btnBegenPressed() {
        gecisleriKaydetFirestore(begeniDurumu: 1)
        profilGecisAnimasyonu(translation: 800, angle: 16)
    }
    
    fileprivate func profilGecisAnimasyonu(translation : CGFloat, angle : CGFloat) {
        let basicAnimation = CABasicAnimation(keyPath: "position.x")
        basicAnimation.toValue = translation
        basicAnimation.duration = 1
        basicAnimation.fillMode = .forwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        basicAnimation.isRemovedOnCompletion = false
        
        let dondurmeAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        dondurmeAnimation.toValue = CGFloat.pi * angle / 180
        dondurmeAnimation.duration = 1
        
        let ustPView = gorunenEnUstProfilView
        gorunenEnUstProfilView = ustPView?.sonrakiProfilView
        
        CATransaction.setCompletionBlock {
            ustPView?.removeFromSuperview()
        }
        
        ustPView?.layer.add(basicAnimation, forKey: "animasyon")
        ustPView?.layer.add(dondurmeAnimation, forKey: "dondurme")
        CATransaction.commit()
    }
    
    //MARK:- LAYOUT DÜZENLEYEN FONKSİYON
    func layoutDuzenle() {
        view.backgroundColor = .white
        let genelStackView = UIStackView(arrangedSubviews: [ustStackView, profilDiziniView,altButonlarStackView])
        genelStackView.axis = .vertical
        view.addSubview(genelStackView)
        
        
         genelStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        genelStackView.isLayoutMarginsRelativeArrangement = true
        genelStackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        genelStackView.bringSubviewToFront(profilDiziniView)
    }
    
    func kullaniciProfilleriAyarlaFireStore() {
        
        
        kullanicilarPorfilViewModel.forEach { (kullaniciVM) in
            
            let profilView  = ProfilView(frame: .zero)
            profilView.kullaniciViewModel = kullaniciVM
            profilDiziniView.addSubview(profilView)
            profilView.doldurSuperView()
            
        }
        
    }


}


extension AnaController : AyarlarControllerDelegate {
    func ayarlarKaydedildi() {
        gecerliKullaniciyiGetir()
    }
}


extension AnaController : OturumControllerDelegate {
    func oturumAcmaBitis() {
        gecerliKullaniciyiGetir()
    }
    
}

extension AnaController : ProfilViewDelegate {
    
    func profiliSiradanCikar(profil: ProfilView) {
        
        self.gorunenEnUstProfilView?.removeFromSuperview()
        self.gorunenEnUstProfilView = self.gorunenEnUstProfilView?.sonrakiProfilView
    }
    func detayliBilgiPressed(kullaniciVM: KullaniciProfilViewModel) {
        let kullaniciDetaylariController = KullaniciDetaylariController()
        kullaniciDetaylariController.modalPresentationStyle = .fullScreen
        kullaniciDetaylariController.kullaniciViewModel = kullaniciVM
        present(kullaniciDetaylariController, animated: true)
    }
    
    
        
        
  
    
}
