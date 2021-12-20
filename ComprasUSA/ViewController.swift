//
//  ViewController.swift
//  ComprasUSA
//
//  Created by 3x on 09/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }

}

class ListaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

extension ListaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
    
}


class ComprasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }

}
