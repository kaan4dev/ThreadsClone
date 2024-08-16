import Foundation

class DataLoader
{
    static func loadUsers() -> [UserModel]
    {
        guard let url = Bundle.main.url(forResource: "user", withExtension: "json")
        else
        {
            print("JSON file not found.")
            return []
        }
        
        do
        {
            let data = try Data(contentsOf: url)
            let users = try JSONDecoder().decode([UserModel].self, from: data)
            return users
        }
        catch
        {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}
