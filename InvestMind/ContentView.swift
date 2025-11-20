//
//  ContentView.swift
//  InvestMind
//
//  Created by Богдан Топорин on 19.11.2025.
//

import SwiftUI
struct ContentView: View {
    @State private var flowStep: FlowStep = .splash

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary
                .ignoresSafeArea()

            switch flowStep {
            case .splash:
                SplashView {
                    flowStep = .onboarding
                }
                .transition(.opacity)
            case .onboarding:
                OnboardingView(
                    pages: MockData.onboardingPages,
                    onStartFree: { flowStep = .survey },
                    onSelectLogin: { flowStep = .auth }
                )
                .transition(.move(edge: .trailing))
            case .survey:
                SurveyView(
                    onComplete: { flowStep = .register },
                    onBack: { flowStep = .onboarding }
                )
                .transition(.move(edge: .trailing))
            case .auth:
                AuthView(
                    onAuthenticated: { flowStep = .postAuthGuide },
                    onShowRegister: { flowStep = .register }
                )
                .transition(.move(edge: .trailing))
            case .register:
                RegisterView(
                    onRegistered: { flowStep = .postAuthGuide },
                    onShowLogin: { flowStep = .auth }
                )
                .transition(.move(edge: .trailing))
            case .postAuthGuide:
                PostAuthGuideView(steps: MockData.postAuthGuide) {
                    flowStep = .main
                }
                .transition(.opacity)
            case .main:
                MainTabView(
                    assets: MockData.assets,
                    portfolio: MockData.portfolioAssets,
                    summary: MockData.portfolioSummary
                )
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: flowStep)
    }
}

#Preview {
    ContentView()
}
