import SwiftUI
import Firebase

@main
struct ThreadsCloneApp: App
{
    @State private var showLoginView = false

    init()
    {
        FirebaseApp.configure()
    }

    var body: some Scene
    {
        WindowGroup
        {
            Splash(showLoginView: $showLoginView)
        }
    }
}
