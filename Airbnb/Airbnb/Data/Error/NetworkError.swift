import Foundation

enum NetworkError: Error {
    case responseError
    case responseDataEmptyError
    case requestFailedError
    case decodeFailedError
    case invalidAuthCode
    case invalidURL
    case encodingError
    case error(Error)
}
