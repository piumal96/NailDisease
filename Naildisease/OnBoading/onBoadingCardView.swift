//
//  Untitled 2.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-03-16.
//


import SwiftUI

struct OnBordingCardView: View {
    // MARK: - PROPERTIES
    
    var onBording: OnBording
    
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
      ZStack {
        VStack(spacing: 15) {
            Image(onBording.image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
//                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                .scaleEffect(isAnimating ? 1.0 : 0.6)

          Text(onBording.title)
            .foregroundColor(Color.blue)
            .font(.largeTitle)
            .fontWeight(.heavy)
//            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
    
          Text(onBording.headline)
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
            .frame(maxWidth: 480)
          
          // BUTTON: START
          //  StartButtonView(isOnboarding: .constant(false))
        } //: VSTACK
      } //: ZSTACK
      .onAppear {
        withAnimation(.easeOut(duration: 0.5)) {
          isAnimating = true
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
      .background(Color.white) // Set the background color to white
      .cornerRadius(20)
      .padding(.horizontal, 20)
    }
}

struct OnBordingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBordingCardView(onBording: onBordingData[0])
    }
}
