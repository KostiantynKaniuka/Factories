//
//  ViewController.swift
//  Bankey
//
//  Created by Kostiantyn Kaniuka on 28.10.2022.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LogInViewControllerDelegate: AnyObject {
    func didLogIn()
}

class LogInViewController: UIViewController {
    
    let loginView = LoginView()
    let topLabelsView = TopLabelsView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LogInViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LogInViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        topLabelsView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
   private func layout() {
       view.addSubview(topLabelsView)
       view.addSubview(loginView)
       view.addSubview(signInButton)
       view.addSubview(errorMessageLabel)
       
       //Top Labels View
       NSLayoutConstraint.activate([
        topLabelsView.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -3),
        topLabelsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: topLabelsView.trailingAnchor, multiplier: 1)
       ])
       
       //Log in view
       NSLayoutConstraint.activate([
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
       ])
       
      //Sign in button
       NSLayoutConstraint.activate([
        signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
        signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1)
       ])
       
       //Error label
       NSLayoutConstraint.activate([
        errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
        errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
        errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor)
       ])
       
       
    }
}

// MARK: Actions
extension LogInViewController {
    
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nill")
            return
        }
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Kevin" && password == "123" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogIn()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
        
        private func configureView(withMessage message: String) {
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = message
        }
    
}
