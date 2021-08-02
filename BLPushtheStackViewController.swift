//
//  BLPushtheStackViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 7/20/21.
//

import UIKit
import GoogleMaps

class BLPushtheStackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Data Properties
    
    struct Category {
        let title: String
        let items: [String]
    }
    
    var groupsArray: Array<String> = []
    
    private let selectedItem: String
    private let relatedItems: [String]
    
    init(selectedItem: String, relatedItems: [String]) {
        self.selectedItem = selectedItem
        self.relatedItems = relatedItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        title = selectedItem
        
        let label = UILabel(frame: view.bounds)
        view.addSubview(label)
        label.textAlignment = .center
        label.numberOfLines = -1
        for item in relatedItems {
            label.text = (label.text ?? "") + " " + item
        }
        
        // Generate UI
        generateNavigationUI()
        generateTableView()
    }
    
    // MARK: - UI Generation
    
    func generateNavigationUI() {
        title = selectedItem
        
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        navigationItem.setRightBarButton(addButton, animated: false)

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
        GMSServices.provideAPIKey("AIzaSyBmVrQAyaovzItknfgimlR4ukqogO3W-uU")
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
             let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
             view.addSubview(mapView)

             let marker = GMSMarker()
             marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
             marker.title = "Sydney"
             marker.snippet = "Australia"
             marker.map = mapView
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
