//
//  CreateAccountViewController.swift
//  petJournal
//
//  Created by Daiane Goncalves on 30/03/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    var viewModel: CreateAccountViewModel = .init()
    
    
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var labelNameError: UILabel!
    @IBOutlet var textFieldLastName: UITextField!
    @IBOutlet var labelLastNameError: UILabel!
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var labelEmailError: UILabel!
    @IBOutlet var textFieldPhone: UITextField!
    @IBOutlet var labelPhoneError: UILabel!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var textFieldConfirmPassword: UITextField!
    @IBOutlet var labelConfirmPassword: UILabel!
    @IBOutlet var labelPasswordError: UILabel!
    @IBOutlet var buttonCreateAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
    }
    
    func resetForm () {
        buttonCreateAccount.isEnabled = false
        labelNameError.isHidden = false
        labelEmailError.isHidden = false
        labelPhoneError.isHidden = false
        labelPasswordError.isHidden = false
        labelConfirmPassword.isHidden = false
        labelLastNameError.isHidden = false
        labelNameError.text = "Obrigatório"
        labelLastNameError.text = "Obrigatório"
        labelEmailError.text = "Obrigatório"
        labelPhoneError.text = "Obrigatório"
        labelPasswordError.text = "Obrigatório"
        labelConfirmPassword.text = "Obrigatório"
        
        textFieldName.text = ""
        textFieldLastName.text = ""
        textFieldPhone.text = ""
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        textFieldConfirmPassword.text = ""
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        if let name = textFieldName.text {
            if let errorMessage = viewModel.isValidName(value: name){
                labelNameError.text = errorMessage
                labelNameError.isHidden = false
            }
            else{
                labelNameError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func lastNameChanged(_ sender: UITextField) {
        if let lastName = textFieldLastName.text {
            if let errorMessage = viewModel.isValidName(value: lastName){
                labelLastNameError.text = errorMessage
                labelLastNameError.isHidden = false
            }
            else{
                labelLastNameError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func emailDidEnd(_ sender: UITextField) {
        if let email = textFieldEmail.text {
            if let errorMessage = viewModel.isValidEmail(value: email){
                labelEmailError.text = errorMessage
                labelEmailError.isHidden = false
            }
            else{
                labelEmailError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        if let password = textFieldPassword.text {
            if let errorMessage = viewModel.isValidPassword(value: password){
                labelPasswordError.text = errorMessage
                labelPasswordError.isHidden = false
            }
            else{
                labelPasswordError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func phoneChanged(_ sender: UITextField) {
        if let phoneNumber = textFieldPhone.text{
            if let errorMessage = viewModel.isValidPhone(phoneNumber){
                labelPhoneError.text = errorMessage
                labelPhoneError.isHidden = false
            }
            else{
                labelPhoneError.isHidden = true
                textFieldPhone.text = viewModel.isformatPhoneNumber(phoneNumber)
            }
        }
        checkForValidForm()
    }
    
    func checkForValidForm () {
        if labelNameError.isHidden && labelEmailError.isHidden && labelPhoneError.isHidden {
            buttonCreateAccount.isEnabled = true
        }
        else {
            buttonCreateAccount.isEnabled = false
        }
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        resetForm()
    }
    
    @IBAction func confirmPasswordChanged(_ sender: UITextField) {
        if let confirmPassword = textFieldConfirmPassword.text {
            if confirmPassword != textFieldPassword.text{
                labelConfirmPassword.text = "As senhas devem ser idênticas"
                labelConfirmPassword.isHidden = false
            }
            else{
                labelConfirmPassword.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func privacyButton(_ sender: UIButton) {
        if let url = URL(string: "https://docs.google.com/document/d/1HdrmsLrBFqr3AsnsGCk_PERXvqaMjGSoMRxOH_03C5k/edit?usp=sharing") {
            UIApplication.shared.open(url)
        }
    }
}
