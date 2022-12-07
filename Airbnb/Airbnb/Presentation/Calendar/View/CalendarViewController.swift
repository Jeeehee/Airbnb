import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    private let titleView = CloseButtonWithTitleView(title: "숙소 찾기")
    private let underLine = UIView()
    private let calendarView = FSCalendar(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        underLine.backgroundColor = .line
        titleView.delegate = self
    }
    
    private func layout() {
        view.addSubview(titleView)
        view.addSubview(underLine)
        view.addSubview(calendarView)
        
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }

}

// MARK: - Delegate
extension CalendarViewController: ColseButtonDelegate {
    func didTabCloseButton(didTab: Bool) {
        if didTab {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
