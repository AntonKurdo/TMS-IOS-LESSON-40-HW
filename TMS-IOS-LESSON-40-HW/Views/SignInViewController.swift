import UIKit
import GoogleSignIn

class SignInViewController: UIViewController {
    
    let emailTextField = UITextField(placeholder: "Email")
    let passwordTextField = UITextField(placeholder: "Password")
    let signInButton = UIButton(title: "Sign In")
    
    let googleSignInButton = {
        let googleButton = GIDSignInButton()
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.colorScheme = .dark
        return googleButton
    }()
    
    let label = {
        let label = UILabel()
        label.text = "If you have no accout yet, go to Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Sign In"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(signInButton)
        
        let action = UIAction {_ in
            guard let login = self.emailTextField.text, login.count > 0 , let password = self.passwordTextField.text, password.count > 0 else {
                self.emailTextField.shake()
                self.passwordTextField.shake()
                return
            }
            
            AuthService.shared.signIn(email: login, password: password) {
                self.navigationController?.viewControllers = [MainViewController()]
            }
        }
        
        signInButton.addAction(action, for: .touchUpInside)
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(navigateToSignUp))
        
        label.addGestureRecognizer(gestureRecognizer)
        
        view.addSubview(label)
        view.addSubview(googleSignInButton)
        
        
        let googleAction = UIAction {_ in
            AuthService.shared.googleSignIn(vc: self) {
                self.navigationController?.viewControllers = [MainViewController()]
            }
        }

        googleSignInButton.addAction(googleAction, for: .touchUpInside)
        
   
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            signInButton.heightAnchor.constraint(equalToConstant: 45),
            
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            googleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    
    @objc private func navigateToSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}

