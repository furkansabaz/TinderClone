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


class SonMesajCell : ListeCell<UIColor> {
    
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
    
    
    override var veri: UIColor! {
        didSet {
            //backgroundColor = veri
        }
    }
    
}






class EslesmelerMesajlarController : ListeHeaderController<SonMesajCell,UIColor,EslesmeHeader>, UICollectionViewDelegateFlowLayout {
    
    
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
        
        
        veriler = [.systemPink,
                   .brown,
                   .red,
                   .blue]
        
        
         
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


