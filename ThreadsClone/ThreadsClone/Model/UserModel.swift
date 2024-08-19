import FirebaseFirestore
import Foundation

struct UserModel: Identifiable {
    let id: String
    var username: String
    var fullName: String
    var imageName: String
    var isVerified: Bool
    var likedThreads: [String]
    var threads: [String] // Added property
    var threadMessage: String

    init(
        id: String = UUID().uuidString, // Default value for new users
        username: String,
        fullName: String,
        imageName: String,
        isVerified: Bool,
        likedThreads: [String] = [],
        threads: [String] = [], // Initialize with empty threads
        threadMessage: String = ""
    ) {
        self.id = id
        self.username = username
        self.fullName = fullName
        self.imageName = imageName
        self.isVerified = isVerified
        self.likedThreads = likedThreads
        self.threads = threads // Initialize with empty threads
        self.threadMessage = threadMessage
    }
    
    // Initialize with Firestore document data
    init?(document: DocumentSnapshot) {
        guard
            let data = document.data(),
            let username = data["username"] as? String,
            let fullName = data["fullName"] as? String,
            let imageName = data["imageName"] as? String,
            let isVerified = data["isVerified"] as? Bool,
            let likedThreads = data["likedThreads"] as? [String],
            let threads = data["threads"] as? [String], // Ensure this matches
            let threadMessage = data["threadMessage"] as? String
        else {
            return nil
        }

        self.id = document.documentID
        self.username = username
        self.fullName = fullName
        self.imageName = imageName
        self.isVerified = isVerified
        self.likedThreads = likedThreads
        self.threads = threads // Initialize with array from Firestore
        self.threadMessage = threadMessage
    }

    // Convert UserModel to Firestore dictionary
    func toDictionary() -> [String: Any] {
        return [
            "username": username,
            "fullName": fullName,
            "imageName": imageName,
            "isVerified": isVerified,
            "likedThreads": likedThreads,
            "threads": threads, // Save threads array
            "threadMessage": threadMessage
        ]
    }
}
