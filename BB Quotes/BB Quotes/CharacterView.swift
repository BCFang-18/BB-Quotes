//
//  CharacterView.swift
//  BB Quotes
//
//  Created by Baicheng Fang on 5/2/24.
//

import SwiftUI

struct CharacterView: View {
    let show: String
    let character: Character
    
    var body: some View {
        GeometryReader {geo in
            ZStack(alignment: .top) {
                // background image
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    // character image
                    
                    VStack {
                        AsyncImage(url: character.images.randomElement()) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }

                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top, 60)
                    
                    // character info
                    VStack(alignment: .leading) {
                        Group {
                            Text(character.name)
                                .font(.largeTitle)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                        }
                        
                        Group {
                            Text("Ocupations:")
                            
                            ForEach(character.occupations, id: \.self) {occupation in
                                Text("•\(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            
                            Text("Nicknames: ")
                            
                            if character.aliases.count > 0{
                                ForEach(character.aliases, id:\.self) {alias in
                                    Text("•\(alias)")
                                        .font(.subheadline)
                                }
                            } else{
                                Text("None")
                                    .font(.subheadline)
                            }
                        }
                        
                    }
                    .padding([.leading, .bottom], 40)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(show: Constants.bbN, character: Constants.previewCharacter)
}
