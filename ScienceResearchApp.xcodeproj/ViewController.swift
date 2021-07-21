//
//  ViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 7/1/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Data Properties
    
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
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
        // Generate UI
        generateNavigationUI()
        generateTableView()
        
        groupsArray = ["Family", "Friends"]
    }
    
    // MARK: - UI Generation
    
    func generateNavigationUI() {
        title = "BucketApp"
        
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
    
    @objc func editAction() {
        tableView.setEditing(true, animated: true)
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
    }
}
