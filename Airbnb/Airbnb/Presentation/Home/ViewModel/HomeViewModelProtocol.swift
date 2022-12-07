import Foundation

protocol HomeViewModelInput {}

protocol HomeViewModelOutput {
    var isError: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    var sectionTitle: Observable<[String]> { get }
    var items: Observable<ItemType> { get }
}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}
