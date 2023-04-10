//
//  CreateAccountViewController.swift
//  petJournal
//
//  Created by Daiane Goncalves on 30/03/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    
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
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        if let name = textFieldName.text {
            if let errorMessage = invalidName(name){
                labelNameError.text = errorMessage
                labelNameError.isHidden = false
            }
            else{
                labelNameError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidName(_ value: String) -> String? {
        let regularExpression = "^[A-Za-z]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !namePredicate.evaluate(with: value){
            return "Nome inválido"
        }
        if value.count < 3 {
            return "A senha deve ter pelo menos 3 caracteres"
        }
        return nil
    }
    
    @IBAction func lastNameChanged(_ sender: UITextField) {
        if let lastName = textFieldLastName.text {
            if let errorMessage = invalidName(lastName){
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
            if let errorMessage = invalidEmail(email){
                labelEmailError.text = errorMessage
                labelEmailError.isHidden = false
            }
            else{
                labelEmailError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidEmail(_ value: String) -> String? {
        let regularExpression = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !emailPredicate.evaluate(with: value){
            return "E-mail inválido"
        }
        return nil
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        if let password = textFieldPassword.text {
            if let errorMessage = invalidPassword(password){
                labelPasswordError.text = errorMessage
                labelPasswordError.isHidden = false
            }
            else{
                labelPasswordError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidPassword(_ value: String) -> String? {
        if value.count < 8 {
            return "A senha deve ter pelo menos 8 caracteres. Para torná-la mais forte, use letras maiúsculas e minúsculas, números e símbolos como ! @ # $ % & * ="
        }
        if containsDigit(value) {
            return "A senha deve ter pelo menos 1 caractere alfanumérico"
        }
        if containsEspecial(value) {
            return "A senha deve ter pelo menos 1 caractere especial"
        }
        return nil
    }
    
    func containsDigit(_ value: String) -> Bool {
        let regularExpression = "^(?=.*[A-Za-z0-9])(?=.*[0-9]).*$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !passwordPredicate.evaluate(with: value)
    }
    
    func containsEspecial(_ value: String) -> Bool {
        let regularExpression = "^(?=.*[!@#$%^&*()_+={};':\\|,.<>/?-]).*$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !passwordPredicate.evaluate(with: value)
    }
    
    @IBAction func phoneChanged(_ sender: UITextField) {
        if let phoneNumber = textFieldPhone.text{
            if let errorMessage = invalidPhoneNumber(phoneNumber){
                labelPhoneError.text = errorMessage
                labelPhoneError.isHidden = false
            }
            else{
                labelPhoneError.isHidden = true
                textFieldPhone.text = formatPhoneNumber(phoneNumber)
            }
        }
        checkForValidForm()
    }
    
    func invalidPhoneNumber(_ value: String) -> String? {
        if value.count < 11 {
            return "Campo inválido"
        }
        if value.count > 11 {
            let truncatedPhoneNumber = value.prefix(11)
            textFieldPhone.text = String(truncatedPhoneNumber)
        }
        return nil
    }
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) # ####-####"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                
                result.append(ch)
            }
        }
        return result
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
