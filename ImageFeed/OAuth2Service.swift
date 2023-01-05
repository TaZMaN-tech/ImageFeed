//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Тадевос Курдоглян on 28.12.2022.
//

import Foundation

final class OAuth2Service {
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token")!  //1
        urlComponents.queryItems = [
           URLQueryItem(name: "client_id", value: AccessKey),                  //2
           URLQueryItem(name: "client_secret", value: SecretKey),
           URLQueryItem(name: "redirect_uri", value: RedirectURI),             //3
           URLQueryItem(name: "code", value: code),                 //4
           URLQueryItem(name: "grant_type", value: "authorization_code")                     //5
         ]
         let url = urlComponents.url!                                            //6
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверяем, пришла ли ошибка
            if let error = error {
                completion(.failure(error))
                return
            }

            // Проверяем, что пришёл успешный код ответа
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.codeError))
                return
            }

            // Возвращаем данные
            guard let data = data else { return }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            completion(.success(str))
        }

        task.resume()
    }
}
