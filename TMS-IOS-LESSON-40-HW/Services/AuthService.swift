import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import GoogleSignInSwift

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func signIn(email: String, password: String, completion: (() -> ())?) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard authResult != nil else { return }
            completion?()
        }
    }
    
    func signUp(email: String, password: String, completion: (() -> ())?) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil) {
                return
            }
            completion?()
        }
    }
    
    func logout(completion: (() -> ())?) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion?()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func googleSignIn(vc: UIViewController, completion: (() -> ())?) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                completion?()
            }
            
            
        }
    }
}
