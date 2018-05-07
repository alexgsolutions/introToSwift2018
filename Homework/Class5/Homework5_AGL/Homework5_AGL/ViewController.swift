//
//  ViewController.swift
//  Homework5_AGL
//
//  Created by Alexis Gonzalez on 4/14/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet{
            segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
        }
    }
    
    //variables
    var colorListViewModels: [ColorViewModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Color Table"
        //set Red Colors by default
       getRedColors()
    }
    
    private func getRedColors() {
        colorListViewModels = generateColorList(quantity: 100, colorType: .Red)
        tableView.reloadData()
    }
    private func getBlueColors() {
        colorListViewModels = generateColorList(quantity: 100, colorType: .Blue)
        tableView.reloadData()
    }
    private func getRandomColors() {
        colorListViewModels = generateColorList(quantity: 100, colorType: .Random)
        tableView.reloadData()
    }

  @objc  private func segmentControlValueChanged() {
        print(segmentControl.selectedSegmentIndex)
    
        switch segmentControl.selectedSegmentIndex {
        case 0:
           getRedColors()
        case 1:
            getBlueColors()
        case 2:
           getRandomColors()
        default:
             getRedColors()
        }
    }


}

//Table Data Sources
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorListViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let colorViewModel = colorListViewModels[indexPath.row]
        cell.textLabel?.text = colorViewModel.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = colorViewModel.color
        cell.accessoryType = colorViewModel.isSelected ? .checkmark : .none
        
        return cell
    }
    
}

//Table Delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = colorListViewModels[indexPath.row]
        item.isSelected = !item.isSelected
        colorListViewModels[indexPath.row] = item
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
             cell.accessoryType = item.isSelected ? .checkmark : .none            
        }
            
    }
    
}

