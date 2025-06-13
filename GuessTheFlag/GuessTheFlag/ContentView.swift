import SwiftUI

struct ContentView:View {
    @State private var countries = [ "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var tappedNumber = 0
    @State private var activeFlag = 999
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green:0.2, blue: 0.65), location: 0.3),
                .init(color: Color(red:0.76, green:0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        let rotation = activeFlag == number ? 360.0 : 0.0
                        let opacity = activeFlag == 999 || activeFlag == number ? 1.0 : 0.25
                        Button {
                            withAnimation(.linear(duration: 1)) {
                                activeFlag = number
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                flagTapped(number)
                            }
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(.degrees(rotation), axis: (x:0, y: 1, z: 0))
                        .opacity(opacity)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue",role:.cancel, action: askQuestion)
            Button("Reset",role: .destructive,action: reset)
        } message: {
            Text("""
            Wrong! That's flag of \(countries[tappedNumber])
            Your score is \(score)
            """)
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 50
            askQuestion()
        } else {
            scoreTitle = "Wrong"
            showingScore = true
        }
    }
    
    func reset() {
        askQuestion()
        score = 0
    }
    
    func askQuestion() {
        activeFlag = 999
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
