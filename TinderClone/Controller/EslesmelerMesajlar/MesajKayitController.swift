//
//  MesajKayitController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit
import Firebase






class MesajKayitController : ListeController<MesajCell,Mesaj>{
    
    fileprivate lazy var navBar = MesajNavBar(eslesme: eslesme)
    fileprivate let navBarYukseklik : CGFloat = 125
    
    fileprivate let eslesme : Eslesme
    
    init(eslesme : Eslesme) {
        self.eslesme = eslesme
        super.init()
    }
    
    class KlavyeView : UIView {
        
        let txtMesaj = UITextView()
         let btnGonder = UIButton(baslik: "Gönder", baslikRenk: .black, baslikFont: .boldSystemFont(ofSize: 17))
        let lblPlaceholder = UILabel(text: "Mesajınızı Girin...", font: .systemFont(ofSize: 16), textColor: .lightGray)
        
        override var intrinsicContentSize: CGSize {
            return .zero
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
                   golgeEkle(opacity: 0.1, yaricap: 8, offset: .init(width: 0, height: -9), renk: .lightGray)
                   autoresizingMask = .flexibleHeight
                   
                   txtMesaj.text = ""
                   txtMesaj.isScrollEnabled = false
                   txtMesaj.font = .systemFont(ofSize: 17)
                   
            NotificationCenter.default.addObserver(self, selector: #selector(txtMesajDegisiklik), name: UITextView.textDidChangeNotification, object: nil)
                  
                   btnGonder.boyutlandir(.init(width: 65, height: 65))
                   

                   yatayStackViewOlustur(txtMesaj,
                                                  btnGonder.boyutlandir(.init(width: 65, height: 65)),
                                                  alignment: .center).withMarging(.init(top: 0, left: 15, bottom: 0, right: 15))
            
            
            addSubview(lblPlaceholder)
            lblPlaceholder.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: btnGonder.leadingAnchor)
            lblPlaceholder.centerYAnchor.constraint(equalTo: btnGonder.centerYAnchor).isActive = true
        }
        deinit {
            NotificationCenter.default.removeObserver(self)
            
        }
        
        @objc fileprivate func txtMesajDegisiklik() {
//            if txtMesaj.text.count == 0 {
//                lblPlaceholder.isHidden = false
//            } else {
//                lblPlaceholder.isHidden = true
//            }
            lblPlaceholder.isHidden = txtMesaj.text.count != 0
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    lazy var mesajGirisView : KlavyeView = {
        let mesajGirisView =  KlavyeView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        
        mesajGirisView.btnGonder.addTarget(self, action: #selector(btnGonderPressed), for: .touchUpInside)
        return mesajGirisView
    }()
    @objc fileprivate func btnGonderPressed() {
        print(mesajGirisView.txtMesaj.text ?? "Veri Yok")
        
        guard let gecerliKullaniciID = Auth.auth().currentUser?.uid else { return }
        
        let collection = Firestore.firestore().collection("Eslesmeler_Mesajlar").document(gecerliKullaniciID).collection(eslesme.kullaniciID)
        let eklenecekVeri = ["Mesaj" : mesajGirisView.txtMesaj.text ?? "",
                             "GondericiID" : gecerliKullaniciID,
                             "AliciID" : eslesme.kullaniciID,
        "Timestamp" : Timestamp(date: Date())] as [String : Any]
        
        collection.addDocument(data: eklenecekVeri) { (hata) in
            if let hata = hata {
                print("Mesaj Gönderilirken Hata Oluştu : ",hata)
                return
            }
            print("Mesaj Başarıyla Firestore'a Kaydedildi")
            self.mesajGirisView.txtMesaj.text = nil
            self.mesajGirisView.lblPlaceholder.isHidden = false
        }
        
        
        let collection2 = Firestore.firestore().collection("Eslesmeler_Mesajlar").document(eslesme.kullaniciID).collection(gecerliKullaniciID)
        
        collection2.addDocument(data: eklenecekVeri) { (hata) in
            if let hata = hata {
                print("Mesajlar Kaydedilirken Hata Meydana Geldi : ",hata)
                return
            }
            print("Mesajlar Başarıyla Kaydedildi")
            self.mesajGirisView.txtMesaj.text = nil
            self.mesajGirisView.lblPlaceholder.isHidden = false
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return mesajGirisView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeGosteriminiAyarla), name: UIResponder.keyboardDidShowNotification, object: nil)
        collectionView.keyboardDismissMode = .interactive
        navBar.btnGeri.addTarget(self, action: #selector(btnGeriPressed), for: .touchUpInside)
        
        mesajlariGetir()
        
       
        gorunumuOlustur()
    }
    @objc fileprivate func klavyeGosteriminiAyarla() {
        self.collectionView.scrollToItem(at: [0,veriler.count-1], at: .bottom, animated: true)
    }
    
    fileprivate func mesajlariGetir() {
        print("Mesajlar Getiriliyor")
        
        
        guard let gecerliKullaniciID = Auth.auth().currentUser?.uid else { return }
        let sorgu = Firestore.firestore().collection("Eslesmeler_Mesajlar").document(gecerliKullaniciID).collection(eslesme.kullaniciID).order(by: "Timestamp")
        
        sorgu.addSnapshotListener { (snapshot, hata) in
            if let hata = hata {
                print("Mesajlar Getirilemedi : ",hata)
                return
            }
            
            snapshot?.documentChanges.forEach({ (degisiklik) in
                
                if degisiklik.type == .added {
                    //değişikliğe uğramış kaydın verisini aldık
                    let mesajVerisi = degisiklik.document.data()
                    self.veriler.append(.init(mesajVerisi: mesajVerisi))
                }
                
            })
            //veriler dizisine tüm elemanlar kaydedildikten sonra bunu çağırmalıyız
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0,self.veriler.count-1], at: .bottom, animated: true)
        }
        
        
    }
    
    
    fileprivate func gorunumuOlustur() {
        view.addSubview(navBar)
               navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,boyut: .init(width: 0, height: navBarYukseklik))
               
               //collectionview hücrelerini belirtilen boşluktan itibaren oluşturmaya başlar.
               collectionView.contentInset.top = navBarYukseklik
               
               
               let statusBar = UIView(arkaPlanRenk: .white)
               view.addSubview(statusBar)
               statusBar.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
               
               collectionView.verticalScrollIndicatorInsets.top = navBarYukseklik
    }
    
    
    @objc fileprivate func  btnGeriPressed() {
        navigationController?.popViewController(animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MesajKayitController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let tahminiHucre = MesajCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        //mesaj içeriğini hücreye aktardık
        tahminiHucre.veri = self.veriler[indexPath.item]
        
        tahminiHucre.layoutIfNeeded()
        
        let tahminiBoyut = tahminiHucre.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: tahminiBoyut.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

