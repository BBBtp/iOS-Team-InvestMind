
import Foundation
import SwiftUI

struct Asset: Identifiable, Hashable {
    enum Trend: Equatable, Hashable {
        case up(Double)
        case down(Double)

        var value: Double {
            switch self {
            case .up(let value), .down(let value):
                return value
            }
        }

        var isPositive: Bool {
            if case .up = self { return true }
            return false
        }
    }

    let id = UUID()
    let ticker: String
    let name: String
    let price: Double
    let change: Trend
    let icon: String
}

struct PortfolioAsset: Identifiable {
    let id = UUID()
    let asset: Asset
    let amount: Double
    let invested: Double

    var profit: Double {
        amount * asset.price - invested
    }
}

struct PortfolioSummary {
    let totalValue: Double
    let invested: Double
    let dailyChange: Double
}

struct GuideStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let showsAuthActions: Bool
}

enum AppRoute: Hashable {
    case dashboard
    case stockDetail(Asset)
    case portfolio
    case profile
}

enum FlowStep {
    case splash
    case onboarding
    case survey
    case auth
    case register
    case postAuthGuide
    case main
}

enum MockData {
    static let assets: [Asset] = [
        Asset(ticker: "AAPL", name: "Apple", price: 189.54, change: .up(2.31), icon: "applelogo"),
        Asset(ticker: "TSLA", name: "Tesla", price: 247.12, change: .down(1.14), icon: "bolt.fill"),
        Asset(ticker: "NFLX", name: "Netflix", price: 455.18, change: .up(0.78), icon: "film.fill"),
        Asset(ticker: "AMZN", name: "Amazon", price: 136.44, change: .up(1.92), icon: "cart.fill"),
        Asset(ticker: "NVDA", name: "NVIDIA", price: 492.65, change: .up(4.54), icon: "cpu.fill")
    ]

    static let portfolioAssets: [PortfolioAsset] = [
        PortfolioAsset(asset: assets[0], amount: 20, invested: 3000),
        PortfolioAsset(asset: assets[1], amount: 8, invested: 1500),
        PortfolioAsset(asset: assets[2], amount: 5, invested: 2000)
    ]

    static let portfolioSummary = PortfolioSummary(
        totalValue: 12450,
        invested: 9800,
        dailyChange: 2.4
    )

    static let onboardingPages: [OnboardingPage] = [
        OnboardingPage(
            title: "Увеличьте свою\nприбыль",
            subtitle: "Раскройте потенциал прибыли для финансового роста",
            showsAuthActions: false
        ),
        OnboardingPage(
            title: "Начните торговлю\nакциями",
            subtitle: "Оптимизируйте инвестиционные решения с помощью квалифицированных рекомендаций",
            showsAuthActions: true
        )
    ]

    static let postAuthGuide: [GuideStep] = [
        GuideStep(title: "Главная", description: "Сводка рынка и персональные рекомендации.", iconName: "house.fill"),
        GuideStep(title: "Портфель", description: "Детальные данные по активам и прибыли.", iconName: "briefcase.fill"),
        GuideStep(title: "Профиль", description: "Настройки, подписки и поддержка.", iconName: "person.crop.circle.fill")
    ]
}

