import FirebaseFirestore
import Foundation

class DataLoader {
    static let db = Firestore.firestore() // Firestore instance

    static func loadUsers(completion: @escaping ([UserModel]) -> Void) {
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion([])
                return
            }
            
            var users: [UserModel] = []
            
            for document in documents {
                let data = document.data()
                
                // Manually create UserModel from data
                guard let username = data["username"] as? String,
                      let fullName = data["fullName"] as? String,
                      let imageName = data["imageName"] as? String,
                      let isVerified = data["isVerified"] as? Bool,
                      let likedThreads = data["likedThreads"] as? [String],
                      let threads = data["threads"] as? [String], // Ensure this matches
                      let threadMessage = data["threadMessage"] as? String else {
                    print("Error extracting data for document ID: \(document.documentID)")
                    continue
                }
                
                let user = UserModel(
                    id: document.documentID, // Include Firestore document ID
                    username: username,
                    fullName: fullName,
                    imageName: imageName,
                    isVerified: isVerified,
                    likedThreads: likedThreads,
                    threads: threads, // Initialize with array from Firestore
                    threadMessage: threadMessage
                )
                
                users.append(user)
            }
            
            completion(users)
        }
    }
}
