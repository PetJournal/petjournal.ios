import SwiftUI

struct SkeletonView: View {
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat
    
    @State private var animateShimmer = false
    
    init(width: CGFloat? = nil, height: CGFloat = 20, cornerRadius: CGFloat = 8) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.2))
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.6), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .offset(x: animateShimmer ? 200 : -200)
            )
            .clipped()
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                    animateShimmer = true
                }
            }
    }
}

// MARK: - Convenience Initializers
extension SkeletonView {
    static func text() -> SkeletonView {
        SkeletonView(height: 16, cornerRadius: 4)
    }
    
    static func title() -> SkeletonView {
        SkeletonView(height: 24, cornerRadius: 6)
    }
    
    static func button() -> SkeletonView {
        SkeletonView(height: 44, cornerRadius: 8)
    }
    
    static func circle(size: CGFloat = 40) -> some View {
        Circle()
            .fill(Color.gray.opacity(0.2))
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.6), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .clipped()
    }
    
    static func cardSet() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                circle(size: 50)
                VStack(alignment: .leading, spacing: 6) {
                    title()
                    text()
                        .frame(width: 120)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                text()
                text()
                    .frame(width: 200)
                text()
                    .frame(width: 150)
            }
            
            button()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Elementos Individuais")
                    .font(.headline)
                
                SkeletonView.title()
                SkeletonView.text()
                SkeletonView.text()
                    .frame(width: 200)
                
                HStack {
                    SkeletonView.circle()
                    VStack(alignment: .leading, spacing: 8) {
                        SkeletonView(width: 120, height: 16)
                        SkeletonView(width: 80, height: 14)
                    }
                    Spacer()
                }
                
                SkeletonView.button()
            }
            .padding()
            
            Divider()
            
            VStack(spacing: 16) {
                Text("Conjunto Padrão")
                    .font(.headline)
                
                SkeletonView.cardSet()
            }
            .padding(.horizontal)
        }
    }
}
