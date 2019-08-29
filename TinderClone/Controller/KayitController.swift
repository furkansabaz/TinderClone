//
//  KayitController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 5.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
class KayitController: UIViewController {
    
    var delegate : OturumControllerDelegate? 
    
    let btnFotografSec : UIButton = {
        
        let btn = UIButton(type: .system)
        
        btn.setTitle("Fotoğraf Seç", for: .normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        
        btn.setTitleColor(.black, for: .normal)
        
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        
        btn.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        btn.addTarget(self, action: #selector(btnFotografSecPressed), for: .touchUpInside)
        
        btn.imageView?.contentMode = .scaleAspectFill
        btn.clipsToBounds = true
        return btn
    }()
    
    
    let txtEmailAdresi : OzelTextField = {
        
        let txt =  OzelTextField(padding: 15,yukseklik : 50)
        txt.backgroundColor = .white
        txt.placeholder = "Email Adresiniz"
        txt.keyboardType = .emailAddress
        txt.addTarget(self, action: #selector(yakalaTextFieldDegisim), for: .editingChanged)
        return txt
    }()
    
    let txtAdiSoyadi : OzelTextField = {
        
        let txt = OzelTextField(padding: 15,yukseklik : 50)
        
        txt.backgroundColor = .white
        txt.placeholder = "Ad ve Soyad"
        txt.addTarget(self, action: #selector(yakalaTextFieldDegisim), for: .editingChanged)
        
        return txt
        
    }()
    
    
    let txtParola : OzelTextField = {
        
        let txt = OzelTextField(padding: 15,yukseklik : 50)
        
        txt.backgroundColor = .white
        txt.placeholder = "Parolanız"
        txt.isSecureTextEntry = true
        txt.addTarget(self, action: #selector(yakalaTextFieldDegisim), for: .editingChanged)
        return txt
    }()
    
    let btnKayitOl : UIButton = {
        
        let btn = UIButton(type: .system)
        
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        btn.layer.cornerRadius = 22
        
        btn.setTitle("Kayıt Ol", for: .normal)
        //btn.setTitleColor(.white, for: .normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        //btn.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.darkGray, for: .disabled)
        btn.isEnabled = false
        
        btn.addTarget(self, action: #selector(btnKayitOlPressed), for: .touchUpInside)
        
        return btn
    }()
    
    let btnOturumAcGit : UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Oturum Aç", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        
        btn.addTarget(self, action: #selector(btnOturumAcGitPressed), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        arkaPlanGradientAyarla()
        //view.backgroundColor = .gray
        layoutDuzenle()
        
        olusturNotificationObserver()
        
        ekleTapGesture()
        
        
        olusturKayitViewModelObserver()
    }
    
    let kayitViewModel = KayitViewModel()
    
    fileprivate func olusturKayitViewModelObserver() {
        
        kayitViewModel.bindableKayitVerileriGecerli.degerAta { (gecerli) in
            
            guard let gecerli = gecerli else { return }
            self.btnKayitOl.isEnabled = gecerli
            
            if gecerli {
                self.btnKayitOl.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
                self.btnKayitOl.setTitleColor(.white, for: .normal)
            } else {
                self.btnKayitOl.backgroundColor = .lightGray
                self.btnKayitOl.setTitleColor(.darkGray, for: .disabled)
            }
        }
        
        
        kayitViewModel.bindableImg.degerAta { (imgProfil) in
            self.btnFotografSec.setImage((imgProfil)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        kayitViewModel.bindableKayitOluyor.degerAta { (kayitOluyor) in
            
            if kayitOluyor == true {
                self.kayitHUD.textLabel.text = "Hesap Oluşturuluyor"
                self.kayitHUD.show(in: self.view)
            } else {
                self.kayitHUD.dismiss()
            }
        }
    }
    
    @objc fileprivate func yakalaTextFieldDegisim(textField : UITextField) {
        
        if textField == txtEmailAdresi {
            kayitViewModel.emailAdresi = textField.text
        } else if textField == txtAdiSoyadi {
            kayitViewModel.adiSoyadi = textField.text
        } else if textField == txtParola {
            kayitViewModel.parola = textField.text
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func ekleTapGesture() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(klavyeKapat)))
        
    }
    @objc fileprivate func klavyeKapat() {
        
        self.view.endEditing(true)
        
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
        
    }
    
    fileprivate func olusturNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeGosteriminiYakala), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeGizlenmesiniYakala), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func klavyeGizlenmesiniYakala(notification : Notification) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    @objc fileprivate func klavyeGosteriminiYakala(notification : Notification) {
        
        guard let klavyeBitisDegerleri = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return}
        
        let klavyeBitisFrame = klavyeBitisDegerleri.cgRectValue
        
        
        
        let altBoslukMiktari = view.frame.height - (kayitSV.frame.origin.y + kayitSV.frame.height)
        
        
        
        let hataPayi = klavyeBitisFrame.height - altBoslukMiktari
        
        if hataPayi < 0 {
            return
        }
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -hataPayi-10)
        
        
    }
    
    lazy var dikeySV : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            txtEmailAdresi,
            txtAdiSoyadi,
            txtParola,
            btnKayitOl
        ])
        
        sv.axis = .vertical
        
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
        
    }()
    
    lazy var kayitSV = UIStackView(arrangedSubviews: [
        btnFotografSec,
        dikeySV
    ])
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if self.traitCollection.verticalSizeClass == .compact {
            kayitSV.axis = .horizontal
        } else {
            kayitSV.axis = .vertical
        }
        
    }
    fileprivate func layoutDuzenle() {
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(kayitSV)
        
        kayitSV.axis = .vertical
        btnFotografSec.widthAnchor.constraint(equalToConstant: 260).isActive = true
        
        kayitSV.spacing = 10
        _ = kayitSV.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 45, bottom: 0, right: 45))
        
        kayitSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.addSubview(btnOturumAcGit)
        
        _ =  btnOturumAcGit.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gradient.frame = view.bounds
        
    }
    let gradient = CAGradientLayer()
    fileprivate func arkaPlanGradientAyarla() {
        
        
        
        let ustRenk = #colorLiteral(red: 0.6392156863, green: 0.8, blue: 0.9568627451, alpha: 1)
        let altRenk = #colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.737254902, alpha: 1)
        
        gradient.colors = [ustRenk.cgColor, altRenk.cgColor]
        
        gradient.locations = [0,1]
        
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
        print("Gradient Çalıştı : \(view.bounds)")
        
    }
    
    
    let kayitHUD = JGProgressHUD(style: .dark)
    @objc fileprivate func btnKayitOlPressed() {
        
        self.klavyeKapat()
        
        
        kayitViewModel.kullaniciKayitGerceklestir { (hata) in
            
            if let hata = hata {
                self.hataBilgilendirHUD(hata: hata)
                return
            }
            print("Kayıt Başarıyla Tamamlandı")
        }
         
    }
    
    fileprivate func hataBilgilendirHUD(hata : Error) {
        let hud = JGProgressHUD(style: .dark)
        
        hud.textLabel.text = "Kayıt İşlemi Başarısız"
        
        hud.detailTextLabel.text = hata.localizedDescription
        
        hud.show(in: self.view)
        
        hud.dismiss(afterDelay: 2, animated: true)
    }
    
    @objc fileprivate func btnFotografSecPressed() {
        let imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        
        present(imgPickerController, animated: true, completion: nil)
    }
    
    @objc fileprivate func btnOturumAcGitPressed() {
        let oturumController = OturumController()
        oturumController.delegate = delegate
        navigationController?.pushViewController(oturumController, animated: true)
    }
    
    
}

extension KayitController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        
        let imgSecilen = info[.originalImage] as? UIImage
        
        kayitViewModel.bindableImg.deger = imgSecilen
        kayitViewModel.veriGecerliKontrol()
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
