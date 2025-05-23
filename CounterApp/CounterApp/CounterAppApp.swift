import SwiftUI

@main
struct CounterAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(title: "IOS Demo App")
        }
    }
}

struct ContentView: View {
    let title: String
    @State private var count: Int = 0
    
    var body: some View {
        NavigationView{
            VStack{
                Text("You have pushed the buttoms these many times")
                    .padding(.bottom, 20)
                Text("\(count)")
                    .padding(.bottom,20)
                Spacer()
                HStack{
                    Spacer()
                    Button(action: incrementCounter) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size:50))
                    }
                    .padding(.bottom,20)
                    .padding(.trailing,20)
                }
            }
        }
        .padding()
        .navigationTitle(title)
    }
    
    private func incrementCounter(){
        count += 1
    }
}

#Preview {
    ContentView(title: "IOS Demo App")
}
