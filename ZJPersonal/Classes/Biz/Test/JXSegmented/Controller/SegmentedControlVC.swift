//
//  SegmentedControlVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit
import JXSegmentedView

class SegmentedControlVC: ContentBaseViewController {
    
    var totalItemWidth: CGFloat = 0
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confing()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentedView.frame = CGRect(x: 30.auto, y: 10.auto, width: totalItemWidth, height: 30.auto)
    }

}

private extension SegmentedControlVC {
    
    func confing() {
        
        totalItemWidth = UIScreen.screenWidth - 30.auto * 2
        
        let titles = ["吃饭🍚", "睡觉😴", "游泳🏊", "跳舞💃"]
        let titleDataSource = JXSegmentedTitleDataSource()
        titleDataSource.itemWidth = totalItemWidth/CGFloat(titles.count)
        titleDataSource.titles = titles
        titleDataSource.isTitleMaskEnabled = true
        titleDataSource.titleNormalColor = UIColor.red
        titleDataSource.titleSelectedColor = UIColor.white
        titleDataSource.itemSpacing = 0
        dataSource = titleDataSource

        segmentedView.dataSource = titleDataSource
        segmentedView.layer.masksToBounds = true
        segmentedView.layer.cornerRadius = 15.auto
        segmentedView.layer.borderColor = UIColor.red.cgColor
        segmentedView.layer.borderWidth = 1.auto / UIScreen.main.scale

        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 30.auto
        indicator.indicatorWidthIncrement = 0
        indicator.indicatorColor = UIColor.red
        segmentedView.indicators = [indicator]
        
    }
    
    func setupViews() {
        
        
        
    }
    
}
