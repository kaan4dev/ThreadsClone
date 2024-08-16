import SwiftUI

struct MainView: View
{
    @State private var showLoginView = false

    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                if showLoginView
                {
                    Login(showLoginView: $showLoginView)
                }
                else
                {
                    Splash(showLoginView: $showLoginView)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview
{
    MainView()
}
