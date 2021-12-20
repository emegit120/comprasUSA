//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 19/12/21.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet weak var dolarTextField: UITextField!
    
    @IBOutlet weak var iofTextField: UITextField!
    let ud = UserDefaults.standard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    
    private func setupUI() {

        let dolar = ud.string(forKey: "dolar")
        dolarTextField.text = dolar
        
        let iof = ud.string(forKey: "iof")
        iofTextField.text = iof
    }

    @IBAction func addState(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Adicionar Estado", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do Estado"
            textField.text = ""
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Imposto"
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: ""), style: .default, handler: { _ in
            NSLog("O \"Cancelar\" alerta ocorreu")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Adicionar", comment: ""), style: .default, handler: { _ in
            NSLog("O \"Adicionar\" alerta ocorreu.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}




