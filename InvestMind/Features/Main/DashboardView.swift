

import SwiftUI

struct DashboardView: View {
    var assets: [Asset]
    var onOpenAsset: (Asset) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                header
                stats
                Text("Рекомендации")
                    .font(AppTypography.headline(weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)

                LazyVStack(spacing: AppSpacing.md) {
                    ForEach(assets) { asset in
                        AssetCompactCard(asset: asset)
                            .onTapGesture { onOpenAsset(asset) }
                    }
                }
            }
            .padding()
        }
        .background(AppColors.backgroundPrimary.ignoresSafeArea())
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Добро пожаловать назад")
                .font(AppTypography.caption())
                .foregroundStyle(AppColors.textSecondary)
            Text("Твой капитал растёт")
                .font(AppTypography.largeTitle(weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
        }
    }

    private var stats: some View {
        HStack(spacing: AppSpacing.md) {
            StatBadge(
                title: "Портфель",
                value: "$12 450",
                trend: .up(2.4)
            )

            StatBadge(
                title: "Доходность",
                value: "+$1 150",
                trend: .up(9.4)
            )
        }
    }
}


