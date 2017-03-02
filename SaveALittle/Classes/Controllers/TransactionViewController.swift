//
//  TransactionViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 12/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftDate
import RealmSwift

class TransactionViewController: UIViewController {
    
    let now = Date()
    var autoCompleteStrings: [String]? = nil
    
    lazy var amountTextField: NoEditableOptionTextFieldWithIcon = {
        let textField = NoEditableOptionTextFieldWithIcon(frame: .zero)
        self.applyTextFieldTheme(textField: textField)
        
        textField.iconColor = Color.darkText
        textField.selectedIconColor = Color.whiteColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
        textField.iconText = "\u{f155}"
        
        textField.placeholder = "Amount"
        textField.title = "AMOUNT"
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        
        return textField
    }()
    
    lazy var storeTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon(frame: .zero)
        self.applyTextFieldTheme(textField: textField)
        
        textField.iconColor = Color.darkText
        textField.selectedIconColor = Color.whiteColor
        textField.autocorrectionType = .no
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
        textField.iconText = "\u{f041}"
        
        textField.placeholder = "Store"
        textField.title = "STORE"
        textField.returnKeyType = .next
        
        textField.clearButtonMode = .always
        textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        textField.addTarget(self, action: #selector(self.textFieldDidEndEditing), for: .editingDidEnd)

        
        return textField
    }()
    
    lazy var typeTextField: NoEditableOptionTextFieldWithIcon = {
        let textField = NoEditableOptionTextFieldWithIcon(frame: .zero)
        self.applyTextFieldTheme(textField: textField)
        
        textField.iconColor = Color.darkText
        textField.selectedIconColor = Color.whiteColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
        textField.iconText = "\u{f200}"
        
        textField.placeholder = "Type"
        textField.title = "TYPE"
        textField.delegate = self
        textField.inputView = self.expenseTypesPicker
        
        
        return textField
    }()
    
    lazy var expenseTypesPicker: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    
    lazy var dateTimeField: NoEditableOptionTextFieldWithIcon = {
        let textField = NoEditableOptionTextFieldWithIcon(frame: .zero)
        self.applyTextFieldTheme(textField: textField)
        
        textField.iconColor = Color.darkText
        textField.selectedIconColor = Color.whiteColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
        textField.iconText = "\u{f073}"
        
        textField.title = "DATE and TIME"
        textField.delegate = self
        textField.inputView = self.dateTimePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.dateTimeDonePressed))
        toolBar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolBar
        
        textField.text = self.dateToString(date: self.now)
        
        return textField
    }()
    
    lazy var dateTimePicker: UIDatePicker = {
        let pickerView = UIDatePicker(frame: .zero)
        pickerView.maximumDate = self.now
        pickerView.date = self.now
        pickerView.timeZone = .current
        pickerView.calendar = Calendar(identifier: .gregorian)
        
        return pickerView
    }()
    
    lazy var autoCompleteStoreTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.backgroundColor = Color.darkerBackground
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 3
        tableView.layer.masksToBounds = true
        return tableView
    }()
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: Layout
    
    private func setupViews() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Color.darkBackground
        self.addRightBarButton(#imageLiteral(resourceName: "plus"))
        
        view.addSubview(amountTextField)
        view.addSubview(storeTextField)
        view.addSubview(typeTextField)
        view.addSubview(dateTimeField)
        view.addSubview(autoCompleteStoreTableView)
        addViewConstraints()
    }
    
    private func addViewConstraints() {
        _ = amountTextField.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0 , heightConstant: 45)
        
        _ = storeTextField.anchor(amountTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0 , heightConstant: 45)
        
        _ = autoCompleteStoreTableView.anchor(storeTextField.bottomAnchor, left: storeTextField.leftAnchor, bottom: nil, right: storeTextField.rightAnchor, topConstant: 2, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        _ = typeTextField.anchor(storeTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
        _ = dateTimeField.anchor(typeTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
    }
    
    
    private func addRightBarButton(_ buttonImage: UIImage) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.saveTransaction))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    
    private func applyTextFieldTheme(textField:SkyFloatingLabelTextField){
        textField.tintColor = Color.darkText
        textField.textColor = Color.whiteColor
        textField.lineColor = Color.darkText
        textField.selectedTitleColor = Color.darkText
        textField.selectedLineColor = Color.darkText
        textField.titleLabel.font = Font.titilliumWebRegular(size: 10)
        textField.placeholderFont = Font.titilliumWebRegular(size: 13)
        textField.font = Font.titilliumWebRegular(size: 13)
    }
    
    private func dateToString(date: Date)-> String {
        let dateInRegion = DateInRegion(absoluteDate: date)
        return dateInRegion.string(dateStyle: .long, timeStyle: .short)
    }
    
    private func isInputValid() -> Bool {
        var isValid = true
        
        if !self.typeTextField.hasText {
            isValid = false
            self.typeTextField.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.typeTextField.isHighlighted = true
        }
        
        if !self.amountTextField.hasText {
            isValid = false
            self.amountTextField.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.amountTextField.isHighlighted = true
        }
        
        return isValid
    }
    
    // MARK: Actions
    
    func dateTimeDonePressed(){
        dateTimeField.text = dateToString(date: dateTimePicker.date)
        self.view.endEditing(true)
    }
    
    func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    func saveTransaction() {
        
        guard isInputValid() else {
            return
        }
        
        // Save transaction
        let transaction = ExpenseTransaction()
        transaction.dateTime = dateTimePicker.date as NSDate
        transaction.from = storeTextField.text
        let amountText = amountTextField.text ?? "0.0"
        transaction.amount = (amountText as NSString).floatValue
        transaction.expenseType = Expense(rawValue: self.expenseTypesPicker.selectedRow(inComponent: 0))!
        transaction.save()
        
        // Cache transaction location
        if let from = storeTextField.text, !from.isEmptyWhitespaces {
            self.cacheTransactionLocation(from: from)
        }
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    
    func cacheTransactionLocation(from: String) {
        let location = CachedLocation()
        location.from = from
        location.save()
    }
    
    func showingTitleInAnimationComplete() {
        // If a field is not filled out, display the highlighted title for 0.3 seco
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.typeTextField.setTitleVisible(false, animated: true)
            self.amountTextField.setTitleVisible(false, animated: true)
        }
    }
    
    func textFieldDidChange(){
        guard let text = storeTextField.text else {
            return
        }
        
        onTextChange(text: text)
        
        if text.isEmpty{ autoCompleteStrings = nil }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.autoCompleteStoreTableView.isHidden = false
            if text.isEmpty || self.isAutoCompletedStringEmpty() {
                self.autoCompleteStoreTableView.isHidden = true
            }
        })
    }
    
    func isAutoCompletedStringEmpty() ->Bool {
        
        guard let filteredStrings = self.autoCompleteStrings,
                  !filteredStrings.isEmpty else {
            return true
        }
        
        return false
    }
    
    func textFieldDidEndEditing() {
        autoCompleteStoreTableView.isHidden = true
    }
    
    func onTextChange(text: String) {
        // Filter the cached store data
        let realm = try! Realm()
        
        let locations = realm.objects(CachedLocation.self).map { (location) -> String in
            location.from
        }
        autoCompleteStrings = locations.filter({$0.lowercased().contains(text.lowercased())})
        autoCompleteStoreTableView.reloadData()
    }
}

extension TransactionViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.inputView == expenseTypesPicker && (textField.text?.isEmpty)! {
            textField.text = Expense(rawValue: 0)?.description
        }
    }
    
}

// MARK: -UIPickerViewDelegate, -UIPickerViewDataSource

extension TransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Expense.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Expense(rawValue: row)?.description
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = Expense(rawValue: row)?.description
        self.view.endEditing(true)
    }
}

// MARK: -UITableViewDataSource, -UITableViewDelegate

extension TransactionViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteStrings?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "autocompleteCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.font = Font.titilliumWebRegular(size: 15)
        cell?.textLabel?.textColor = Color.darkText
        cell?.textLabel?.text = autoCompleteStrings?[indexPath.row]
        
        cell?.contentView.gestureRecognizers = nil
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let selectedText = cell?.textLabel?.text {
            self.storeTextField.text = selectedText
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            tableView.isHidden = true
        })
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}




