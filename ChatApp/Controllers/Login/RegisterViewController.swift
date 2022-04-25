//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by user217567 on 4/25/22.
//

import UIKit

class RegisterViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        
            return imageView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First name: "
        
        //buffer pt text in partea stanga a input fieldului
        field.leftView = UIView(frame: CGRect ( x: 0, y: 0, width: 7, height: 0 ))
        field.leftViewMode = .always
        
        field.backgroundColor = .white
        
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last name: "
        
        //buffer pt text in partea stanga a input fieldului
        field.leftView = UIView(frame: CGRect ( x: 0, y: 0, width: 7, height: 0 ))
        field.leftViewMode = .always
        
        field.backgroundColor = .white
        
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email address: "
        
        //buffer pt text in partea stanga a input fieldului
        field.leftView = UIView(frame: CGRect ( x: 0, y: 0, width: 7, height: 0 ))
        field.leftViewMode = .always
        
        field.backgroundColor = .white
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password: "
        
        //buffer pt text in partea stanga a input fieldului
        field.leftView = UIView(frame: CGRect ( x: 0, y: 0, width: 7, height: 0 ))
        field.leftViewMode = .always
        
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        
        return field
    }()
    
    
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done,
                                                            target: self, action: #selector(didTapRegister))
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subviews (elementele de pe pagina)
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic() {
        //print ( "Change pic called")
    }
    
    override func viewDidLayoutSubviews() {  //pozitionarea elementelor pe pagina
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/4
        imageView.frame = CGRect( x: (scrollView.width-size)/2, //centers the logo
                                  y: 20, width: size, height: size)
        
        firstNameField.frame = CGRect( x: 30, y: imageView.bottom+10,
                                   width: scrollView.width-60, height: 52)
        
        lastNameField.frame = CGRect( x: 30, y: firstNameField.bottom+10,
                                   width: scrollView.width-60, height: 52)
        
        emailField.frame = CGRect( x: 30, y: lastNameField.bottom+10,
                                   width: scrollView.width-60, height: 52)
        
        passwordField.frame = CGRect( x: 30, y: emailField.bottom+10,
                                      width: scrollView.width-60, height: 52)
        
        registerButton.frame = CGRect( x: 30, y: passwordField.bottom+10,
                                    width: scrollView.width-60, height: 52)
    }
    
    @objc private func registerButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let firstName = firstNameField.text, let lastName = lastNameField.text,
              let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, !firstName.isEmpty, !lastName.isEmpty,
              password.count >= 6 else {
                    alertUseroginError()
                    return
        }
        
        //Firebase LogIn - TODO
    }
    
    func alertUseroginError(){
        let alert = UIAlertController(title: "Hopa!", message: "Please complete all information to register a new account",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //ce se intampla pt 'Return' (enter) apasat
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
}
