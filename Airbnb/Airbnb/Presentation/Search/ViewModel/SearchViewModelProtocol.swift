import Foundation

protocol SearchViewModelInput {}

protocol SearchViewModelOutput {
    var isError: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    var sectionTitle: Observable<[String]> { get }
    var items: Observable<[City]> { get }
}

protocol SearchViewModelProtocol: SearchViewModelInput, SearchViewModelOutput {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput { get }
}
