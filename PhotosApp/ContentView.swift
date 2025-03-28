import SwiftUI
import PhotosUI

struct ContentView: View {
    // State variables for photo selection
    @State private var selectedPhotos: [Image] = []
    @State private var showPhotosPicker = false
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    
    var body: some View {
        ZStack {
            // Full-screen gradient background
            LinearGradient(
                gradient: Gradient(colors: [.orange, .blue, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Add Photo Button
                Button(action: {
                    showPhotosPicker = true
                }) {
                    Text("Add Photo")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            
            // Scrollable photos at the bottom of the screen
            VStack {
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(selectedPhotos.indices, id: \.self) { index in
                            selectedPhotos[index]
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: UIScreen.main.bounds.height / 5)
            }
        }
        // Photo picker modifier
        .photosPicker(
            isPresented: $showPhotosPicker,
            selection: $selectedPhotoItems,
            maxSelectionCount: 5,
            matching: .images
        )
        // Handle photo selection changes
        .onChange(of: selectedPhotoItems) { _, newItems in
            Task {
                var loadedImages: [Image] = []
                
                for item in newItems {
                    do {
                        if let image = try await loadImage(from: item) {
                            loadedImages.append(image)
                        }
                    } catch {
                        print("Error loading image: \(error)")
                    }
                }
                
                // Update selected photos
                selectedPhotos = loadedImages
            }
        }
    }
    
    // Image loading function
    private func loadImage(from item: PhotosPickerItem) async throws -> Image? {
        do {
            let data = try await item.loadTransferable(type: Data.self)
            if let data = data, let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        } catch {
            print("Error loading image data: \(error)")
        }
        return nil
    }
}

#Preview {
    ContentView()
}
