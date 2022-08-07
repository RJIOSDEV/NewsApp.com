//
//  ApiService.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//



import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Get popular movies data
    func getLatestNewsData(completion: @escaping (Result<NewsData, Error>) -> Void) {
let latestNewsUrl = "https://newsapi.org/v2/top-headlines?country=US&apiKey=a34f17e6e15b4990b992da88c477a2d6"
        
        guard let url = URL(string: latestNewsUrl) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Hndle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsData.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    //MARK: - Get image data
    func getImageDataFrom(url:URL, completion: @escaping ((Data) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                // Handle Empty data
                print("Empty Data")
                return
            }

            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}



