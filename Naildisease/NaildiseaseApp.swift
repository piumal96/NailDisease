//
//  NaildiseaseApp.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-02-26.
//

import SwiftUI
import NailDiseaseSDK

@main
struct NaildiseaseApp: App {
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false
    @State private var selectedTab: String = "Home"

    var body: some Scene {
        WindowGroup {
            if isOnboardingCompleted {
                ContentView() // Main App Content
            } else {
                OnBoardingView(isOnboarding: $isOnboardingCompleted, selectedTab: $selectedTab)
            }
        }
    }
}
