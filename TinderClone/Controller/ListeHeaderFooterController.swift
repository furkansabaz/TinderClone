//
//  ListeHeaderFooterController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit



open class ListeHeaderFooterController <T : ListeCell<U> , U, H : UICollectionReusableView, F: UICollectionReusableView>  : UICollectionViewController {
    
    
    var veriler = [U]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate let cellId = "cellId"
    fileprivate let ekViewId = "ekViewId"
    
    func hucreYuksekliginiAyarla(indexPath : IndexPath, cellGenislik : CGFloat) -> CGFloat {
        let cell = T()
        let fazlaYukseklik : CGFloat = 1000
        
        cell.frame = .init(x: 0, y: 0, width: cellGenislik, height: fazlaYukseklik)
        
        cell.veri = veriler[indexPath.row]
        cell.layoutIfNeeded()
        return cell.systemLayoutSizeFitting(.init(width: cellGenislik, height: fazlaYukseklik)).height
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(T.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(H.self, forCellWithReuseIdentifier: UICollectionView.elementKindSectionHeader)
    
        collectionView.register(F.self, forCellWithReuseIdentifier: UICollectionView.elementKindSectionFooter)
    }
    
    override open func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! T
        
        cell.veri = veriler[indexPath.row]
        cell.eklenecekController = self
        return cell
    }
    
    open func headerAyarla() {
        
    }
    
    open func footerAyarla() {
        
    }
    
    open override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let ekView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ekViewId, for: indexPath)
        
        if let _ = ekView as? H {
            headerAyarla()
        } else if let _ = ekView as? F {
            footerAyarla()
        }
        return ekView
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return veriler.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        view.layer.zPosition = -1
    }

    public init(scrollYonu : UICollectionView.ScrollDirection = .vertical) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollYonu
        
        super.init(collectionViewLayout: layout)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
