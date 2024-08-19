import FirebaseFirestore
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [UserModel] = []

    private var db = Firestore.firestore()

    init() {
        loadUsersFromFirestore()
    }

    func loadUsersFromFirestore() {
        db.collection("users").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }

            guard let snapshot = snapshot else {
                print("No data available")
                return
            }

            var updatedUsers: [UserModel] = []

            for document in snapshot.documents {
                let data = document.data()

                guard
                    let username = data["username"] as? String,
                    let fullName = data["fullName"] as? String,
                    let imageName = data["imageName"] as? String,
                    let isVerified = data["isVerified"] as? Bool,
                    let likedThreads = data["likedThreads"] as? [String],
                    let threads = data["threads"] as? [String] // Ensure this matches
                else {
                    print("Error: Missing or invalid data in document \(document.documentID)")
                    continue
                }

                let userModel = UserModel(
                    id: document.documentID,
                    username: username,
                    fullName: fullName,
                    imageName: imageName,
                    isVerified: isVerified,
                    likedThreads: likedThreads,
                    threads: threads, // Initialize with array from Firestore
                    threadMessage: "" // Assuming threadMessage is not needed
                )

                updatedUsers.append(userModel)
            }

            self.users = updatedUsers
        }
    }

    func loadUserThreads(userId: String, completion: @escaping ([String]) -> Void) {
        db.collection("threads").whereField("userId", isEqualTo: userId).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching threads: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let documents = snapshot?.documents else {
                completion([])
                return
            }

            let threads = documents.compactMap { document in
                return document.data()["threadMessage"] as? String
            }
            completion(threads)
        }
    }

    func addThread(for user: UserModel, threadText: String) {
        let threadData: [String: Any] = [
            "userId": user.id,
            "threadMessage": threadText
        ]
        
        db.collection("threads").addDocument(data: threadData) { error in
            if let error = error {
                print("Error adding thread: \(error.localizedDescription)")
            } else {
                print("Thread added successfully")
            }
        }
    }
}
