//
//  StateViewController.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 19/12/21.
//

import UIKit
import CoreData

protocol StateDelegate: AnyObject {
    func setSelectedState(_ states: Set<State>)
}


class StateTableViewController: UITableViewController {
    
    lazy var fetchedResultsController: NSFetchedResultsController<State> = {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    var states: [State] = []
    weak var delegate: StateDelegate?
    var selectedState: Set<State> = [] {
        didSet {
            delegate?.setSelectedState(selectedState)
        }
    }
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        return label
    }()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStates()
    }

    // MARK: - Methods
    private func loadStates() {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            states = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func showStateAlert(for state: State? = nil) {
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Adicionar Estado"
            textField.text = state?.name
        }
        alert.addTextField { textField in
            textField.placeholder = "Imposto"
            textField.text = state?.tax
        }
        let okAction = UIAlertAction(title: title, style: .default) { _ in
            let state = state ?? State(context: self.context)
            state.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadStates()
            } catch {
                
            }
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = fetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = rows == 0 ? label : nil
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stateCell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)

        let state = states[indexPath.row]
        stateCell.textLabel?.text = state.name
        stateCell.accessoryType = selectedState.contains(state) ? .checkmark : .none
        return stateCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = self.states[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark
            selectedState.insert(state)
        } else {
            cell?.accessoryType = .none
            selectedState.remove(state)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Excluir") { (action, view, completionHandler) in
            let state = self.states[indexPath.row]
            self.context.delete(state)
            do {
                try self.context.save()
            } catch {
                
            }
            self.states.remove(at: indexPath.row)
            self.selectedState.remove(state)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Editar") { (action, view, completionHandler) in
            let state = self.states[indexPath.row]
            self.showStateAlert(for: state)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    // MARK: - IBActions
    @IBAction func add(_ sender: UIBarButtonItem) {
        showStateAlert()
    }
    
}

extension StateTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
