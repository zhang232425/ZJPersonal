//
//  CellCustomizeVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import JXSegmentedView

class CellCustomizeVC: BaseListVC {
    
    private let items: [String] = ["颜色渐变",
                                   "文字渐变",
                                   "大小缩放",
                                   "大小缩放+字体粗细",
                                   "大小缩放+点击动画",
                                   "大小缩放+Cell宽度缩放",
                                   "数字",
                                   "红点",
                                   "文字和图片",
                                   "文字或者图片",
                                   "多行文字(自己添加换行符)",
                                   "多行文字(固定宽度自动换行)",
                                   "多行富文本",
                                   "多种cell"]
    
    private let datas = BehaviorRelay(value: [SectionModel<String, String>]())

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindDatas()
    }
    
}

private extension CellCustomizeVC {
    
    func bindDatas() {
        
        bindListDataSource()
        
        tableView.rx.modelSelected(String.self).subscribeNext(weak: self, CellCustomizeVC.rowClick).disposed(by: disposeBag)
        
        datas.accept([SectionModel(model: "", items: items)])
        
    }
    
    func bindListDataSource() {
        
        let dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, String>> = .init(configureCell: { (ds, tableView, indexPath, item) in
            
            let cell: CustomizeCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
            cell.update(with: item)
            return cell
            
        })
        
        datas.observe(on: MainScheduler.instance).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
}

private extension CellCustomizeVC {
    
    func rowClick(text: String) {
        
        let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        let numbers = [1, 22, 333, 44444, 0, 66, 777, 0, 99999, 10]
        let dotStates = [false, true, true, true, false, false, true, true, false, true]
        let vc = ContentBaseViewController()
        vc.navigationItem.title = text
        
        switch text {
            
        case "颜色渐变":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.titles = titles
            
            vc.dataSource = dataSource
            
        case "文字渐变":
            //配置数据源
            let dataSource = JXSegmentedTitleGradientDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.titles = titles
            
            vc.dataSource = dataSource
            
        case "大小缩放":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.isTitleZoomEnabled = true
            dataSource.titleSelectedZoomScale = 1.3
            dataSource.titles = titles
            
            vc.dataSource = dataSource
            
        case "大小缩放+字体粗细":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.isTitleZoomEnabled = true
            dataSource.titleSelectedZoomScale = 1.3
            dataSource.isTitleStrokeWidthEnabled = true
            dataSource.titles = titles
            
            vc.dataSource = dataSource
            
        case "大小缩放+点击动画":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.isTitleZoomEnabled = true
            dataSource.titleSelectedZoomScale = 1.3
            dataSource.isTitleStrokeWidthEnabled = true
            dataSource.isSelectedAnimable = true
            dataSource.titles = titles
            
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            
            vc.indicators = [indicator]
            vc.dataSource = dataSource
            
        case "大小缩放+Cell宽度缩放":
            
            //高仿汽车之家
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.isTitleZoomEnabled = true
            dataSource.titleSelectedZoomScale = 1.3
            dataSource.isTitleStrokeWidthEnabled = true
            dataSource.isSelectedAnimable = true
            dataSource.isItemWidthZoomEnabled = true
            dataSource.titles = titles

            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            
            vc.indicators = [indicator]
            vc.dataSource = dataSource
            
        case "数字":
            //配置数据源
            let dataSource = JXSegmentedNumberDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            dataSource.numbers = numbers
//            dataSource.numberHeight = 20
//            dataSource.numberFont = .systemFont(ofSize: 15)
            dataSource.numberStringFormatterClosure = {(number) -> String in
                if number > 999 {
                    return "999+"
                }
                return "\(number)"
            }
            vc.dataSource = dataSource
            
        case "红点":
            
            //配置数据源
            let dataSource = JXSegmentedDotDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            dataSource.dotStates = dotStates
            
            vc.dataSource = dataSource
            
        case "文字和图片":
            //配置数据源
            let dataSource = JXSegmentedTitleImageDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            dataSource.titleImageType = .rightImage
            dataSource.isImageZoomEnabled = true
            dataSource.normalImageInfos = ["ic_coupon_privilege", "ic_coupon_interest", "ic_coupon_experience", "ic_coupon_cash", "icon_coupon_help", "ic_coupon_privilege", "ic_coupon_interest", "ic_coupon_experience", "ic_coupon_privilege", "ic_coupon_cash"]
            
            dataSource.loadImageClosure = {(imageView, normalImageInfo) in
                imageView.image = .named(normalImageInfo)
            }
            
            vc.dataSource = dataSource
            
        case "文字或者图片":
            //配置数据源
            let dataSource = JXSegmentedTitleOrImageDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.isTitleZoomEnabled = true
            dataSource.titleSelectedZoomScale = 1.3
            dataSource.isTitleStrokeWidthEnabled = true
            dataSource.isItemTransitionEnabled = false
            dataSource.isSelectedAnimable = true
            dataSource.titles = titles
            dataSource.selectedImageInfos = ["ic_coupon_privilege", nil, "ic_coupon_interest", nil, "ic_coupon_experience", "ic_coupon_cash", "ic_coupon_cash", nil, nil, "ic_coupon_privilege"]
            dataSource.loadImageClosure = {(imageView, normalImageInfo) in
                imageView.image = .named(normalImageInfo)
            }
            
            vc.dataSource = dataSource
            
        case "多行文字(自己添加换行符)":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.titleNumberOfLines = 2
            dataSource.titles = ["猴哥\nmonkey", "青蛙王子\nfrog", "旺财\ndot", "粉红猪\npig", "喜羊羊\nsheep", "黄焖鸡\nchicken", "小马哥\nhorse", "牛魔王\ncow", "大象先生\nelepant", "神龙\ndragon"]
            vc.dataSource = dataSource
            
        case "多行文字(固定宽度自动换行)":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titleSelectedColor = UIColor.red
            dataSource.titleNumberOfLines = 2
            dataSource.itemWidth = 60
            dataSource.titles = ["猴哥 monkey", "青蛙王子 frog", "旺财 dot", "粉红猪 pig", "喜羊羊 sheep", "黄焖鸡 chicken", "小马哥 horse", "牛魔王 cow", "大象先生 elepant", "神龙 dragon"]
            
            vc.dataSource = dataSource
            
        case "多行富文本":
            //配置数据源
            let dataSource = JXSegmentedTitleAttributeDataSource()
            func formatNormal(attriText: NSMutableAttributedString) {
                attriText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], range: NSRange(location: 0, length: 2))
                attriText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)], range: NSRange(location: 2, length: attriText.string.count - 2))
            }
            func formatSelected(attriText: NSMutableAttributedString) {
                attriText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], range: NSRange(location: 0, length: 2))
                attriText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], range: NSRange(location: 2, length: attriText.string.count - 2))
            }
            let mondayAttriText = NSMutableAttributedString(string: "周一\n1月7号")
            formatNormal(attriText: mondayAttriText)
            let tuesdayAttriText = NSMutableAttributedString(string: "周二\n1月8号")
            formatNormal(attriText: tuesdayAttriText)
            let wednesdayAttriText = NSMutableAttributedString(string: "周三\n1月9号")
            formatNormal(attriText: wednesdayAttriText)
            dataSource.attributedTitles = [mondayAttriText.copy(), tuesdayAttriText.copy(), wednesdayAttriText.copy()] as! [NSAttributedString]

            formatSelected(attriText: mondayAttriText)
            formatSelected(attriText: tuesdayAttriText)
            formatSelected(attriText: wednesdayAttriText)
            dataSource.selectedAttributedTitles = [mondayAttriText.copy(), tuesdayAttriText.copy(), wednesdayAttriText.copy()] as? [NSAttributedString]
            vc.dataSource = dataSource
            //配置指示器
            let indicator = JXSegmentedIndicatorBackgroundView()
            indicator.indicatorHeight = 40
            indicator.indicatorCornerRadius = 5
            vc.indicators = [indicator]
            
        case "多种cell":
            let dataSource = JXSegmentedMixcellDataSource()
            vc.dataSource = dataSource
        
        default:
            break
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
