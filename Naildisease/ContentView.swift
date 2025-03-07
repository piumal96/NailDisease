//
//  ContentView.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-02-26.
//

import SwiftUI
import NailDiseaseSDK

struct ContentView: View {
    @StateObject private var modelHandler = TFLiteModelHandler(modelName: "model")
    @State private var inputImage: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var resultLabel: String = "No result yet"

    var body: some View {
        VStack {
            // Show selected image or placeholder text
            if let image = inputImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
            }

            // Button to select an image
            Button("Select Image") {
                showingImagePicker = true
            }
            .padding()
            .buttonStyle(.borderedProminent)

            // Button to run inference
            Button("Run Inference") {
                if let image = inputImage {
                    runModelInference(image: image)
                } else {
                    resultLabel = "Please select an image first."
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)

            // Display inference result
            Text("Inference Result: \(resultLabel)")
                .padding()
                .multilineTextAlignment(.center)

            Spacer()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }

    /// Runs the model inference on the selected image
    private func runModelInference(image: UIImage) {
        guard let inputData = TFLiteImageProcessor.preprocessImage(image) else {
            resultLabel = "Image preprocessing failed."
            return
        }

        modelHandler.runInference(inputData: inputData)

        // Wait a bit for inference to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            resultLabel = modelHandler.getInferenceLabel()
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
