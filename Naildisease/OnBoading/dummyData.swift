//
//  Untitled 3.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-03-16.
//
import Foundation
import SwiftUI

// MARK: - ONBOARDING DATA FOR NAIL DISEASE IDENTIFICATION

let onBordingData: [OnBording] = [
    OnBording(
        title: "Prepare Your Nail",
        headline: "Ensure your nail is clean and place it in a well-lit area for better accuracy.",
        image: "1",
        gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")],
        tag: 0
    ),
    OnBording(
        title: "Capture Your Nail",
        headline: "Position your finger within the on-screen frame and take a clear photo.",
        image: "2",
        gradientColors: [Color("ColorStrawberryLight"), Color("ColorStrawberryDark")],
        tag: 1
    ),
    OnBording(
        title: "Avoid Blurry Images",
        headline: "Hold still while capturing to ensure sharp and clear images for precise analysis.",
        image: "3",
        gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")],
        tag: 2
    ),
    OnBording(
        title: "Get Instant Analysis",
        headline: "Our AI will analyze your nail condition and provide possible health insights.",
        image: "4",
        gradientColors: [Color("ColorPlumLight"), Color("ColorPlumDark")],
        tag: 3
    ),
]
