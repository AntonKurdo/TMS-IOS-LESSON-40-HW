import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    var logoutButton = UIButton(title: "Log Out", backgroundColor: .systemRed)
    var email = UILabel(label: "")
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(logoutButton)
        view.addSubview(email)
        
        email.text = "Your Email is \(Auth.auth().currentUser?.email ?? "No email")"
        email.textColor = .black
        
        let logoutAction = UIAction {_ in
            AuthService.shared.logout() {
                self.navigationController?.viewControllers = [SignInViewController()]
            }
        }
        
        logoutButton.addAction(logoutAction, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoutButton.heightAnchor.constraint(equalToConstant: 45),
            
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
    }
}
