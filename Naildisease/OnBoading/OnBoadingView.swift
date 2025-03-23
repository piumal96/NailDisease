//
//  Untitled 5.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-03-16.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var selectedPage = 0 // Track the current page
    var onBordings: [OnBording] = onBordingData
    @Binding var isOnboarding: Bool
    @Binding var selectedTab: String

    var body: some View {
        GeometryReader { geometry in
            VStack {
                TabView(selection: $selectedPage) {
                    ForEach(onBordings) { item in
                        ZStack(alignment: .bottom) {
                            OnBordingCardView(onBording: item)
                            VStack{
                                Spacer()
                                if item == onBordings.last {
                                    Button(action: goToZero) {
                                        HStack(spacing: 8) {
                                            Text("Try Scan")
                                                .font(.headline)
                                                .foregroundColor(.blue)
//                                            Image(systemName: "arrow.right")
//                                                .imageScale(.large)
//                                                .foregroundColor(.blue) // Set the arrow color here
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(
                                            Capsule().strokeBorder(Color.blue, lineWidth: 1.25)
                                        )
                                    }
                                    .foregroundColor(Color.blue) // This will set the text color
                                    
                                    
                                    
                                } else {
                                    Button(action: incrementPage) {
                                        HStack(spacing: 8) {
                                            Text("Next ")
                                                .font(.headline)
                                                .foregroundColor(.blue)
                                            Image(systemName: "arrow.right")
                                                .imageScale(.large)
                                                .foregroundColor(.blue) // Set the arrow color here
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(
                                            Capsule().strokeBorder(Color.white, lineWidth: 1.25)
                                        )
                                    }
                                    .foregroundColor(Color.blue) // This will set the text color
                                }
                                
                            }
                            .position(x: geometry.size.width / 2, y: 270)
                        }
                       
                    
                
                        .tag(item.tag)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            //.frame(height: geometry.size.height * 1.9) // Adjust the height as necessary

                Spacer()
                // Custom indicator dots
                HStack(spacing: 8) {
                    ForEach(onBordings.indices, id: \.self) { index in
                        Circle()
                            .fill(selectedPage == index ? Color.blue : Color.gray) // Active color is blue, inactive is gray
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 10)
                Spacer()
            }
        }
        .background(Color.white.ignoresSafeArea())
    }

    func incrementPage() {
        selectedPage = (selectedPage + 1) % onBordings.count // Loop back to the first page after the last one
    }

    func goToZero() {
        UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
                UserDefaults.standard.synchronize()
                
                // Print out the value of isOnboardingCompleted to confirm the update
                let updatedValue = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
//                print("isOnboardingCompleted updated to:", updatedValue)
                
                self.selectedTab = "Scan"
                self.isOnboarding = true
    }
}
