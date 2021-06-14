//
//  ViewController.swift
//  TableViewMultipleSelection
//
//  Created by Kavya KN on 10/02/21.
//  Copyright © 2021 Kavya K N. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrData = ["Apple", "Bag", "Cat", "Dog", "Doll", "Car", "Ant", "Flower", "Ring", "Rubber", "Friend"]
    var selectedArr = [String]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tblView.isEditing = true
        self.tblView.allowsMultipleSelectionDuringEditing = true
        self.searchBarSetUp()
    }
    
    func searchBarSetUp() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectDeselectData(tableview: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectData(tableview: tableView, indexPath: indexPath)
    }
    
    @IBAction func selectAllBtnClick(_ sender: UIButton) {
        self.selectedArr.removeAll()
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            for rowIndex in 0..<arrData.count {
                self.tblView.selectRow(at:IndexPath(row: rowIndex, section: 0), animated: true, scrollPosition: .none)
            }
            selectedArr = arrData
        } else {
            for rowIndex in 0..<arrData.count {
                self.tblView.deselectRow(at:IndexPath(row: rowIndex, section: 0), animated: true)
            }
            self.selectedArr.removeAll()
        }
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        print(selectedArr)
    }
    
}

extension ViewController {
    
    func selectDeselectData(tableview: UITableView, indexPath : IndexPath) {
        self.selectedArr.removeAll()
        if let arr = tableview.indexPathsForSelectedRows{
            for index in arr {
                selectedArr.append(arrData[index.row])
            }
        }
    }
}


extension ViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText == "" {
            arrData = ["Apple", "Bag", "Cat", "Dog", "Doll", "Car", "Ant", "Flower", "Ring", "Rubber", "Friend"]
        } else {
            arrData = ["Apple", "Bag", "Cat", "Dog", "Doll", "Car", "Ant", "Flower", "Ring", "Rubber", "Friend"]
            arrData = arrData.filter{
                $0.contains(searchText)
            }
        }
        tblView.reloadData()
    }
}
