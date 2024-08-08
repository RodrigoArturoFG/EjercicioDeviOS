//
//  ListViewModel.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 08/08/24.
//

import Combine
import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var data: [User]?
    @Published var error: WebServiceError?
    
    var apiDataSubscriber: Cancellable? = nil
    
    let apiClient: APIClient
    
    init(apiClient: APIClient){
        self.apiClient = apiClient
    }
    
    //Peticion se ejecuta en el hilo principal
    @MainActor
    func fetchUsers()  {
        apiDataSubscriber =  apiClient.getUsers().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.error = error
                
            }
        }, receiveValue: { response in
            print("\n Response Recieved-->", response)
            self.data = response.users
        })
    }
    
    func removeUser(withId id:Int){
        self.data?.removeAll(where: { user in user.id == id })
    }
    
    func updateFavoriteUser(withId id:Int){
        
        var dataToUpdate = self.data
        
        if var userToUpdate = dataToUpdate?.first(where: { user in user.id == id }) {
            userToUpdate.favorite = !(userToUpdate.favorite ?? false)
            
            dataToUpdate?.removeAll(where: { user in user.id == id })
            dataToUpdate?.append(userToUpdate)
            self.data = dataToUpdate?.sorted(by: { $0.id < $1.id })
        }
        
    }
    
//    func updateFavoriteUser(user: Binding<User>){
//        user.wrappedValue.favorite = !(user.wrappedValue.favorite ?? false)
//    }
    
    //    No pude replicar el async en el API Client
    //    private var cancellable: AnyCancellable?
    //
    //    func fetchData() async throws {
    //        guard let url = URL(string: "https://dummyjson.com/users") else {
    //            print("Invalid URL")
    //            return
    //        }
    //
    //        cancellable = URLSession.shared.dataTaskPublisher(for: url)
    //            .map(\.data)
    //            .decode(type: UserModel.self, decoder: JSONDecoder())
    //            .receive(on: DispatchQueue.main)
    //            .sink { completion in
    //                switch completion {
    //                case .failure(let error):
    //                    print("Error fetching data: \(error)")
    //                case .finished:
    //                    print("Data fetched successfully")
    //                }
    //            } receiveValue: { data in
    //                self.data = data
    //                print("Usuarios: \(data)")
    //            }
    //    }
    
}
