import SwiftUI
import SwiftData

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    let book: Book
    @State private var showingAlert = false
    
    func onDelete() {
        modelContext.delete(book)
        dismiss()
    }
    
    var body: some View {
        Form {
            Section {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre)
                        .resizable()
                        .scaledToFit()
                    
                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.5))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                }
                .listRowInsets(EdgeInsets())
                .clipped()
            }
            Section {
                HStack {
                    Text("Author:")
                        .bold()
                    Spacer()
                    Text(book.author)
                }
                HStack {
                    Text("Review:")
                        .bold()
                    Spacer()
                    Text(book.review)
                }
                HStack {
                    Text("Date:")
                        .bold()
                    Spacer()
                    Text(book.date,format: .dateTime.day().month(.abbreviated).year())
                }
                HStack {
                    Text("Rating:")
                        .bold()
                    Spacer()
                    RatingView(rating: .constant(book.rating))
                }
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingAlert) {
            Button("Delete", role: .destructive,action: onDelete)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingAlert = true
            }
        }
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(
            title: "Text Title",
            author: "Test Author",
            genre: "Fantasy",
            review: "This is a sample review",
            rating: 4,
        )
        return DetailsView(book: example).modelContainer(container)
    } catch {
        return Text("Failed to create preview \(error.localizedDescription)")
    }
}
