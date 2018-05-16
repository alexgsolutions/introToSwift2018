//
//  TextEntryCell.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

protocol TextEntryDelegate: class {
    func didUpdateField(_ text: String, _ cardDetailCellType: CardDetailSectionCellType?, _ addressCellType: AddressSectionCellType?)
}

class TextEntryCell: UITableViewCell {
    
    weak var delegate: TextEntryDelegate?
    var cardDetailCellType: CardDetailSectionCellType? = nil
    var addressCellType: AddressSectionCellType? = nil
    let picker = UIPickerView()
    let pickerMonth = getMonthForPicker()
    let pickerYear = getYearsForPicker()
    
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            picker.delegate = self
            picker.dataSource = self
        }
    }
    
}

extension TextEntryCell: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let expectedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if cardDetailCellType == CardDetailSectionCellType.expirationDate  {
            if currentText.count == 2 {
                textField.text = textField.text! + "/"
            }
            if expectedText.count > 5 {
                return false
            }
        }
         if cardDetailCellType == CardDetailSectionCellType.securityCode  {
            if expectedText.count > 4 {
                return false
            }
        }
        
        if addressCellType == AddressSectionCellType.zipCode  {
            if expectedText.count > 5 {
                return false
            }
        }
        delegate?.didUpdateField(expectedText, cardDetailCellType, addressCellType)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension TextEntryCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if cardDetailCellType == CardDetailSectionCellType.expirationDate {
            switch component {
            case 0:
                return pickerMonth[row]
            case 1:
                return "\(pickerYear[row])"
            default:
                return nil
            }
        }
        return statesArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if cardDetailCellType == CardDetailSectionCellType.expirationDate {
            let month = pickerMonth[pickerView.selectedRow(inComponent: 0)]
            let year = pickerYear[pickerView.selectedRow(inComponent: 1)]
            textField.text = "\(month)/\(year)"
            
        }
         if addressCellType == AddressSectionCellType.state {
            textField.text = statesArray[row]
        }
        delegate?.didUpdateField(textField.text!, cardDetailCellType, addressCellType)
    }
    
    
}
//MARK: UIPicker DataSource
extension TextEntryCell : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         if cardDetailCellType == CardDetailSectionCellType.expirationDate {
            return 2
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if cardDetailCellType == CardDetailSectionCellType.expirationDate {
            switch component {
            case 0:
                return pickerMonth.count
            case 1:
                return pickerYear.count
            default:
                return 0
            }
        }
        return statesArray.count
    }
}
