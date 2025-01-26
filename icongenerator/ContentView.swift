import SwiftUI

struct IconGenerator: View {
    var body: some View {
        Image(systemName: "fork.knife.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 1024, height: 1024) // App Store vaatii 1024x1024 koon
            .foregroundColor(.white) // Voit vaihtaa väriä tarpeen mukaan
    }
}

#Preview {
    IconGenerator()
} 
