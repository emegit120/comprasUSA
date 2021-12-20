import UIKit

final class AjustesViewController: UIViewController {

    @IBOutlet weak var TextFieldDolar: UITextField!
    @IBOutlet weak var TextFieldIOF: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCotacoes()
    }
    
    private func loadCotacoes(){
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Cotacoes", withExtension: "json"),
        let data = try? Data(contentsOf: url)
            else {return}

        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let cotacoes = try jsonDecoder.decode(Cotacoes.self, from: data)
            TextFieldDolar.text = cotacoes.Dolar
            TextFieldIOF.text = cotacoes.IOF
        }catch{
            print(error)
        }
    }
    
    @IBAction func AddState(_ sender: UIButton){
        
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
