//
//  DefaultItemsCollectionViewCell.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/8/23.
//

import UIKit

class DefaultItemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var defaultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }
}
