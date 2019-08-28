//
//  KullaniciDetaylariController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 26.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class KullaniciDetaylariController: UIViewController {

    
    var kullaniciViewModel : KullaniciProfilViewModel! {
        didSet {
            fotoGecisController.kullaniciViewModel = kullaniciViewModel
            lblBilgi.attributedText = kullaniciViewModel.attrString
            
        }
    }
    
    lazy var scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
        
    }()
    
    
    let fotoGecisController = FotoGecisController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    let lblBilgi : UILabel = {
        let lbl = UILabel()
        
        lbl.text = "Sibel Kara 40\nÖğretmen\nÖğrencilerimi çok severim"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnDetayKapat : UIButton = {
        let buton = UIButton(type: .system)
        buton.setImage(UIImage(named: "profilKapat")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buton.addTarget(self, action: #selector(tapGestureKapat), for: .touchUpInside)
        return buton
    }()
    
    fileprivate func layoutDuzenle() {
        view.addSubview(scrollView)
        scrollView.doldurSuperView()
        
        
        let fotoGecisView = fotoGecisController.view!
        scrollView.addSubview(fotoGecisView)
        fotoGecisView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        
        
        scrollView.addSubview(lblBilgi)
        _ = lblBilgi.anchor(top: fotoGecisView.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        scrollView.addSubview(btnDetayKapat)
        
        _  = btnDetayKapat.anchor(top: fotoGecisView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: -25, left: 0, bottom: 0, right: 25), boyut: .init(width: 50, height: 50))
    }
    
    fileprivate func butonOlustur(image : UIImage, selector : Selector) -> UIButton {
        let buton = UIButton(type: .system)
        
        buton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        buton.addTarget(self, action: selector, for: .touchUpInside)
        buton.imageView?.contentMode = .scaleAspectFill
        
        return buton
        
    }
    
    lazy var btnDislike = self.butonOlustur(image: UIImage(named: "kapat")!, selector: #selector(btnDislikePressed))
    
    lazy var btnSuperLike = self.butonOlustur(image: UIImage(named: "superLike")!, selector: #selector(btnSuperLikePressed))
    
    lazy var btnLike = self.butonOlustur(image: UIImage(named: "like")!, selector: #selector(btnLikePressed))
    
    @objc fileprivate func btnDislikePressed() {
        print("Dislike")
    }
    
    @objc fileprivate func btnSuperLikePressed() {
        print("SuperLike")
    }
    @objc fileprivate func btnLikePressed() {
        print("Like")
    }
    
    
    fileprivate func altButonlarKonumAyarla() {
        
        let sv = UIStackView(arrangedSubviews: [btnLike,btnSuperLike,btnDislike])
        sv.distribution = .fillEqually

        view.addSubview(sv)
        
        _ = sv.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), boyut: .init(width: 310, height: 85))
        
        sv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    fileprivate let ekYukseklik : CGFloat = 90
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let fotoGecisView = fotoGecisController.view!
        fotoGecisView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + ekYukseklik)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        layoutDuzenle()
        blurEfektOlustur()
        altButonlarKonumAyarla()
    }
    
    fileprivate func blurEfektOlustur() {
        let blurEffect = UIBlurEffect(style: .regular)
        
        let effectView = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(effectView)
        
        _ = effectView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
    
    @objc fileprivate func tapGestureKapat() {
        self.dismiss(animated: true)
    }
    


}

extension KullaniciDetaylariController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yFark = scrollView.contentOffset.y
        print("Y Fark : ",yFark)
        var width = view.frame.width - 2*yFark
        width = max(view.frame.width,width)
        
        
        let fotoGecisView = fotoGecisController.view!
        fotoGecisView.frame = CGRect(x: min(0,yFark), y: min(0,yFark), width: width, height: width + ekYukseklik)
        
    }
}
