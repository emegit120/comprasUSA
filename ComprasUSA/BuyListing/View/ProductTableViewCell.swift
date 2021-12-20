//
//  ProductTableViewCell.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 15/12/21.
//

import UIKit


class ProductTableViewCell : UITableViewCell {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var stateProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    
    func initiazeCell(with product: Product) {
        nameProduct.text = product.name
        priceProduct.text = product.priceFormatted
        imageProduct.image = product.imageProductExtension
        imageProduct.layer.cornerRadius = 6
    }
    
}
