import Foundation

struct UserModel: Identifiable, Decodable
{
    var id: UUID = UUID()
    var username: String
    var fullName: String
    var imageName: String
    var isVerified: Bool
    var threadMessage: String
    var likedThreads: [String]
}
