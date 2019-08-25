//
//  AyarlarController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 24.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage

class AyarlarController: UITableViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    
    
    func butonOlustur(selector : Selector) -> UIButton {
        
        let buton = UIButton(type: .system)
        buton.layer.cornerRadius = 10
        buton.clipsToBounds = true
        buton.backgroundColor = .white
        buton.setTitle("Fotoğraf Seç", for: .normal)
        
        buton.addTarget(self, action: selector, for: .touchUpInside)
        return buton
    }
    
    
    lazy var btnGoruntu1Sec = butonOlustur(selector: #selector(btnGoruntuSecPressed))
    lazy var btnGoruntu2Sec = butonOlustur(selector: #selector(btnGoruntuSecPressed))
    lazy var btnGoruntu3Sec = butonOlustur(selector: #selector(btnGoruntuSecPressed))
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationOlustur()
        tableView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        kullaniciBilgileriniGetir()
        
    }
    var gecerliKullanici : Kullanici?
    fileprivate func kullaniciBilgileriniGetir() {
        
        guard let uid = Auth.auth().currentUser?.uid  else {return}
        
        Firestore.firestore().collection("Kullanicilar").document(uid).getDocument { (snapshot, hata) in
            
            if let hata = hata {
                print("Kullanıcı Bilgileri Getirilirken Hata Meydana Geldi : \(hata)")
                return
            }
            
            guard let bilgiler = snapshot?.data() else { return }
            self.gecerliKullanici = Kullanici(bilgiler: bilgiler)
            
            self.profilGoruntuleriniYukle()
            self.tableView.reloadData()
            
        }
        
    }
    
    
    
    fileprivate func profilGoruntuleriniYukle(){
        if let goruntuURL = gecerliKullanici?.goruntuURL1, let url = URL(string: goruntuURL)  {
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (goruntu, _, _, _, _, _) in
                
                self.btnGoruntu1Sec.setImage(goruntu?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        if let goruntuURL = gecerliKullanici?.goruntuURL2, let url = URL(string: goruntuURL)  {
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (goruntu, _, _, _, _, _) in
                
                self.btnGoruntu2Sec.setImage(goruntu?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        
        if let goruntuURL = gecerliKullanici?.goruntuURL3, let url = URL(string: goruntuURL)  {
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (goruntu, _, _, _, _, _) in
                
                self.btnGoruntu3Sec.setImage(goruntu?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        
    }
    
    
   
    
    
    
    @objc fileprivate func btnGoruntuSecPressed(buton : UIButton) {
        
        let imagePicker = CustomImagePickerController()
        imagePicker.btnGoruntuSec = buton
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let secilenGoruntu = info[.originalImage] as? UIImage
        let btnGoruntuSec = (picker as? CustomImagePickerController)?.btnGoruntuSec
        btnGoruntuSec?.setImage(secilenGoruntu?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnGoruntuSec?.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true)
        
        let goruntuAdi = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/Goruntuler/\(goruntuAdi)")
        
        guard let veri = secilenGoruntu?.jpegData(compressionQuality: 0.8) else { return }
        
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Görüntü Yükleniyor..."
        hud.show(in: view)
        
        ref.putData(veri, metadata: nil) { (nil, hata) in
            if let hata = hata {
                hud.dismiss()
                print("Görüntü Yüklenirken Hata Oluştu : \(hata)")
                return
            }
            print("Görüntü Başarıyla Yüklendi")
            
            ref.downloadURL { (url, hata) in
                hud.dismiss()
                if let hata = hata {
                    print("URL Alınamadı")
                    return
                }
                print("URL Başarıyla Alındı : \(url?.absoluteString ?? "")")
                
                if btnGoruntuSec == self.btnGoruntu1Sec {
                    self.gecerliKullanici?.goruntuURL1 = url?.absoluteString
                } else if btnGoruntuSec == self.btnGoruntu2Sec {
                    self.gecerliKullanici?.goruntuURL2 = url?.absoluteString
                } else {
                    self.gecerliKullanici?.goruntuURL3 = url?.absoluteString
                }
            }
        }
        
        
    }
    
    lazy var fotoAlan : UIView = {
       let fotoAlan = UIView()
        
        
        fotoAlan.addSubview(btnGoruntu1Sec)
        
        _ = btnGoruntu1Sec.anchor(top: fotoAlan.topAnchor,
                                  bottom: fotoAlan.bottomAnchor,
                                  leading: fotoAlan.leadingAnchor,
                                  trailing: nil,
                                  padding: .init(top: 15, left: 15, bottom: 15, right: 0))
        
        btnGoruntu1Sec.widthAnchor.constraint(equalTo: fotoAlan.widthAnchor, multiplier: 0.42).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [btnGoruntu2Sec,btnGoruntu3Sec])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        fotoAlan.addSubview(stackView)
        
        _ = stackView.anchor(top: fotoAlan.topAnchor,
                             bottom: fotoAlan.bottomAnchor,
                             leading: btnGoruntu1Sec.trailingAnchor,
                             trailing: fotoAlan.trailingAnchor,
                             padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        return fotoAlan
    }()
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return fotoAlan
        }
        
        let lblBaslik = LabelBaslik()
        
        
        switch section {
        case 1 :
                lblBaslik.text = "Ad Soyad"
        case 2 :
                lblBaslik.text = "Yaş"
        case 3 :
                lblBaslik.text = "Meslek"
        case 4 :
                lblBaslik.text = "Hakkında"
        case 5 :
            lblBaslik.text = "Yaş Aralığı"
        default :
            lblBaslik.text = "Hakkında"
        }
        lblBaslik.font = UIFont.boldSystemFont(ofSize: 16)
        return lblBaslik
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 320
        }
        return 45
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           return 6
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 0 : 1
    }
    @objc fileprivate func minYasSliderChanged(slider : UISlider) {
        minMaksAyarla()
    }
    @objc fileprivate func maksYasSliderChanged(slider : UISlider) {
        minMaksAyarla()
    }
    
    fileprivate func minMaksAyarla() {
        
        guard let yasAralikcell = tableView.cellForRow(at: [5,0]) as? YasAralikCell else { return }
        
        let minDeger = Int(yasAralikcell.minSlider.value)
        var maksDeger = Int(yasAralikcell.maksSlider.value)
        
        maksDeger = max(minDeger,maksDeger)
        
        yasAralikcell.maksSlider.value = Float(maksDeger)
        
        yasAralikcell.lblMin.text = "Min \(minDeger)"
        yasAralikcell.lblMaks.text = "Maks \(maksDeger)"
        
        gecerliKullanici?.arananMinYas = minDeger
        gecerliKullanici?.arananMaksYas = maksDeger
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 5 {
            let yasAralikCell = YasAralikCell(style: .default, reuseIdentifier: nil)
            
            yasAralikCell.minSlider.addTarget(self, action: #selector(minYasSliderChanged), for: .valueChanged)
            yasAralikCell.maksSlider.addTarget(self, action: #selector(maksYasSliderChanged), for: .valueChanged)
            
            yasAralikCell.lblMin.text = "Min \(gecerliKullanici?.arananMinYas ?? 18)"
            yasAralikCell.lblMaks.text = "Maks \(gecerliKullanici?.arananMaksYas ?? 18)"
            
            yasAralikCell.minSlider.value = Float(gecerliKullanici?.arananMinYas ?? 18)
            yasAralikCell.maksSlider.value = Float(gecerliKullanici?.arananMaksYas ?? 18)
            
            
            return yasAralikCell
        }
        
        
        let cell = AyarlarCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 1 :
            cell.textField.placeholder = "Adınız ve Soyadınız"
            cell.textField.text = gecerliKullanici?.kullaniciAdi
            cell.textField.addTarget(self, action: #selector(txtAdiDegisiklikYakala), for: .editingChanged)
        case 2 :
            cell.textField.placeholder = "Yaşınız"
            cell.textField.keyboardType = .numberPad
            if let yasi = gecerliKullanici?.yasi {
                cell.textField.text = String(yasi)
            }
            cell.textField.addTarget(self, action: #selector(txtYasiDegisiklikYakala), for: .editingChanged)
        case 3 :
            cell.textField.placeholder = "Mesleğiniz"
            cell.textField.text = gecerliKullanici?.meslek
            cell.textField.addTarget(self, action: #selector(txtMeslekDegisiklikYakala), for: .editingChanged)
        case 4 :
            cell.textField.placeholder = "Kendinizden Bahsedin"
        default :
            cell.textField.placeholder = "Kendinizden Bahsedin"
        }
        return cell
    }
    
    @objc fileprivate func txtAdiDegisiklikYakala(textField : UITextField) {
        self.gecerliKullanici?.kullaniciAdi = textField.text
    }
    
    @objc fileprivate func txtYasiDegisiklikYakala(textField : UITextField) {
        self.gecerliKullanici?.yasi = Int(textField.text ?? "")
    }
    
    @objc fileprivate func txtMeslekDegisiklikYakala(textField : UITextField) {
        self.gecerliKullanici?.meslek = textField.text
    }
    fileprivate func navigationOlustur() {
        navigationItem.title = "Ayarlar"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(btnIptalPressed))
        
        
        
        navigationItem.rightBarButtonItems = [
        UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(btnKaydetPressed)),
        UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(btnCikisPressed))
        ]
    }

    @objc fileprivate func btnKaydetPressed() {
         
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let veriler : [String : Any] = [
            "KullaniciID" : uid,
            "AdiSoyadi" : gecerliKullanici?.kullaniciAdi ?? "",
            "GoruntuURL" :  gecerliKullanici?.goruntuURL1 ?? "",
            "GoruntuURL2" :  gecerliKullanici?.goruntuURL2 ?? "",
            "GoruntuURL3" :  gecerliKullanici?.goruntuURL3 ?? "",
            "Yasi" : gecerliKullanici?.yasi ?? -1,
            "Meslek" : gecerliKullanici?.meslek ?? "",
            "ArananMinYas" : gecerliKullanici?.arananMinYas ?? -1,
            "ArananMaksYas" : gecerliKullanici?.arananMaksYas ?? -1
        ]
        
        
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Bilgileriniz Kaydediliyor"
        hud.show(in: view)
        
        Firestore.firestore().collection("Kullanicilar").document(uid).setData(veriler) { (hata) in
            hud.dismiss()
            if let hata = hata {
                print("Kullanıcı verileri kaydedilirken hata meydana geldi : \(hata)")
                return
            }
            print("Kullanıcı Verileri Başarılı Bir Şekilde Kaydedildi")
        }

        
        
    }
    @objc fileprivate func btnCikisPressed() {
        print("Oturumunuz Kapatılacaktır")
    }
    @objc fileprivate func btnIptalPressed() {
        dismiss(animated: true)
    }
    

}


class CustomImagePickerController : UIImagePickerController {
    var btnGoruntuSec : UIButton?
}

class LabelBaslik : UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 15, dy: 0))
    }
}
