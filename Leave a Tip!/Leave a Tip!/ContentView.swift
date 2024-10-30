import SwiftUI

struct ContentView: View {
    // State variables to manage button visibility and response text
    @State private var show15Button = true
    @State private var show20Button = true
    @State private var show45Button = true
    @State private var responseText = ""
    
    // State variable to track device orientation
    @State private var isLandscape = false
    
    var body: some View {
        GeometryReader { geometry in
            // Using GeometryReader to determine orientation
            let deviceIsLandscape = geometry.size.width > geometry.size.height
            
            // Center everything in the available space
            VStack(spacing: 0) {
                Spacer()
                
                VStack {
                    Text("Leave a tip for [name]?")
                        .font(.system(size: 35))
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                    
                    // Use VStack for portrait and HStack for landscape
                    if deviceIsLandscape {
                        // Landscape layout
                        HStack(spacing: 30) {
                            Spacer()
                            buttonGroup
                            Spacer()
                        }
                    } else {
                        // Portrait layout
                        VStack(spacing: 20) {
                            buttonGroup
                        }
                    }
                    
                    if !responseText.isEmpty {
                        Text(responseText)
                            .font(.system(size: 35))
                            .padding(.top, 30)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .onChange(of: geometry.size) { oldSize, newSize in
                isLandscape = deviceIsLandscape
            }
        }
    }
    
    private var buttonGroup: some View {
        Group {
            if show15Button {
                TipButton(
                    percentage: "15%",
                    action: {
                        responseText = "Really? Try Again :("
                        show15Button = false
                    }
                )
            }
            
            if show20Button {
                TipButton(
                    percentage: "25%",
                    action: {
                        responseText = "Almost There... Try Again?"
                        show20Button = false
                    }
                )
            }
            
            if show45Button {  // Only show if show45Button is true
                TipButton(
                    percentage: "45%",
                    action: {
                        responseText = "Thank you for the tip!"
                        show45Button = false  
                    }
                )
            }
        }
    }
}

struct TipButton: View {
    let percentage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(percentage)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 30)
                .background(Color.blue)
                .cornerRadius(12)
                .frame(minWidth: 150)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
