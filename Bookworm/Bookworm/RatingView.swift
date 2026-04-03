import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6) { number in
                Button {
                    rating = number
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(number <= rating ? Color.yellow : Color.gray)
                }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue(rating == 1 ? "1 Star" : "\(rating) Stars")
        .accessibilityAdjustableAction{ direction in
            switch direction {
            case .increment: if rating < 5 { rating += 1 }
            case .decrement: if rating > 1 { rating -= 1 }
            default: break
            }
        }
        
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
