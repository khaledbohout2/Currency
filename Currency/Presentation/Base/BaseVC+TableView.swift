import UIKit

class TableView: BaseView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func setupView() {
        addSubview(tableView)
        tableView.fillSuperviewSafeArea()
    }

}
