//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Vitaliy Novichenko on 28.08.2023.
//

import SwiftUI

struct ContentView: View {
    let item = ["🖐️","✌️","👊"]
    @State private var choosenAi = Int.random(in: 0...2)
    @State private var winOrLoose = Bool.random()
    @State private var score = 0
    @State private var winArray = [String()]
    @State private var looseArray = [String()]
    @State private var showingAlert = false
    func reset() {
        winArray = []
        looseArray = []
        score = 0
    }
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(stops: [
                    .init(color: .cyan, location: 0.1),
                    .init(color: .indigo, location: 0.5)
                    // .init(color: .yellow, location: 0.8)
                ], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    .navigationTitle("The Chat ... game")
                        
                VStack {
                    
                    Spacer()
                    HStack {
                        HStack {
                            Text( winOrLoose ? "Should Win" : "Should Loose" )
                                .font(.title.bold())
                                .foregroundColor(winOrLoose ? .secondary : .brown)
                            
                        }
                        .frame(maxWidth: 300, maxHeight: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer()
                    }
                    
                    VStack {
                        Text(item[choosenAi])
                            .font(.system(size: 75))
                    }
                    .frame(maxWidth: 200, maxHeight: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    HStack {
                        VStack {
                            Text("Correct : \(winArray.formatted())")
                                .padding()
                            Text("Wrong : \(looseArray.formatted())")
                        }
                        .font(.title3.bold())
                        .foregroundColor(.secondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    HStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Text("Score \(score)")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .padding(.vertical, 20)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                buttonWasTapped(number)
                                winOrLoose = Bool.random()
                            } label: {
                                Text(item[number])
                                    .padding(25)
                                    .font(.system(size: 50))
                            }
                        }
                    }
                    .frame(width: 350, height: 70)
                    .padding(.vertical, 20)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    Button("Reset", action: reset)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: 200)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(50)
            }
        }
        .alert("Your score is \(score)", isPresented: $showingAlert) {
            Button("New Game", action: reset)
        } message: {
            Text("Game Over")
        }
    }
    func buttonWasTapped(_ number: Int)  {
        if winOrLoose {
            if number > choosenAi || number == 0 && choosenAi == 2 {
                score += 1
                winArray.append("👍")
            } else {
                score -= 1
                looseArray.append("👎")
            }
        } else {
            if number < choosenAi || number == 2 && choosenAi == 0 {
                score += 1
                winArray.append("👍")
            } else {
                score -= 1
                looseArray.append("👎")
            }
        }
        winOrLoose.toggle()
        choosenAi = Int.random(in: 0...2)
        if winArray.count + looseArray.count == 10 {
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
