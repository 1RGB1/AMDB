//
//  CompanyCollectionViewCell.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/7/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit

class CompanyCollectionViewCell : UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionCellContentView: UIView!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    // MARK: - Functions
    func setCellContent(_ model: CompanyModel) {
        collectionCellContentView.setCornerByValue(cornerRadius: true, value: 40)
        collectionCellContentView.addShadow(color: UIColor.black, opacity: 0.3, radius: 2)
        
        Utilities.setImage(companyImageView, model.logo_path ?? "")
        companyNameLabel.text = model.name ?? ""
    }
}
