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
        
        layoutDuzenle()
        kullaniciProfilleriAyarlaFireStore()
        kullaniciVerileriGetirFS()
        
        //denemeLogin()
    }
     
    fileprivate func denemeLogin() {
        Auth.auth().signIn(withEmail: "shakira@gmail.com", password: "123456", completion: nil)
        print("Oturum Açıldı")
    }
    var sonGetirilenKullanici : Kullanici?
    fileprivate func kullaniciVerileriGetirFS() {
        
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Profiller Getiriliyor"
        hud.show(in: view)
        let sorgu = Firestore.firestore().collection("Kullanicilar")
            .order(by: "KullaniciID")
            .start(after: [sonGetirilenKullanici?.kullaniciID ?? ""])
            .limit(to: 2)
        
        
        sorgu.getDocuments { (snapshot, hata) in
            hud.dismiss()
            if let hata = hata {
                print("Kullanıcılar Getirilirken Hata Meydana Geldi : \(hata)")
                return
            }
            
            snapshot?.documents.forEach({ (dSnapshot) in
                let kullaniciVeri = dSnapshot.data()
                let kullanici = Kullanici(bilgiler: kullaniciVeri)
                
                self.kullanicilarPorfilViewModel.append(kullanici.kullaniciProfilViewModelOlustur())
                self.sonGetirilenKullanici = kullanici
                self.kullanicidanProfilOlustur(kullanici: kullanici)
            })
            
            //self.kullaniciProfilleriAyarlaFireStore()
        }
    }
    
    fileprivate func kullanicidanProfilOlustur(kullanici : Kullanici) {
        
        let pView = ProfilView(frame: .zero)
        
        pView.kullaniciViewModel = kullanici.kullaniciProfilViewModelOlustur()
        
        profilDiziniView.addSubview(pView)
        pView.doldurSuperView()
    }
    
    @objc func btnYenilePressed() {
        kullaniciVerileriGetirFS()
    }
    
    @objc func btnAyarlarPressed() {
        
        let ayarlarController = AyarlarController()
        let navController = UINavigationController(rootViewController: ayarlarController)
        present(navController, animated: true)
        
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

