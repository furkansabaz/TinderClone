//
//  EslesmelerMesajlarController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit
import Firebase



struct SonMesaj {
    
    let mesaj : String
    let kullaniciID : String
    let kullaniciAdi : String
    let goruntuURL : String
    let timestamp : Timestamp
    
    init(veri : [String : Any]) {
        
        
        mesaj = veri["Mesaj"]  as? String ?? ""
        kullaniciID = veri["KullaniciID"] as? String ?? ""
        kullaniciAdi = veri["KullaniciAdi"] as? String ?? ""
        goruntuURL = veri["GoruntuURL"] as? String ?? ""
        timestamp = veri["Timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
    }
}


class SonMesajCell : ListeCell<SonMesaj> {
    
    let imgProfilGoruntu = UIImageView(image: #imageLiteral(resourceName: "kisi4"), contentMode: .scaleAspectFill)
    
    let lblKullaniciAdi = UILabel(text: "Selim", font: .boldSystemFont(ofSize: 19))
    
    let lblSonMesaj = UILabel(text: "Bugün hava çok güzel. Dışarı çıkıp bir şeyler yiyelim mi?", font: .systemFont(ofSize: 16), textColor: .gray,numberOfLines: 2)
    
    override func viewleriOlustur() {
        super.viewleriOlustur()
        
        
        let goruntuBoyut : CGFloat = 100
        imgProfilGoruntu.layer.cornerRadius = goruntuBoyut / 2
        
        
        yatayStackViewOlustur(imgProfilGoruntu.boyutlandir(.init(width: goruntuBoyut, height: goruntuBoyut)),
                              stackViewOlustur(lblKullaniciAdi,lblSonMesaj,spacing: 4),spacing: 20,alignment: .center)
            .padLeft(20).padRight(20)
        
        ayracEkle(leadingAnchor: lblKullaniciAdi.leadingAnchor)
    }
    
    
    override var veri: SonMesaj! {
        didSet {
            //backgroundColor = veri
            lblKullaniciAdi.text = veri.kullaniciAdi
            lblSonMesaj.text = veri.mesaj
            imgProfilGoruntu.sd_setImage(with: URL(string: veri.goruntuURL))
        }
    }
    
}






class EslesmelerMesajlarController : ListeHeaderController<SonMesajCell,SonMesaj,EslesmeHeader>, UICollectionViewDelegateFlowLayout {
    
    
    // String key ifadesi mesajlaşılan kişinin KullanıcıID değerini temsil
    //Value değeri olan SonMesaj değeri ise o kişiyle aramızdaki son mesaj değerleri
    var sonMesajlarSozluk = [String : SonMesaj]()
    fileprivate func sonMesajlariGetir() {
        
        guard let gecerliKullaniciID = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("Eslesmeler_Mesajlar").document(gecerliKullaniciID).collection("Son_Mesajlar").addSnapshotListener { (querySnapshot, hata) in
            
            
            if let hata = hata {
                print("Kullanıcıya ait son mesajlar getirilemedi : ",hata)
                return
            }
            
            
            querySnapshot?.documentChanges.forEach({ (degisiklik) in
                
                // Yeni bir veri eklendiyse
                if degisiklik.type == .added || degisiklik.type == .modified {
                    let eklenenSonMesaj = degisiklik.document.data()
                    //self.veriler.append(.init(veri: eklenenSonMesaj))
                    let sonMesaj  =  SonMesaj(veri: eklenenSonMesaj)
                    self.sonMesajlarSozluk[sonMesaj.kullaniciID] = sonMesaj // eğer güncellenirse yeni veri eklenmeyecek. var olan veri güncellenecek
                }
            })
            self.verileriSifirla()
        }
    }
    
    fileprivate func verileriSifirla() {
        
        let sonMesajlarDizi = Array(sonMesajlarSozluk.values)
        //veriler = sonMesajlarDizi
        veriler = sonMesajlarDizi.sorted(by: { (mesaj1, mesaj2) -> Bool in
            return mesaj1.timestamp.compare(mesaj2.timestamp) == .orderedDescending
        })
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func headerAyarla(_ header :  EslesmeHeader) {
        //EslesmelerYatayController içerisindeki referans olarak EslesmelerMesajlarController atandı
        header.eslesmelerYatayController.rootEslesmelerMesajlarController = self
    }
    //bu metod EslesmelerYatayController'da referans aracılığıyla çağrılacak
    func headerEslesmeSecimi(eslesme : Eslesme ){
        //print("Seçilen Eşleşme : ",eslesme.kullaniciAdi)
        let mesajKC = MesajKayitController(eslesme: eslesme)
        navigationController?.pushViewController(mesajKC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    
    let navBar = EslesmelerNavBar()
    
    // hücrenin boyutunu ayarlar
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 145)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sonMesajlariGetir()
        veriler = [ ]
        
        
         
        gorunumuOlustur()
        
        
        
    }
    
    fileprivate func gorunumuOlustur() {
        navBar.btnGeri.addTarget(self, action: #selector(btnGeriPressed), for: .touchUpInside)
        collectionView.backgroundColor = .white
        view.addSubview(navBar)
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, boyut: .init(width: 0, height: 150))
        
        collectionView.contentInset.top = 150
        collectionView.verticalScrollIndicatorInsets.top = 150
        
        
        let statusBarOrtu = UIView(arkaPlanRenk: .white)
        view.addSubview(statusBarOrtu)
        statusBarOrtu.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func btnGeriPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}


