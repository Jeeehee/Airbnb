import Foundation

let url = "https://openapi.gg.go.kr/StayingGeneralHotel"

final class Repository {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getAddress(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)

        session.dataTask(with: request) { data, response, error in
            if let error = self.errorCheck(data: data, response: response, error: error) {
                completion(.failure(.error(error)))
                return
            }
            
            guard let data = data else { return }
            if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? { print(result) }
            DispatchQueue.main.async {
                do {
                    guard let decodeResponse = try? JSONDecoder().decode(Data.self, from: data) else { return }
                    if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? { print(result) }
                    completion(.success(decodeResponse))
                
                } catch {
                    completion(.failure(.decodeFailedError))
                }
            }
        }.resume()

    }
    
    func errorCheck(data: Data?, response: URLResponse?, error: Error?) -> NetworkError? {
        guard error == nil else { return .requestFailedError }
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode else { return .responseError }
        
        guard data != nil else { return .responseDataEmptyError }
        
        return nil
    }
}
