//
//  CreditCardsViewController.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

class CreditCardsViewController: UIViewController {

    var creditCards = [CreditCard]()
    
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppConfig.appName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCreditCardButtonPressed))
       configureRightButtonStyle()
        configureBackButton()
        loadCreditCard()
        
    }
    
    private func loadCreditCard() {
        creditCards = retriveCreditCards()
    }
    
    @objc private func addNewCreditCardButtonPressed() {
        let newCreditCarVC = storyboard?.instantiateViewController(withIdentifier: AppConfig.ScreenIdentifiers.addCreditCard) as! AddCreditCardViewController
        newCreditCarVC.delegate = self
        navigationController?.pushViewController(newCreditCarVC, animated: true)
    }
}

extension CreditCardsViewController: AddCreditCardDelegate {
    
    func didPressSaveButton(_ creditCard: CreditCard, index: Int?) {
        
        if let myIndex = index {
            creditCards[myIndex] = creditCard
        }else {
             creditCards.append(creditCard)
        }
    
        saveCreditCards(creditCards)
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
    }
}


extension CreditCardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCardSummary", for: indexPath) as! CreditCardSummaryCell
        let creditCard = creditCards[indexPath.row]
        
        cell.nameLabel.text = creditCard.getFullName
        cell.cardInfoLabel.text = creditCard.getCreditCarInfo
        cell.iconImage.image = getCardImage(creditCard.cardNumber)
        
        return cell
    }
}
extension CreditCardsViewController: UITableViewDelegate,UIAlertViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit", handler:{action, indexpath in
            print("EDIT-ACTION");
            self.editCreditCard(indexPath.row)
            
        });
        editRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0)
        //editRowAction.backgroundColor = UIColor(patternImage: UIImage(named: "visa48")!)
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{action, indexpath in
            print("DELETE-ACTION");
            self.deleteCreditCard(indexPath.row)
        });
        
        return [deleteRowAction, editRowAction];
    }
    
    private func editCreditCard(_ index: Int) {
        print("Presed Edited Button")
        if let editCreditCardViewController = self.storyboard?.instantiateViewController(withIdentifier: AppConfig.ScreenIdentifiers.addCreditCard) as? AddCreditCardViewController {
            editCreditCardViewController.cardSelectedIndex = index
            editCreditCardViewController.newCreditCard = creditCards[index]
            editCreditCardViewController.delegate = self
            navigationController?.pushViewController(editCreditCardViewController, animated: true)
        }
    }
    private func deleteCreditCard(_ index: Int) {
        
        let selectedCreditCard = creditCards[index]
        
        let alertController = UIAlertController(title: AppConfig.appName, message: "Delete \(selectedCreditCard.cardNumber) card?", preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed delete");
            self.creditCards.remove(at: index)
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(delete)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}
