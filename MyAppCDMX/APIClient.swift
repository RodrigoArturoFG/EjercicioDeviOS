//
//  APIClient.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 08/08/24.
//

import Foundation
import Combine

enum WebServiceError: Error, LocalizedError {
    case unknown, customError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Error desconocido"
        case .customError(let reason):
            return reason
        }
    }
}

final class APIClient {
    
    private var  cancellable = Set<AnyCancellable>()
    
    func getUsers() -> AnyPublisher<UserModel, WebServiceError> {
        // 1: Obtener URL del servicio
        let url = URL(string: "https://dummyjson.com/users")!
        let urlRequest = URLRequest(url: url)
        
        // 2: Agregar Publisher
        var dataPublisher: AnyPublisher<UserModel, WebServiceError>
        
        // 3: DataTaskPublisher para recuperar valores de stream
        dataPublisher = URLSession.DataTaskPublisher(request: urlRequest, session: .shared)
        
        // 4: tryMap para crear un cierre y asignar elementos con el Publisher
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    //con un switch case hacer manejo de errores de la respuesta con el httpResponse.statusCode, para este ejercicio solo devolveremos un error desconocido para cualquier error
                    throw WebServiceError.unknown
                }
                return data
            }
        // 5: Convertir respuesta a Codable mode
            .decode(type: UserModel.self, decoder: JSONDecoder())
        // 6: Después de recibir datos, saltar al hilo principal para que sea un thread seguro para las actividades de la IU.
            .receive(on: RunLoop.main)
        // 7: mapError se utiliza para asignar errores de tipo personalizado
            .mapError { error in
                if let error = error as? WebServiceError {
                    return error
                } else {
                    return WebServiceError.customError(reason: error.localizedDescription)
                }
            }
        // 8: eraseToAnyPublisher se utiliza para exponer una instancia de AnyPublisher al subscriber de nivel inferior
            .eraseToAnyPublisher()
        return dataPublisher
    }
}
