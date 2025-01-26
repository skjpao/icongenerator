import SwiftUI

@main
struct IconGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            IconGenerator()
                .onAppear {
                    ImageSaver.saveIcon(from: IconGenerator())
                }
        }
    }
} 
