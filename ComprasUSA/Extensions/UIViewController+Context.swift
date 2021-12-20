//
//  UIViewController+Context.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 17/12/21.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }
}
