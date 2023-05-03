//
//  CreateAccountViewController.swift
//  petJournal
//
//  Created by Daiane Goncalves on 30/03/23.
//

import UIKit
import WebKit

class CreateAccountViewController: UIViewController, WKNavigationDelegate {
    var viewModel: CreateAccountViewModel = .init()
    var webView: WKWebView!
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    @IBOutlet weak var buttonPrivacyPolicy: UIButton!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
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
        textFieldName.textContentType = .givenName
        textFieldName.autocorrectionType = .no
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
        textFieldLastName.textContentType = .familyName
        textFieldName.autocorrectionType = .no
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
        textFieldEmail.textContentType = .username
        textFieldName.autocapitalizationType = .none
        textFieldName.autocorrectionType = .no
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
                labelConfirmPassword.text = "As senhas devem ser idênticas"
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
        //validar quando todas as validoes estiverem ok fazer em cima de funcao retorno ou com flag.tentar fazer em cima de fun ção
    }
    
    @IBAction func confirmPasswordChanged(_ sender: UITextField) {
        if let confirmPassword = textFieldConfirmPassword.text {
            if confirmPassword != textFieldPassword.text{
                labelConfirmPassword.text = "As senhas devem ser idênticas"
                //colocar na label de senha tbm
                labelConfirmPassword.isHidden = false
            }
            else{
                labelConfirmPassword.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func privacyButton(_ sender: UIButton) {
        guard let url = URL(string: "https://www.hackingwithswift.com") else {return}
        let webView = CreateAccountViewController(url: url)
        self.present(webView, animated: true)
        
    }
    
    
    
}

