//
//  ContentView.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-02-26.
//

import SwiftUI
import NailDiseaseSDK

struct ContentView: View {
    @StateObject private var classifier = NailDiseaseClassifier()
    @State private var inputImage: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var showingCameraPicker = false
    @State private var resultLabel: String = "No result yet"
    @State private var isProcessing = false // Loading state

    var body: some View {
        VStack(spacing: 20) {
            // Image Preview
            if let image = inputImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding()
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
                    .font(.headline)
            }

            // Image Selection Buttons
            HStack(spacing: 20) {
                Button(action: {
                    showingImagePicker = true
                }) {
                    Label("Choose from Gallery", systemImage: "photo")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Button(action: {
                    showingCameraPicker = true
                }) {
                    Label("Capture Photo", systemImage: "camera")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()

            // Run Inference Button
            Button(action: {
                if let image = inputImage {
                    analyzeImage(image: image)
                } else {
                    resultLabel = "Please select or capture an image first."
                }
            }) {
                Label("Run Analysis", systemImage: "bolt.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(isProcessing) // Disable while processing

            // Display Inference Result
            if isProcessing {
                ProgressView("Processing...") // Shows while running inference
                    .padding()
            } else {
                Text("Result: \(resultLabel)")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .sheet(isPresented: $showingCameraPicker) {
            CameraPicker(image: $inputImage)
        }
    }

    /// Runs the model inference on the selected image
    private func analyzeImage(image: UIImage) {
        guard let inputData = TFLiteImageProcessor.preprocessImage(image) else {
            resultLabel = "Image preprocessing failed."
            return
        }

        isProcessing = true // Start loading
        DispatchQueue.global(qos: .userInitiated).async {
            classifier.analyzeNail(imageData: inputData)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.resultLabel = classifier.getDiagnosis()
                self.isProcessing = false // Stop loading
            }
        }
    }
}

#Preview {
    ContentView()
}
