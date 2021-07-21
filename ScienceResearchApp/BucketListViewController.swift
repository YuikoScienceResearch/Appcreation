//
//  BucketListViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 7/11/21.
//

import UIKit

class BucketListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Data Properties
    
    struct Category {
        let title: String
        let items: [String]
    }
    
    var groupsArray: Array<String> = []
    
    // MARK: - UI Properties
    
    let tableView: UITableView = {
        let tableView = UITableView (frame: .zero, style: .plain)
        tableView.rowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Method Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .systemBackground
        
        // Generate UI
        generateNavigationUI()
        generateTableView()
        
        groupsArray = ["Home", "Beach", "Cinema"]
    }
    
    // MARK: - UI Generation
    
    func generateNavigationUI() {
        title = "Bucket List"
        
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        navigationItem.setRightBarButton(addButton, animated: false)
        
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))
        navigationItem.setLeftBarButton(editButton, animated: false)
    }
    
    
    func generateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        
        view.addSubview(tableView)
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
        
    }
    
    //MARK: - Button Actions
    
    @objc func addAction() {
        let alert = UIAlertController(title: "Add a group", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            let string = alert.textFields![0].text! as String
            if string.count == 0 {
                return
            }
            self.groupsArray.append(string)
            self.tableView.reloadData()
        }))
        alert.addTextField(configurationHandler: nil)
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }

    // MARK: - UITableView Datasource & Delegate
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))!
        cell.textLabel?.text = groupsArray[indexPath.row].capitalized
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let items = groupsArray[indexPath.row]
        let vc = BLPushtheStackViewController (selectedItem: items, relatedItems: [items])
        navigationController?.pushViewController (vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = groupsArray[sourceIndexPath.item]
        groupsArray.remove(at: sourceIndexPath.item)
        groupsArray.insert(movedObjTemp, at: destinationIndexPath.item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            groupsArray.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
