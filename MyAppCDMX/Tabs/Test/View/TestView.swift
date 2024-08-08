//
//  TestView.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 07/08/24.
//

import SwiftUI

struct TestView: View {
    
    // Datos dummy para vaciar en el Grid
    let items = [modelGrid.init(id: 1, icon: "icono", color: .purple, title: "Pay Someone", description: "To Wallet, bank or mobile number"),
        modelGrid.init(id: 2, icon: "icono", color: .green, title: "Request Money", description: "Request money from OroboPay users"),
        modelGrid.init(id: 3, icon: "icono", color: .yellow, title: "Buy Airtime", description: "Top-up or send airtime across Africa"),
        modelGrid.init(id: 4, icon: "icono", color: .gray, title: "Pay Bill", description: "Zero transaction fees when you pay")]
    
      let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
      ]
    
    var body: some View {
        NavigationStack {
            
            GeometryReader { proxy in
                VStack(alignment: .leading){
                    Image("GhanaFlag")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                        .shadow(radius: 1)
                        .padding(.leading, 0)
                        .padding(.top, -11)
                    
                    Text("GHS")
                        .frame(width: 50, height: 30)
                        .padding(.leading, 20)
                        .padding(.top, -33)
                        .foregroundStyle(.gray)
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 13, height: 13)
                        .foregroundColor(.gray)
                        .shadow(radius: 1)
                        .padding(.leading, 75)
                        .padding(.top, -33)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Here are some things you can do")
                        .frame(width: proxy.size.width * 0.9, height: 30, alignment: .leading)
                        .padding()
                        .padding(.leading, -14)
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                          ForEach(items, id: \.id) { item in
                              Text(item.title).bold()
                              .frame(maxWidth: .infinity)
                              .frame(height: 110)
                              .padding()
                              .padding(.leading, -20)
                              .background(Color(item.color).opacity(0.25))
                              .clipShape(RoundedRectangle(cornerRadius: 20))
                              .font(.system(size: 14))
                              .foregroundColor(.black)
                              
                              /*Image(systemName: "chevron.down")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 13, height: 13)
                                  .foregroundColor(.gray)
                                  .shadow(radius: 1)*/
                          }
                        }
                        .padding()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Your favorites People")
                        .frame(width: proxy.size.width * 0.9, height: 30, alignment: .leading)
                        .padding()
                        .padding(.leading, -14)
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                        .frame(height: 5)
                }
                
            }
            .navigationTitle("1,234.00")
            .padding()
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("Some Action")
                }) {
                    Image(systemName: "bell")   .renderingMode(.template)
                        .foregroundColor(.gray)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    print("Some Other Action")
                }) {
                    Text("Hi Eri,")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
