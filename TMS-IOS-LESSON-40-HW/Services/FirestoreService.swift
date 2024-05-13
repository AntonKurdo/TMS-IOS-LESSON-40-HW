import Firebase

class FirestoreService {
    static let shared = FirestoreService()
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    func getDocument(userId: String, completion: @escaping (_ username: String) -> ()) {
        DispatchQueue.global().async {
            self.db.collection("usernames").document(userId).getDocument { snapshot, error in
                guard let username = snapshot?.data()?.values.first else { return }
                
                DispatchQueue.main.async {
                    completion(username as! String)
                }
            }
        }
    }
    
    func addOrUpdateDocument(userId: String, username: String)  {
        DispatchQueue.global().async {
            self.db.collection("usernames").document(userId).setData([
                "username": username
            ])
            print("Document successfully written!")
        }
    }
}
