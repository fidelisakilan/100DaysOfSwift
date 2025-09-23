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
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
