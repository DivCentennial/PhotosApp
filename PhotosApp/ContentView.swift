import SwiftUI
import PhotosUI

struct ContentView: View {
    // State variables for photo selection
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var displayedImages: [Image] = []
    @State private var showPhotosPicker = false
    
    var body: some View {
        // Breaking up the expression into multiple parts
        mainView
            .photosPicker(
                isPresented: $showPhotosPicker,
                selection: $selectedPhotos,
                maxSelectionCount: 5,
                matching: .images
            )
            .onChange(of: selectedPhotos) { _, items in
                loadImages(from: items)
            }
    }
    
    // Main view separated to reduce complexity
    private var mainView: some View {
        backgroundGradient
            .overlay(addPhotoButton, alignment: .top)
            .overlay(photoScrollView, alignment: .bottom)
    }
    
    // Background gradient
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [.orange, .blue, .red]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // Add Photo button
    private var addPhotoButton: some View {
        Button(action: {
            showPhotosPicker = true
        }) {
            Text("Add Photo")
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
        }
        .padding(.top, 50)
    }
    
    // Scrollable photos view
    private var photoScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<displayedImages.count, id: \.self) { index in
                    displayedImages[index]
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                }
            }
            .padding(.horizontal)
        }
        .containerRelativeFrame(.vertical, count: 5, span: 1, spacing: 10)
        .background(Color.black.opacity(0.3))
    }

    
    
    // Function to load images
    private func loadImages(from items: [PhotosPickerItem]) {
        Task {
            displayedImages = [] // Clear previous images
            for item in items {
                // Load image data from PhotosPickerItem
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = createImageFromData(data) {
                    displayedImages.append(image) // Append decoded Image
                }
            }
        }
    }
    // Create image from data without directly using UIKit
    
    private func createImageFromData(_ data: Data) -> Image? {
        if let cgImageSource = CGImageSourceCreateWithData(data as CFData, nil),
           let cgImage = CGImageSourceCreateImageAtIndex(cgImageSource, 0, nil) {
            // Convert CGImage to SwiftUI Image
            return Image(decorative: cgImage, scale: 1.0, orientation: .up)
        }
        return nil // Return nil if image creation fails
    }
}

#Preview {
    ContentView()
}
