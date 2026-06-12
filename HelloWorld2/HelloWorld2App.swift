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
    @State private var selectedFortune: Fortune?
    @State private var drawRotation = 0.0

    private let fortunes: [Fortune] = [
        Fortune(
            level: "大吉",
            symbol: "sun.max.fill",
            verse: "云开月明，所求皆有回应",
            guidance: "适合主动表达与推进计划，好消息正在路上。",
            luckyDetail: "幸运色 · 琥珀金"
        ),
        Fortune(
            level: "中吉",
            symbol: "moon.stars.fill",
            verse: "星河缓行，好事悄然生长",
            guidance: "稳扎稳打会比追求速度更有收获，耐心等待结果。",
            luckyDetail: "幸运时刻 · 黄昏"
        ),
        Fortune(
            level: "小吉",
            symbol: "sparkles",
            verse: "微光引路，偶遇温柔惊喜",
            guidance: "留意身边不起眼的机会，轻松的选择会带来好运。",
            luckyDetail: "幸运方位 · 东南"
        ),
        Fortune(
            level: "平",
            symbol: "circle.dotted",
            verse: "静水流深，安稳自有力量",
            guidance: "适合整理思绪与休息蓄力，不必急着得到答案。",
            luckyDetail: "今日宜 · 独处"
        )
    ]

    var body: some View {
        ZStack {
            background

            ScrollView {
                VStack(spacing: 26) {
                    header
                    fortuneCard
                    Button {
                        drawFortune()
                    } label: {
                        Label(selectedFortune == nil ? "揭示今日签文" : "再次问询星辰", systemImage: "sparkles")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color(red: 0.78, green: 0.58, blue: 0.20))
                    .padding(.horizontal, 28)
                }
                .padding(.vertical, 30)
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.dark)
    }

    private var background: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.04, blue: 0.10),
                    Color(red: 0.12, green: 0.06, blue: 0.14),
                    Color(red: 0.03, green: 0.11, blue: 0.14)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            CelestialDial()
                .foregroundStyle(Color(red: 0.91, green: 0.73, blue: 0.34).opacity(0.18))
                .offset(y: -160)

            Image(systemName: "moon.stars.fill")
                .font(.system(size: 44, weight: .thin))
                .foregroundStyle(Color(red: 0.55, green: 0.86, blue: 0.88).opacity(0.22))
                .offset(x: -130, y: 280)
        }
        .ignoresSafeArea()
    }

    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "moonphase.first.quarter.inverse")
                .font(.title2)
                .foregroundStyle(Color(red: 0.91, green: 0.73, blue: 0.34))

            Text("今日灵签")
                .font(.largeTitle.weight(.semibold))

            Text("静心片刻，聆听星辰的指引")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var fortuneCard: some View {
        VStack(spacing: 0) {
            HStack {
                Label("星辰启示", systemImage: "sparkle")
                Spacer()
                Text("第 \(Calendar.current.ordinality(of: .day, in: .year, for: .now) ?? 1) 签")
            }
            .font(.caption.weight(.medium))
            .foregroundStyle(Color(red: 0.91, green: 0.73, blue: 0.34))
            .padding(.bottom, 22)

            if let selectedFortune {
                Image(systemName: selectedFortune.symbol)
                    .font(.system(size: 34, weight: .light))
                    .foregroundStyle(Color(red: 0.55, green: 0.86, blue: 0.88))
                    .padding(.bottom, 12)

                Text(selectedFortune.level)
                    .font(.system(size: 42, weight: .medium, design: .serif))
                    .foregroundStyle(Color(red: 0.97, green: 0.86, blue: 0.57))

                Text(selectedFortune.verse)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)

                Divider()
                    .overlay(Color.white.opacity(0.16))
                    .padding(.vertical, 20)

                Text(selectedFortune.guidance)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.76))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)

                Label(selectedFortune.luckyDetail, systemImage: "diamond.fill")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color(red: 0.55, green: 0.86, blue: 0.88))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .glassEffect(.clear, in: .capsule)
                    .padding(.top, 20)
            } else {
                Image(systemName: "seal")
                    .font(.system(size: 50, weight: .ultraLight))
                    .foregroundStyle(Color(red: 0.91, green: 0.73, blue: 0.34))
                    .padding(.bottom, 18)

                Text("签文尚未揭晓")
                    .font(.title2.weight(.medium))

                Text("深呼吸，然后轻触下方按钮")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 350, alignment: .top)
        .padding(26)
        .glassEffect(.regular.tint(Color(red: 0.38, green: 0.18, blue: 0.48).opacity(0.22)), in: .rect(cornerRadius: 24))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(red: 0.91, green: 0.73, blue: 0.34).opacity(0.24), lineWidth: 1)
        }
        .padding(.horizontal, 20)
        .rotation3DEffect(.degrees(drawRotation), axis: (x: 0, y: 1, z: 0))
        .animation(.spring(duration: 0.65, bounce: 0.2), value: drawRotation)
    }

    private func drawFortune() {
        withAnimation {
            selectedFortune = fortunes.randomElement()
            drawRotation += 360
        }
    }
}

private struct Fortune {
    let level: String
    let symbol: String
    let verse: String
    let guidance: String
    let luckyDetail: String
}

private struct CelestialDial: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 310, height: 310)

            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 9]))
                .frame(width: 250, height: 250)

            ForEach(0..<12, id: \.self) { index in
                Image(systemName: index.isMultiple(of: 3) ? "sparkle" : "diamond.fill")
                    .font(index.isMultiple(of: 3) ? .caption : .system(size: 4))
                    .offset(y: -155)
                    .rotationEffect(.degrees(Double(index) * 30))
            }
        }
    }
}

#Preview {
    FortuneView()
}
