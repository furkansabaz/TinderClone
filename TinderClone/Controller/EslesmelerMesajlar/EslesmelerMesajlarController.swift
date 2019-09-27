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

// EslesmelerYatayController 'da temel amacımız eşleştiğimiz  profillerin listelenmesi
class EslesmelerYatayController : ListeController<EslesmeCell,Eslesme>, UICollectionViewDelegateFlowLayout {
    
    
    ///Hiyerarşide olan root controller'ın referansını tutalım
    var rootEslesmelerMesajlarController : EslesmelerMesajlarController?
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eslesme = veriler[indexPath.row]
        
        rootEslesmelerMesajlarController?.headerEslesmeSecimi(eslesme: eslesme)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 5, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: view.frame.height)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection  = .horizontal
        }
        eslesmeleriGetir() /// ListeController'a çekilen eşleşmeler görüntülenir
    }
}



class EslesmeHeader  : UICollectionReusableView {
    let lblYeniEslesmeler = UILabel(text: "Yeni Eşleşmeler", font: .boldSystemFont(ofSize: 19), textColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1))
    let eslesmelerYatayController = EslesmelerYatayController()
    let lblMesajlar = UILabel(text: "Mesajlar", font: .boldSystemFont(ofSize: 19), textColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
        stackViewOlustur(stackViewOlustur(lblYeniEslesmeler).padLeft(22),
                         eslesmelerYatayController.view,
                         stackViewOlustur(lblMesajlar).padLeft(22),
                         spacing: 22).withMarging(.init(top: 22, left: 0, bottom: 22, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class EslesmelerMesajlarController : ListeHeaderController<EslesmeCell,Eslesme,EslesmeHeader>, UICollectionViewDelegateFlowLayout {
    
    
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
