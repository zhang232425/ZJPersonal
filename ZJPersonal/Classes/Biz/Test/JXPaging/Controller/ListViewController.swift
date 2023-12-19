//
//  ListViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit
import JXPagingView

class ListViewController: UIViewController {
    
    private var listViewDidScrollCallBack: ((UIScrollView) -> ())?
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.registerCell(UITableViewCell.self)
        $0.dataSource = self
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

private extension ListViewController {
    
    func setupViews() {
        
        tableView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 57
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
        
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallBack?(scrollView)
    }
    
}

extension ListViewController: JXPagingViewListViewDelegate {
    
    func listView() -> UIView {
        return view
    }
    
    func listScrollView() -> UIScrollView {
        return tableView
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        listViewDidScrollCallBack = callback
    }

}
