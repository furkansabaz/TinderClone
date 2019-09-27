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


class EslesmeCell : ListeCell<Eslesme> {
    
    let imgProfil =  UIImageView(image: UIImage(named: "kisi4"),contentMode: .scaleAspectFill)
    let lblKullaniciAdi = UILabel(text: "Sefa123", font: .systemFont(ofSize: 15, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 2)
    
    override var veri: Eslesme! {
        didSet {
            lblKullaniciAdi.text = veri.kullaniciAdi
            imgProfil.sd_setImage(with: URL(string: veri.profilGoruntuUrl))
        }
    }
    
    
    override func viewleriOlustur() {
        super.viewleriOlustur()
        
        imgProfil.clipsToBounds = true
        imgProfil.boyutlandir(.init(width: 80, height: 80))
        imgProfil.layer.cornerRadius = 40
        stackViewOlustur(stackViewOlustur(imgProfil,alignment: .center),lblKullaniciAdi)
    }
}



class EslesmelerMesajlarController : ListeController<EslesmeCell,Eslesme>, UICollectionViewDelegateFlowLayout {
    
    
    let navBar = EslesmelerNavBar()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: 125, height: 145)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eslesmeleriGetir()
         
        
        
        navBar.btnGeri.addTarget(self, action: #selector(btnGeriPressed), for: .touchUpInside)
        collectionView.backgroundColor = .white
        view.addSubview(navBar)
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, boyut: .init(width: 0, height: 150))
        
        collectionView.contentInset.top = 150
        
    }
    
    fileprivate func eslesmeleriGetir() {
        
        guard let gecerliKullaniciId  = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("Eslesmeler_Mesajlar").document(gecerliKullaniciId).collection("Eslesmeler").getDocuments { (snapshot, hata) in
            
            if let hata = hata {
                print("Eşleşme verileri Getirilemedi : ",hata)
            }
            
            print("Kullanıcının Eşleşme Verileri Getirildi : ")
            
            
            var eslesmeler = [Eslesme]()
            
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let veri = documentSnapshot.data()
                eslesmeler.append(.init(veri: veri))
            })
            self.veriler = eslesmeler
            self.collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func btnGeriPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension EslesmelerMesajlarController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let eslesme = veriler[indexPath.item]
        let mesajKayitController = MesajKayitController(eslesme: eslesme)
        navigationController?.pushViewController(mesajKayitController, animated: true)
    }
    
}
