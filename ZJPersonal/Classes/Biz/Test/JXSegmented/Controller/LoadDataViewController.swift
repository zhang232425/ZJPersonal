//
//  LoadDataViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit
import JXSegmentedView

class LoadDataViewController: BaseVC {
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.isTitleColorGradientEnabled = true
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.lineStyle = .lengthen
    }
    
    private lazy var listContainerView = JXSegmentedListContainerView(dataSource: self)
    
    private lazy var segmentedView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.indicators = [indicator]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

private extension LoadDataViewController {
    
    func setupViews() {
        
        navigationItem.title = "更新数据"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "刷新数据", style: UIBarButtonItem.Style.plain, target: self, action: #selector(reloadData))
        
        segmentedView.add(to: view).snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        listContainerView.add(to: view).snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(segmentedView.snp.bottom)
        }
        
    }
    
    @objc func reloadData() {
        
        dataSource.titles = self.getRandomTitles()
        segmentedView.defaultSelectedIndex = 1
        segmentedView.reloadData()
        
    }
    
    func getRandomTitles() -> [String] {
        
        let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        //随机title数量，4~n
        let randomCount = Int(arc4random()%7 + 4)
        var tempTitles = titles
        var resultTitles = [String]()
        for _ in 0..<randomCount {
            let randomIndex = Int(arc4random()%UInt32(tempTitles.count))
            resultTitles.append(tempTitles[randomIndex])
            tempTitles.remove(at: randomIndex)
        }
        return resultTitles
    }
    
}

extension LoadDataViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return dataSource.dataSource.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        return ListBaseViewController()
        
    }
     
}
