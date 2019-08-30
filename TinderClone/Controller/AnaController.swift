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
        
        
        ustStackView.btnAyarlar.addTarget(self, action: #selector(btnAyarlarPressed), for: .touchUpInside)
        altButonlarStackView.btnYenile.addTarget(self, action: #selector(btnYenilePressed), for: .touchUpInside)
        altButonlarStackView.btnBegen.addTarget(self, action: #selector(btnBegenPressed), for: .touchUpInside)
        altButonlarStackView.btnKapat.addTarget(self, action: #selector(btnKapatPressed), for: .touchUpInside)
        layoutDuzenle()
        
        gecerliKullaniciyiGetir()
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
            self.kullanicilariGetirFS()
        }
        
    }
    
     
    fileprivate func denemeLogin() {
        Auth.auth().signIn(withEmail: "shakira@gmail.com", password: "123456", completion: nil)
        print("Oturum Açıldı")
    }
    var sonGetirilenKullanici : Kullanici?
    fileprivate func kullanicilariGetirFS() {
        
        
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Profiller Getiriliyor"
        hud.show(in: view)
        
//        guard let arananMinYas = gecerliKullanici?.arananMinYas , let arananMaksYas = gecerliKullanici?.arananMaksYas else {
//            hud.dismiss()
//            return }
        
        
        let arananMinYas = gecerliKullanici?.arananMinYas ?? AyarlarController.varsayilanArananMinYas
        let arananMaksYas = gecerliKullanici?.arananMaksYas ?? AyarlarController.varsayilanArananMaksYas
        
        
        let sorgu = Firestore.firestore().collection("Kullanicilar")
            .whereField("Yasi", isGreaterThanOrEqualTo: arananMinYas)
            .whereField("Yasi", isLessThanOrEqualTo: arananMaksYas)
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
                
                if kullanici.kullaniciID != self.gecerliKullanici?.kullaniciID {
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
        
        if gorunenEnUstProfilView == nil {
            kullanicilariGetirFS()
        }
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
                }
            } else {
                //böyle bir veri yok. Veriyi eklemelisin
                Firestore.firestore().collection("Gecisler").document(kullaniciID).setData(eklenecekVeri) { (hata) in
                    
                    if let hata = hata {
                        print("Geçiş Verisi Kaydı Başarısız : \(hata.localizedDescription)")
                        return
                    }
                    print("Profili Beğenin Kaydedildi")
                }
            }
        }
        
        
        
        
        
        
    }
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
        
        
        _ = genelStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
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
