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
    @State private var resultLabel: String = "No analysis yet"
    @State private var isProcessing = false // Loading state

    var body: some View {
        VStack(spacing: 25) {
            
            // App Header
            VStack(spacing: 5) {
                Text("Nail Disease ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Text("Analyze your nail condition with AI")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 10)

            // Image Preview
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
                    .frame(height: 250)
                    .shadow(radius: 4)
                
                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding()
                } else {
                    VStack {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No image selected")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
            }
            .padding(.horizontal)

            // Image Selection Buttons
            HStack(spacing: 15) {
                Button(action: {
                    showingImagePicker = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                        Text("Select")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.blue)

                Button(action: {
                    showingCameraPicker = true
                }) {
                    HStack {
                        Image(systemName: "camera")
                        Text("Capture")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            .padding(.horizontal)

            // Run Analysis Button
            Button(action: {
                if let image = inputImage {
                    analyzeImage(image: image)
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred() // Haptic feedback
                } else {
                    resultLabel = "Please select or capture an image first."
                }
            }) {
                HStack {
                    Image(systemName: "bolt.fill")
                    Text("Analyze Nail")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .padding(.horizontal)
            .disabled(isProcessing) // Disable while processing

            // Analysis Result
            VStack {
                if isProcessing {
                    ProgressView("Analyzing nail condition...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                } else {
                    VStack(spacing: 8) {
                        Text("Diagnosis Result")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text(resultLabel)
                            .font(.title2)
                            .bold()
                            .foregroundColor(resultLabel.contains("Healthy") ? .green : .red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .frame(height: 80)

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

    /// Runs the AI analysis on the selected nail image
    private func analyzeImage(image: UIImage) {
        guard let inputData = TFLiteImageProcessor.preprocessImage(image) else {
            resultLabel = "Error: Image processing failed."
            return
        }

        isProcessing = true // Start loading
        DispatchQueue.global(qos: .userInitiated).async {
            classifier.analyzeNail(imageData: inputData)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.resultLabel = classifier.getDiagnosis()
                self.isProcessing = false // Stop loading
            }
        }
    }
}

#Preview {
    ContentView()
}
