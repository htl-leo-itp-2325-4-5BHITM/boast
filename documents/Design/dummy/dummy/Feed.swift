

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // USER
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.title3)
                            Text("@Username")
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                
                // BET
                Text("I bet we will get an A+")
                    .font(.title3)
                
                HStack {
                    Button(action: {}, label: {
                        Text("4")
                            .font(.callout)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("10€")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            .padding(10)
            
            VStack(alignment: .leading) {
                // USER
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.title3)
                            Text("@Username")
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                
                // BET
                Text("I bet ")
                    .font(.title3)
                
                HStack {
                    Button(action: {}, label: {
                        Text("9")
                            .font(.callout)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("1€")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            .padding(10)
            
            VStack(alignment: .leading) {
                // USER
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.title3)
                            Text("@Username")
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                
                // BET
                Text("I bet")
                    .font(.title3)
                
                HStack {
                    Button(action: {}, label: {
                        Text("4")
                            .font(.callout)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("10€")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            .padding(10)
            
            VStack(alignment: .leading) {
                // USER
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.title3)
                            Text("@Username")
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                
                // BET
                Text("I bet")
                    .font(.title3)
                
                HStack {
                    Button(action: {}, label: {
                        Text("4")
                            .font(.callout)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("10€")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            .padding(10)
            
            VStack(alignment: .leading) {
                // USER
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.title3)
                            Text("@Username")
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                
                // BET
                Text("I bet")
                    .font(.title3)
                
                HStack {
                    Button(action: {}, label: {
                        Text("4")
                            .font(.callout)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("10€")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    Feed()
}
