//
//  OturumController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import JGProgressHUD
class OturumController: UIViewController {

    
    var delegate : OturumControllerDelegate?
    fileprivate let oturumVM = OturumViewModel()
    fileprivate let oturumHUD = JGProgressHUD(style: .dark)
    
    let txtEmailAdresi : OzelTextField = {
        
        let txt = OzelTextField(padding: 24, yukseklik: 55)
        txt.backgroundColor = .white
        txt.keyboardType = .emailAddress
        txt.placeholder = "Email Adresiniz..."
        txt.addTarget(self, action: #selector(textDegislikKontrol), for: .editingChanged)
        return txt
    }()
    
    let txtParola : OzelTextField = {
        let txt = OzelTextField(padding: 24, yukseklik: 55)
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.placeholder = "Parolanız..."
        txt.addTarget(self, action: #selector(textDegislikKontrol), for: .editingChanged)
        return txt
    }()
    
    let btnOturumAc : UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Oturum Aç", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 22
        
        btn.backgroundColor = .lightGray
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        btn.addTarget(self, action: #selector(btnOturumAcPressed), for: .touchUpInside)
        return btn
    }()
    
    fileprivate let btnGeriGit : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Kayıt Sayfasına Git", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.addTarget(self, action: #selector(btnGeriGitPressed), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    lazy var dikeyStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
       txtEmailAdresi,
       txtParola,
       btnOturumAc
       ])
        stackView.axis = .vertical
        stackView.spacing = 10
       return stackView
    }()
    
    @objc fileprivate func btnGeriGitPressed() {
        navigationController?.popViewController(animated: true)
    }
    @objc fileprivate func btnOturumAcPressed() {
        oturumVM.oturumAc { (hata) in
            self.oturumHUD.dismiss()
            
            if let hata = hata {
                print("Oturum Açılırken Hata Meydana Geldi : \(hata)")
                return
            }
            print("Başarıyla Oturum Açıldı")
            //Sayfa Kapansın
            self.dismiss(animated: true)
            self.delegate?.oturumAcmaBitis()
        }
        
    }
    @objc fileprivate func textDegislikKontrol(textField : UITextField) {
        
        if textField == txtEmailAdresi {
            oturumVM.emailAdresi = textField.text
        } else {
            oturumVM.parola = textField.text
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arkaPlanGradientAyarla()
        bindableOlustur()
        layoutDuzenle()
        
    }
    
    fileprivate func bindableOlustur() {
        oturumVM.formGecerli.degerAta { (formGecerlimi) in
            
            guard let formGecerlimi = formGecerlimi else { return }
            
            self.btnOturumAc.isEnabled = formGecerlimi
            
            if formGecerlimi {
                self.btnOturumAc.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
                self.btnOturumAc.setTitleColor(.white, for: .normal)
            } else {
                self.btnOturumAc.backgroundColor = .lightGray
                self.btnOturumAc.setTitleColor(.darkGray, for: .disabled)
            }
            
        }
        
        
        oturumVM.oturumAciliyor.degerAta { (oturumAciliyor) in
            
            if oturumAciliyor == true {
                self.oturumHUD.textLabel.text = "Oturum Açılıyor"
                self.oturumHUD.show(in: self.view)
            } else {
                self.oturumHUD.dismiss()
            }
        }
    }
    

    let gradientLayer = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func arkaPlanGradientAyarla() {
        let ustRenk = #colorLiteral(red: 0.6392156863, green: 0.8, blue: 0.9568627451, alpha: 1)
        let altRenk = #colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.737254902, alpha: 1)
        
        gradientLayer.colors = [ustRenk.cgColor, altRenk.cgColor]
        gradientLayer.locations = [0,1]
        
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
        print("Gradient Çalıştı : \(view.bounds)")
        
    }
    
    fileprivate func layoutDuzenle() {
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(dikeyStackView)
        
        _ = dikeyStackView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                  padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        dikeyStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(btnGeriGit)
        
        _ = btnGeriGit.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
    }
    

}


protocol OturumControllerDelegate {
    func oturumAcmaBitis()
}
