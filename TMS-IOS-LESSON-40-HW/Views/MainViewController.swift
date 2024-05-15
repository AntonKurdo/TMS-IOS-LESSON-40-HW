import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    var logoutButton = UIButton(title: "Log Out", backgroundColor: .systemRed)
    var email = UILabel(label: "")
    
    let stackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    var usernameTextField = UITextField(placeholder: "Full name...")
    let updateButton = UIButton(title: "Update", backgroundColor: .systemBlue)
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupUI()
        
        let userId = Auth.auth().currentUser?.uid
        guard let userId = userId else { return }
        FirestoreService.shared.getDocument(userId: userId) { username in
            self.usernameTextField.text = username
        }
        
    }
    
    private func setupUI() {
        view.addSubview(logoutButton)
        view.addSubview(email)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(updateButton)
        
        email.text = "Your Email is \(Auth.auth().currentUser?.email ?? "No email")"
        email.textColor = .black
        
        let logoutAction = UIAction {_ in
            AuthService.shared.logout() {
                self.navigationController?.viewControllers = [SignInViewController()]
            }
        }
        logoutButton.addAction(logoutAction, for: .touchUpInside)
        
        
        let updateAction = UIAction { _ in
            guard let updatedUserName = self.usernameTextField.text, updatedUserName.count > 0 else {
                self.usernameTextField.shake()
                return
            }
            let userId = Auth.auth().currentUser?.uid
            guard let userId = userId else { return }
            FirestoreService.shared.addOrUpdateDocument(userId: userId, username: updatedUserName)
        }
        updateButton.addAction(updateAction, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoutButton.heightAnchor.constraint(equalToConstant: 45),
            
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
            updateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ])
    }
}
