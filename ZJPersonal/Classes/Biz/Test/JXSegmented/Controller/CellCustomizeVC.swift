//
//  CellCustomizeVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit

class CellCustomizeVC: BaseListVC {

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
