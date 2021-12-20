//
//  ProductViewController.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 17/12/21.
//

import Foundation
import UIKit

final class ProductViewController : UIViewController{
    
    @IBOutlet weak var nameProductTextField: UITextField!
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceProductTextField: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var stateProduct: UITextField!
    
    @IBOutlet weak var cardOption: UISwitch!
    
    let states = ["Chicago","New York","Los Angeles", "Orlando"]
    
    var pickerView = UIPickerView()
    
    var product: Product?
    
  //  var selectedState: Set<State> = [] {
  //      didSet {
 //           if selectedState.count > 0 {
 //               stateProduct.text = selectedState.compactMap({$0.name}).first
  //          } else {
  //              stateProduct.text = "Estado da Compra"
 //           }
 //       }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        stateProduct.inputView = pickerView
        
        setupUI()
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    private func setupUI() {
        if let product = product {
            title = "Editar Produto"
            nameProductTextField.text = product.name
            priceProductTextField.text = "\(product.price)"

            btnRegister.setTitle("Alterar", for: .normal)
          
            
            productImageView.image = product.imageProductExtension
           
        }
    }
    
    private func selectPictureFrom(_ sourceType: UIImagePickerController.SourceType) {
        view.endEditing(true)
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func openSettings(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func cardSwitch(_ sender: UISwitch) {
        if sender.isOn{
            
        }else{
            
        }
        
    
    }
    
    
    @IBAction func selectState(_ sender: UITextField) {
        
    }
    
    
    @IBAction func saveProduct(_ sender: UIButton) {
        view.endEditing(true)
        if product == nil {
            product = Product(context: context)
        }
        product?.name = nameProductTextField.text
       
        product?.image = productImageView.image?.jpegData(compressionQuality: 0.8)
        
        product?.price = Double(priceProductTextField.text!) ?? 0
        
     //   product?.state = states.first
        
        product?.card = (cardOption != nil)

        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func imageSelectProduct(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Selecionar pôster", message: "De onde você deseja escolher o pôster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPictureFrom(.camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default) { _ in
            self.selectPictureFrom(.photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de Fotos", style: .default) { _ in
            self.selectPictureFrom(.savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
extension ProductViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
           
            productImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}

//extension ProductViewController: CategoriesDelegate {
 //   func setSelectedCategories(_ categories: Set<Category>) {
 //       selectedCategories = categories
 //   }
    
//}

extension ProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateProduct.text = states[row]
        stateProduct.resignFirstResponder()
    }
    
}
