//
//  ViewController.swift
//  100 Days Of Swift-Challenge Project 2
//
//  Created by Arda Büyükhatipoğlu on 23.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearTapped))
        navigationItem.rightBarButtonItems = [add,share]
        
    }
    
    //Add new Item to the shopping list
    @objc func addTapped() {
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Enter Here"
        }
        let submitAction = UIAlertAction(title: "Add Item", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            
            if answer == "" {
                return
            }
            
            self?.shoppingList.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    //Share your list
    @objc func actionTapped() {
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
        present(vc, animated: true)
    }
    
    //Delete all items
    @objc func clearTapped() {
        let ac = UIAlertController(title: "Are you sure?", message: "You are about to delete all the items from your list", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            self?.shoppingList.removeAll()
            self?.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    //MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Delete the item at tapped row
        let deleteIndex = IndexPath(row: indexPath.row, section: indexPath.section)
        shoppingList.remove(at: deleteIndex.row)
        tableView.deleteRows(at: [deleteIndex], with: .automatic)
    }
}

