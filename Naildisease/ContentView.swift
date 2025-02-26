//
//  ContentView.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-02-26.
//

import SwiftUI
import NailDiseaseSDK
struct ContentView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!");
            Button("Naildisease") {
                NailDiseaseSDK.TFLiteTest.testPrint()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
