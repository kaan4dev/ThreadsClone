import SwiftUI

struct Splash: View
{
    @Binding var showLoginView: Bool
    @State private var isActive = false

    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                if isActive
                {
                    Login(showLoginView: $showLoginView) // Transition to Login view
                }
                else
                {
                    VStack
                    {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                    .onAppear
                    {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        {
                            withAnimation(.easeIn(duration: 1.0))
                            {
                                isActive = true
                                showLoginView = true
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true) // Hide navigation bar on Splash
        }
    }
}

#Preview
{
    Splash(showLoginView: .constant(false))
}
