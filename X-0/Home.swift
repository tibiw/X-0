//
//  Home.swift
//  X-0
//
//  Created by Tibor Waxmann on 24/10/2020.
//

import SwiftUI

struct Home: View {
    // MARK: - PROPERTIES
    
    @State private var moves: [String] = Array(repeating: "", count: 9)
    @State private var isPlaying: Bool = true
    @State private var gameOver: Bool = false
    @State private var message: String = ""
    
    // MARK: - BODY
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                ForEach(0..<9, id: \.self) { index in
                    ZStack {
                        Color.blue
                        
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .opacity(moves[index] != "" ? 1 : 0)
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "X" : "0"
                                isPlaying.toggle()
                            }
                        }
                    })
                }
            }
            .padding()
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Winner"), message: Text(message), dismissButton: .destructive(Text("Play again"), action: {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: Calculate width
    func getWidth() -> CGFloat {
        // horizontal padding = 30
        // spacing = 30
        let width = UIScreen.main.bounds.width - (30 + 30)
        return width / 3
    }
    
    // MARK: Checking for winner
    func checkWinner() {
        if checkMoves(player: "X") {
            message = "Player X won !"
            gameOver.toggle()
        } else if checkMoves(player: "0") {
            message = "Player 0 won !"
            gameOver.toggle()
        } else {
            // checking no moves
            
            let status = moves.contains { (value) -> Bool in
                return value == ""
            }
            
            if !status {
                message = "Game Over Tied !"
                gameOver.toggle()
            }
        }
    }
    
    func checkMoves(player: String) -> Bool {
        // horizontal moves
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player {
                return true
            }
        }
        
        // vertical moves
        for i in 0...2 {
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player {
                return true
            }
        }
        
        // checking diagonal
        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }

        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }

        return false
    }
}

// MARK: - PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
