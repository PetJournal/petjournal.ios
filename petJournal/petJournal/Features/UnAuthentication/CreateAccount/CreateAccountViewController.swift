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
    
    var webView: WKWebView?
    
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
    
    
//    override func loadView() {
////        webView = WKWebView()
////        webView?.navigationDelegate = self
////        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let url = URL(string: "https://docs.google.com/document/d/1HdrmsLrBFqr3AsnsGCk_PERXvqaMjGSoMRxOH_03C5k/edit?usp=sharing")!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
        
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
        let vc = webView ?? CreateAccountViewController()
        present(vc as UIViewController, animated: true, completion: nil)
        
        webView = WKWebView(frame: view.frame)
            view.addSubview(webView!)
                
            // carregue a URL desejada
            let url = URL(string: "https://www.google.com")!
            webView!.load(URLRequest(url: url))
            
            let closeButton = UIButton(type: .system)
            closeButton.setTitle("Fechar", for: .normal)
            closeButton.addTarget(self, action: #selector(closeWebView), for: .touchUpInside)
            view.addSubview(closeButton)
            
            // adicione as restrições do botão "Fechar"
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    @objc func closeWebView() {
        webView?.removeFromSuperview()
    }
    
    
}

