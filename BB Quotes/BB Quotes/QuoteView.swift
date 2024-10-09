//
//  QuoteView.swift
//  BB Quotes
//
//  Created by Baicheng Fang on 5/2/24.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    @State private var showCharacterInfo = false
    let show: String
    
    var body: some View {
        GeometryReader { geo in  // only reads half of the screen when used side by side with other app
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height:geo.size.height * 1.1)
                
                VStack {
                    VStack {
                        Spacer(minLength: 100)
                        
                        switch viewModel.status {
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom){
                                //                            Image(.jessepinkman)
                                //                                .resizable()
                                //                                .scaledToFill()
                                
                                AsyncImage(url: data.character.images.randomElement()) { image in
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {  // while image is loading
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                                .sheet(isPresented: $showCharacterInfo){
                                    CharacterView(show: show, character: data.character)
                                }
                                
                                
                                Text(data.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)  // not real infinity, just to ZStack
                                    .background(.ultraThinMaterial)  // affected by pic behind
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 80))
                            
                        case .fetching:
                            ProgressView()
                            
                        default:
                            EmptyView()
                            
                        }
                        Spacer()
                    }
                    
                    Button {  // only Text is tappable? Put it in 
                        Task{
                            await viewModel.getData(for: show)
                        }
                    } label : {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color("\(show.noSpaces)Button"))
                            .clipShape(.rect(cornerRadius: 7))
                            .shadow(color: Color("\(show.noSpaces)Shadow"), radius: 2)
                        
                    }
                    Spacer(minLength: 160)
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: Constants.bcsN)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
