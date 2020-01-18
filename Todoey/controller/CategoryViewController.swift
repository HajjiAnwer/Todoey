//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mehdi on 17/01/2020.
//  Copyright © 2020 Mehdi. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    //Mark : - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    //Mark : - Data manipulation
    
    //Mark : - Add new Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textCategory = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textCategory.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new category"
            textCategory = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //Mark : - TableView delegate method:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    //save the Category
    func saveCategory()  {
        do{
           try context.save()
        }catch{
            print("error saving context \(error)")
        }
        tableView.reloadData()
    }
    //load data from the datasource
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do{
           categoryArray = try context.fetch(request)
        }catch{
            print("error fetching context \(error)")
        }
    }
}
