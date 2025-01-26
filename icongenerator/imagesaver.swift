import SwiftUI

@MainActor
class ImageSaver {
    private var nsImage: NSImage
    private var scale: CGFloat
    
    @MainActor
    init(content: NSImage) {
        self.nsImage = content
        self.scale = 1.0
    }
    
    @MainActor
    static func saveIcon<Content: View>(from view: Content) {
        let renderer = ImageRenderer(content: view)
        renderer.scale = 1.0
        
        if let nsImage = renderer.nsImage {
            let saver = ImageSaver(content: nsImage)
            
            let savePanel = NSSavePanel()
            savePanel.allowedContentTypes = [.png]
            savePanel.nameFieldStringValue = "AppIcon.png"
            savePanel.canCreateDirectories = true
            
            savePanel.beginSheetModal(for: NSApp.keyWindow ?? NSWindow()) { response in
                if response == .OK, let url = savePanel.url {
                    do {
                        try saver.saveImage(to: url)
                        print("Kuva tallennettu onnistuneesti: \(url.path)")
                    } catch {
                        print("Virhe kuvan tallennuksessa: \(error)")
                    }
                }
            }
        } else {
            print("Virhe: Kuvaa ei voitu luoda")
        }
    }
    
    @MainActor
    func setScale(_ newScale: CGFloat) {
        self.scale = newScale
    }
    
    @MainActor
    func saveImage(to url: URL) throws {
        // Create a SwiftUI Image from NSImage
        let swiftUIImage = Image(nsImage: nsImage)
        let renderer = ImageRenderer(content: swiftUIImage)
        renderer.scale = self.scale
        
        guard let nsImage = renderer.nsImage else {
            throw ImageSaverError.renderingFailed
        }
        
        guard let tiffData = nsImage.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffData),
              let pngData = bitmapImage.representation(using: NSBitmapImageRep.FileType.png, properties: [:]) else {
            throw ImageSaverError.conversionFailed
        }
        
        do {
            try pngData.write(to: url)
            print("Kuva tallennettu onnistuneesti kohteeseen: \(url.path)")
        } catch {
            print("Virhe tiedoston kirjoituksessa: \(error)")
            throw ImageSaverError.writeFailed(error)
        }
    }
    
    func saveImageAsync(to url: URL) async throws {
        try await Task { @MainActor in
            try saveImage(to: url)
        }.value
    }
}

// Add error types
enum ImageSaverError: Error {
    case renderingFailed
    case conversionFailed
    case writeFailed(Error)
}
