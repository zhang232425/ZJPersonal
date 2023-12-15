//
//  IndicatorCustomizeVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/13.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import JXSegmentedView

/**
 * 初始化：https://blog.csdn.net/u010912383/article/details/52895409?spm=1001.2014.3001.5502
 */

class IndicatorCustomizeVC: BaseListVC {
    
    private let items: [String] = ["LineView固定长度",
                                   "LineView与Cell同宽",
                                   "LineView延长style",
                                   "LineView延长+偏移style",
                                   "LineView彩虹",
                                   "DotLine点线效果",
                                   "DoubleLine双线效果",
                                   "TriangleView三角形",
                                   "BackgroundView椭圆形",
                                   "BackgroundView椭圆形+阴影",
                                   "BackgroundView遮罩有背景",
                                   "BackgroundView遮罩无背景",
                                   "BackgroundView渐变色",
                                   "GradientLine渐变色",
                                   "ImageView底部",
                                   "ImageView背景",
                                   "混合使用",
                                   "GradientView渐变色",
                                   "指示器宽度跟随内容而不是cell宽度",
                                   "数据源过少"]

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

private extension IndicatorCustomizeVC {
    
    func bindDatas() {
        
        bindListDataSource()
        
        tableView.rx.modelSelected(String.self).subscribeNext(weak: self, IndicatorCustomizeVC.rowClick).disposed(by: disposeBag)
        
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

private extension IndicatorCustomizeVC {
    
    func rowClick(text: String) {
        
        let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        let vc = ContentBaseViewController()
        vc.navigationItem.title = text
        
        switch text {
            
        case "LineView固定长度":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
    
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = 20.auto
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "LineView与Cell同宽":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
    
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "LineView延长style":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
    
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            indicator.lineStyle = .lengthen
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "LineView延长+偏移style":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            indicator.lineStyle = .lengthenOffset
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "LineView彩虹":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            let indicator = JXSegmentedIndicatorRainbowLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            indicator.lineStyle = .lengthenOffset
            indicator.indicatorColors = [.red, .green, .blue, .orange, .purple, .cyan, .gray, .red, .yellow, .blue]
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "DotLine点线效果":
            
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            //配置指示器
            let indicator = JXSegmentedIndicatorDotLineView()
            
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "DoubleLine双线效果":
            
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            //配置指示器
            let indicator = JXSegmentedIndicatorDoubleLineView()
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "TriangleView三角形":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            let indicator = JXSegmentedIndicatorTriangleView()
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "BackgroundView椭圆形":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            let indicator = JXSegmentedIndicatorBackgroundView()
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "BackgroundView椭圆形+阴影":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            let indicator = JXSegmentedIndicatorBackgroundView()
            indicator.indicatorHeight = 30
            indicator.layer.shadowColor = UIColor.red.cgColor
            indicator.layer.shadowRadius = 3
            indicator.layer.shadowOffset = CGSize(width: 3, height: 4)
            indicator.layer.shadowOpacity = 0.6
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "BackgroundView遮罩有背景":
            
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = false
            dataSource.isTitleMaskEnabled = true
            dataSource.titles = titles
    
            //配置指示器
            let indicator = JXSegmentedIndicatorBackgroundView()
            indicator.isIndicatorConvertToItemFrameEnabled = true
            indicator.indicatorHeight = 30
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "BackgroundView遮罩无背景":
            
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = false
            dataSource.isTitleMaskEnabled = true
            dataSource.titles = titles
    
            //配置指示器
            let indicator = JXSegmentedIndicatorBackgroundView()
            indicator.alpha = 0
            indicator.isIndicatorConvertToItemFrameEnabled = true
            indicator.indicatorHeight = 30
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "BackgroundView渐变色":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            //配置指示器
            let indicator = JXSegmentedIndicatorBackgroundView()
            indicator.clipsToBounds = true
            indicator.indicatorHeight = 30
            let gradientView = JXSegmentedComponetGradientView()
            gradientView.gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            gradientView.gradientLayer.colors = [UIColor(red: 90/255, green: 215/255, blue: 202/255, alpha: 1).cgColor, UIColor(red: 122/255, green: 232/255, blue: 169/255, alpha: 1).cgColor]
            gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            indicator.addSubview(gradientView)
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "GradientLine渐变色":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
    
            //配置指示器
            let indicator = JXSegmentedIndicatorGradientLineView()
            indicator.colors = [UIColor.red, UIColor.green]
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "ImageView底部":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
        
            //配置指示器
            let indicator = JXSegmentedIndicatorImageView()
            indicator.indicatorWidth = 24
            indicator.indicatorHeight = 18
            indicator.image = .named("ic_coupon_privilege")
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "ImageView背景":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            //配置指示器
            let indicator = JXSegmentedIndicatorImageView()
            indicator.indicatorWidth = 50
            indicator.indicatorHeight = 50
            indicator.image = .named("ic_coupon_privilege")
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "混合使用":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            
            //配置指示器
            let lineIndicator = JXSegmentedIndicatorLineView()
            lineIndicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            lineIndicator.lineStyle = .normal

            let bgIndicator = JXSegmentedIndicatorBackgroundView()
            bgIndicator.indicatorHeight = 30
            
            
            vc.dataSource = dataSource
            vc.indicators = [lineIndicator, bgIndicator]
            
        case "GradientView渐变色":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            //配置指示器
            let indicator = JXSegmentedIndicatorGradientView()
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]

        case "指示器宽度跟随内容而不是cell宽度":
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = ["很长的第一名", "第二", "普通第三"]
            dataSource.itemWidth = view.bounds.size.width/3
            dataSource.itemSpacing = 0
            dataSource.isTitleZoomEnabled = true
            
            //配置指示器
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            indicator.isIndicatorWidthSameAsItemContent = true
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
        case "数据源过少":
            
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = ["龙蓉", "黄英", "张大春"]
            /**
             /// cell的宽度。为JXSegmentedViewAutomaticDimension时就以内容计算的宽度为准，否则以itemWidth的具体值为准。
             open var itemWidth: CGFloat = JXSegmentedViewAutomaticDimension
             /// 真实的item宽度 = itemWidth + itemWidthIncrement。
             open var itemWidthIncrement: CGFloat = 0
             /// item之前的间距
             open var itemSpacing: CGFloat = 20
             /// 当collectionView.contentSize.width小于JXSegmentedView的宽度时，是否将itemSpacing均分。
             open var isItemSpacingAverageEnabled: Bool = true
             */
            
            dataSource.itemSpacing = 30
            dataSource.isItemSpacingAverageEnabled = false
            
    
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
            
            vc.dataSource = dataSource
            vc.indicators = [indicator]
            
            
        default:
            break
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
