
import SwiftUI

struct MainTabView: View {
    var assets: [Asset]
    var portfolio: [PortfolioAsset]
    var summary: PortfolioSummary

    @State private var selectedTab = 0
    @State private var dashboardPath = NavigationPath()
    @State private var portfolioPath = NavigationPath()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $dashboardPath) {
                DashboardView(assets: assets) { asset in
                    dashboardPath.append(AppRoute.stockDetail(asset))
                }
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .stockDetail(let asset):
                        StockDetailView(asset: asset)
                    default:
                        EmptyView()
                    }
                }
            }
            .tabItem {
                Label("Главная", systemImage: "house.fill")
            }
            .tag(0)

            NavigationStack(path: $portfolioPath) {
                PortfolioView(summary: summary, assets: portfolio, onOpenAsset: { asset in
                    portfolioPath.append(AppRoute.stockDetail(asset))
                })
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .stockDetail(let asset):
                            StockDetailView(asset: asset)
                        default:
                            EmptyView()
                        }
                    }
            }
            .tabItem {
                Label("Портфель", systemImage: "briefcase.fill")
            }
            .tag(1)

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Профиль", systemImage: "person.fill")
            }
            .tag(2)
        }
        .tint(AppColors.accentPrimary)
        .background(AppColors.backgroundPrimary)
    }
}

