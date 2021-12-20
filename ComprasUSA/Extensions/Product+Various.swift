//
//  Product+Various.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 17/12/21.
//

import Foundation
import UIKit

extension Product {
    var priceFormatted: String {
        "U$ \(price)"
    }
    
    var imageProductExtension: UIImage? {
        if let data = image {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
