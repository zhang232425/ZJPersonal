//
//  ListBaseViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit
import JXSegmentedView

class ListBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
        
    }
    
}

extension ListBaseViewController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
}
