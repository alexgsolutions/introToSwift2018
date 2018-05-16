//
//  AddCreditCardViewController.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit


protocol AddCreditCardDelegate: class {
    func didPressSaveButton(_ creditCard: CreditCard, index: Int?)
}

class AddCreditCardViewController: UIViewController {
    
    var newCreditCard = CreditCard()
    var editedCreditCar: CreditCard?
    var cardSelectedIndex: Int?
    weak var delegate: AddCreditCardDelegate?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppConfig.ScreenTitlesNames.newCreditCardTitle
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        configureRightButtonStyle()
        updateSaveButton()
    }
  
    @objc private func saveButtonPressed() {
        delegate?.didPressSaveButton(newCreditCard, index: cardSelectedIndex)
    }
    
    private func updateSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = newCreditCard.isDetailsFilledOut && newCreditCard.address.isFilledOut
    }
    
    private func initToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = AppConfig.appTiltColor
        toolBar.barTintColor = AppConfig.appColor
        toolBar.sizeToFit()
       
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerDoneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    @objc private func pickerDoneAction() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

//MARK: --Table DataSource
extension AddCreditCardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NewCreditCardSectionType(rawValue: section)?.txt
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewCreditCardSectionType.count
    }
   
    private func cardDetailCellFor(_ cellType: CardDetailSectionCellType, _ indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
        cell.delegate = self
        cell.addressCellType = nil
        cell.cardDetailCellType = cellType
        cell.textField.inputView = nil
        cell.textField.keyboardType = .default
        cell.textField.inputAccessoryView = nil
        cell.textField.isSecureTextEntry = false
        
        switch cellType {
        case .firstName:
            cell.textField.autocapitalizationType = .words
            cell.textField.text = newCreditCard.firstName
        case .lastName:
            cell.textField.autocapitalizationType = .words
            cell.textField.text = newCreditCard.lastName
        case .cardNumber:
            cell.textField.keyboardType = .numberPad
            cell.textField.text = newCreditCard.cardNumber
        case .expirationDate:
            cell.textField.inputView = cell.picker
            cell.textField.inputAccessoryView = initToolBar()
            cell.textField.text = newCreditCard.expirationDate
        case .securityCode:
            cell.textField.keyboardType = .numberPad
            cell.textField.isSecureTextEntry = true
            cell.textField.text = newCreditCard.securityCode
        }

        return cell
    }
    
    private func addressCellFor(_ cellType: AddressSectionCellType, _ indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.addressCellType = cellType
        cell.cardDetailCellType = nil
        cell.fieldName.text = cellType.txt
        cell.delegate = self
        cell.textField.inputView = nil
        cell.textField.keyboardType = .default
        cell.textField.inputAccessoryView = nil
        cell.textField.isSecureTextEntry = false
        
        switch cellType {
        case .zipCode:
            cell.textField.keyboardType = .numberPad
            cell.textField.text = newCreditCard.address.zipCode
        case .state:
            cell.textField.inputView = cell.picker
            cell.textField.inputAccessoryView = initToolBar()
            cell.textField.text = newCreditCard.address.state
        case .addressOne:
            cell.textField.text = newCreditCard.address.addressOne
        case .addressTwo:
            cell.textField.text = newCreditCard.address.addressTwo
        case .cityTown:
            cell.textField.text = newCreditCard.address.cityTown
        }

        return cell
    }
}

//MARK: --Table Delegate
extension AddCreditCardViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = NewCreditCardSectionType(rawValue: section)!
        switch sectionType {
        case .cardDetails:
            return CardDetailSectionCellType.count
        case .address:
            return AddressSectionCellType.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = NewCreditCardSectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .cardDetails:
            let cellType = CardDetailSectionCellType(rawValue: indexPath.row)!
            return cardDetailCellFor(cellType, indexPath)
            
        case .address:
            let cellType = AddressSectionCellType(rawValue: indexPath.row)!
            return addressCellFor(cellType, indexPath)
        }
    }
}

//MARK: --Keyboard Delegate
extension AddCreditCardViewController {
    @objc func keyboardWillShow(_ sender: Notification) {
        let height: CGFloat = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height ?? 0
        let duration: TimeInterval = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let curveOption: UInt = (sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.beginFromCurrentState.rawValue|curveOption), animations: {
            let edgeInsets = UIEdgeInsetsMake(0, 0, height, 0)
            self.tableView.contentInset = edgeInsets
            self.tableView.scrollIndicatorInsets = edgeInsets
        }, completion: nil)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        let duration: TimeInterval = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let curveOption: UInt = (sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.beginFromCurrentState.rawValue|curveOption), animations: {
            let edgeInsets = UIEdgeInsets.zero
            self.tableView.contentInset = edgeInsets
            self.tableView.scrollIndicatorInsets = edgeInsets
        }, completion: nil)
    }
}

//MARK: Text Delegate
extension AddCreditCardViewController: TextEntryDelegate {
    
    func didUpdateField(_ text: String, _ cardDetailCellType: CardDetailSectionCellType?, _ addressCellType: AddressSectionCellType?) {
        if let creditCardType = cardDetailCellType {
            newCreditCard = newCreditCard.updateCardDetail(creditCardType, text)
        }
        if let addressType = addressCellType {
           newCreditCard = newCreditCard.updateAddressDetail(addressType, text)
        }
        updateSaveButton()
    }
}























