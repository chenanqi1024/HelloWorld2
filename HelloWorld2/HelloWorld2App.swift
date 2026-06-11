//
//  HelloWorld2App.swift
//  HelloWorld2
//
//  Created by chenanqi on 2026/6/3.
//

import SwiftUI

@main
struct HelloWorld2App: App {
    var body: some Scene {
        WindowGroup {
            FortuneView()
        }
    }
}

struct FortuneView: View {
    @State private var fortuneText = "点击按钮，抽取今日运势"

    private let fortunes = [
        "大吉：今天适合主动出击，好消息正在路上。",
        "中吉：稳扎稳打的一天，适合推进计划。",
        "小吉：会遇到一点小惊喜，保持好心情。",
        "平：普通但安稳的一天，适合整理思路。"
    ]

    var body: some View {
        ZStack {
            background

            GlassEffectContainer(spacing: 24) {
                VStack(spacing: 28) {
                    Label("今日运势", systemImage: "sparkles")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .glassEffect(.regular, in: .rect(cornerRadius: 22))

                    Text(fortuneText)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(28)
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .glassEffect(.regular.tint(.yellow.opacity(0.18)), in: .rect(cornerRadius: 28))
                        .padding(.horizontal)

                    Button {
                        fortuneText = fortunes.randomElement() ?? "今日好运已送达"
                    } label: {
                        Label("抽一个", systemImage: "wand.and.sparkles")
                            .font(.title2.weight(.semibold))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.glassProminent)
                }
                .padding()
            }
        }
    }

    private var background: some View {
        LinearGradient(
            colors: [
                Color.cyan.opacity(0.35),
                Color.indigo.opacity(0.28),
                Color.orange.opacity(0.22)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay {
            Image(systemName: "sparkles")
                .font(.system(size: 180, weight: .thin))
                .foregroundStyle(.white.opacity(0.18))
                .offset(x: 90, y: -180)
        }
    }
}
