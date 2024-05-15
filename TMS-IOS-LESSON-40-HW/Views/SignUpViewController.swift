import UIKit

class SignUpViewController: UIViewController {
    
    let emailTextField = UITextField(placeholder: "Email")
    let passwordTextField = UITextField(placeholder: "Password")
    let signUpButton = UIButton(title: "Sign Up")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Registration"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(signUpButton)
        
        let action = UIAction {_ in
            guard let login = self.emailTextField.text, login.count > 0 , let password = self.passwordTextField.text, password.count > 0 else {
                self.emailTextField.shake()
                self.passwordTextField.shake()
                return
            }
            AuthService.shared.signUp(email: login, password: password) {
                self.navigationController?.viewControllers = [MainViewController()]
            }
        }
        
        signUpButton.addAction(action, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

