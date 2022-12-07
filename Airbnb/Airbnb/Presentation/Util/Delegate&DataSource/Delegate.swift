import Foundation

protocol SearchBarDelegate: AnyObject {
    func didBeginEditing(isStartEditing: Bool)
}

protocol ColseButtonDelegate: AnyObject {
    func didTabCloseButton(didTab: Bool)
}

protocol SearchViewSearchBarDelegate: AnyObject {
    func didGetTheData(didGet: Bool, data: [NSObject]?)
}
