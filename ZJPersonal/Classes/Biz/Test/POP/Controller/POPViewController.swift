//
//  POPViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/19.
//

/** 面向协议编程：
 https://juejin.cn/post/6932789715749830669?from=search-suggest
 */

/** UIView 与CALayer
 https://juejin.cn/post/7285290243297689652
 */

import UIKit

fileprivate class LogoImageView: UIImageView, RoundCornerable, Shakeable {
    
    init(radius: CGFloat = 5) {
        super.init(frame: .zero)
        roundCorner(radius: radius)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shakeClick)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func shakeClick() {
        startShake()
    }
    
}

class POPViewController: BaseVC {
    
    private lazy var testBtn = UIButton(type: .system).then {
        $0.setTitle("Test", for: .normal)
        $0.addTarget(self, action: #selector(testClick), for: .touchUpInside)
    }
    
    private lazy var iconImgView = LogoImageView(radius: 5).then {
        $0.backgroundColor = .orange
    }
        
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViews()
    }

}

private extension POPViewController {
    
    func config() {
        
        
        
    }
    
    func setupViews() {
        
        iconImgView.add(to: view).snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100.auto)
            $0.size.equalTo(50.auto)
        }
        
        testBtn.add(to: view).snp.makeConstraints {
            $0.top.equalTo(iconImgView.snp.bottom).offset(50.auto)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    @objc func testClick() {
        
//        var dog = Dog(name: "旺财", master: "小明")
//        dog.master = "小张"
        
        /*
        let person = PersonStruct()
        let num = (person as ProtocolOne).method()
        let string = (person as ProtocolTwo).method()
        
        if person is ProtocolOne {
            print("遵守了ProtocolOne")
        }
        
        if person is ProtocolTwo {
            print("遵守了ProtocolTwo")
        }
         */
        
//        let xiaoming = Student(name: "小明", firstJudge: 80, secondJudge: 90, thirdJudge: 100)
//        print(xiaoming.averageScore().customDescription)
        
        let string = "zhang9283,dwdh23dkj6"
        
        print("数字个数 = \(string.sh.numberCount())")
        
    }
    
    
    
}

private extension POPViewController {
    
    /**
     协议作为参数：表明遵守了该协议的实例可作为参数
     */
    func update(params: FourProtocol) {
        
    }
    
}

// ----------------------- 定义其他的类型 --------------------

/**
 协议的定义
 */

fileprivate protocol Food { }

/**
 协议属性：协议中定义属性表示遵循了该协议的类型具备了某种属性
 */

fileprivate protocol Pet {
    
    /// 定义属性（可读 / 可读可写）
    var name: String { get set}
    var master: String { get }
    static var species: String { get }
    
    /// 定义方法 mutating(异变方法)
    static func sleep()
    mutating func changeName()
    
    /// 协议中的初始化器
    init(master: String)

}

fileprivate struct Dog: Pet {


    var name: String
    var master: String
    static var species: String = "哺乳动物"
    var color: UIColor? = nil
    
    init(master: String) {
        self.master = master
        self.name = ""
    }
    
    static func sleep() {
        print("要休息了")
    }
    
    mutating func changeName() {
        name = "小王"
    }
    
}

fileprivate struct Student: Score {
    
    var name: String
    
    var firstJudge: CGFloat
    
    var secondJudge: CGFloat
    
    var thirdJudge: CGFloat
    
}

// 多个协议方法名冲突

fileprivate protocol ProtocolOne {
    func method() -> Int
}

fileprivate protocol ProtocolTwo {
    func method() -> String
}

fileprivate struct PersonStruct: ProtocolOne, ProtocolTwo {
    
    func method() -> Int {
        return 1
    }
    
    func method() -> String {
        return "hello world"
    }
    
}

/// 协议方法的可选实现
/**
 方法一：通过optional实现
 方法二：通过extension做默认实现
 */

/*
 fileprivate @objc protocol OptionalProtocol {
 @objc optional func optionalMethod()
 func requiredMethod()
 }
 */

fileprivate protocol OptionalProtocol {
    func optionalMethod()
    func requiredMethod()
}
 
extension OptionalProtocol {
    
    func requiredMethod() {
        
    }
    
}

/// 协议的继承、聚合
fileprivate protocol OneProtocol { }
fileprivate protocol TwoProtocol { }
fileprivate protocol ThreeProtocol: OneProtocol, TwoProtocol { }
fileprivate typealias FourProtocol = OneProtocol & TwoProtocol

/// 协议检查

/// 协议的指定
fileprivate protocol protocolClass: class {}
fileprivate class Test: protocolClass {}

/// 协议的关联类型
fileprivate protocol LengthMeasurable {
    associatedtype LengthType
    var length: LengthType { get }
    func printMethod()
}

fileprivate struct Pencil: LengthMeasurable {
    typealias LengthType = CGFloat
    var length: LengthType
    func printMethod() {
        print("铅笔的长度为 \(length) 厘米")
    }
}

fileprivate struct Bridge: LengthMeasurable {
    typealias LengthType = Int
    var length: Int
    func printMethod() {
        print("桥梁的长度为 \(length) 米")
    }
}

/// 协议的扩展

/**
 protocol Score {
     var name: String { get set }
     var firstJudge: CGFloat { get set }
     var secondJudge: CGFloat { get set }
     var thirdJudge: CGFloat { get set }
     
     func averageScore() -> String
 }

 struct Xiaoming: Score {
     var firstJudge: CGFloat
     var secondJudge: CGFloat
     var thirdJudge: CGFloat
     
     func averageScore() -> String {
         let average = (firstJudge + secondJudge + thirdJudge) / 3
         return "\(name)的得分为\(average)"
     }
 }
 let xiaoming = Xiaoming(name: "小明", firstJudge: 80, secondJudge: 90, thirdJudge: 100)
 let average = xiaoming.averageScore()
 */

fileprivate protocol Score {
    var name: String { get set }
    var firstJudge: CGFloat { get set }
    var secondJudge: CGFloat { get set }
    var thirdJudge: CGFloat { get set }
    func averageScore() -> String
    func maxScore() -> CGFloat
}

fileprivate extension Score {
    
    func averageScore() -> String {
        let average = (firstJudge + secondJudge + thirdJudge) / 3
        return "\(name)的得分为\(average)"
    }
    
    func maxScore() -> CGFloat {
        return max(firstJudge, secondJudge, thirdJudge)
    }
    
}

/**
 ”Can do“协议： （表示能力），描述的事情是类型可以做或已经做过的， 以able结尾
 "Is a"协议：（表示身份）描述类型是什么样的，与"Can do"的协议相比，这些更基于身份，表示身份的类型。 以 -type 结尾
 "Can be"协议：（表示转换）这个类型可以被转换到或者转换成别的东西。以 -Convertible 结尾
 */

/// 对系统协议进行扩展
extension CustomStringConvertible {
    var customDescription: String {
        return "新希望学校春季运动会运动会得分为：：" + description
    }
}

/***
 * 面向协议编程
 */

/// 声明一个圆角能力的协议
protocol RoundCornerable {
    func roundCorner(radius: CGFloat)
}

/// 通过扩展给这个协议方法添加默认实现，必须满足遵守这个协议的类是继承UIView的
extension RoundCornerable where Self: UIView {
    func roundCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

/// 声明抖动动画协议
protocol Shakeable {
    func startShake()
}

// CAAnimation CAKeyframeAnimation
extension Shakeable where Self: LogoImageView {
    
    func startShake() {
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform"
        animation.duration = 0.25
        
        let origin = CATransform3DIdentity
        let minimum = CATransform3DMakeScale(0.8, 0.8, 1)
        
        let originValue = NSValue(caTransform3D: origin)
        let minimumValue = NSValue(caTransform3D: minimum)
        
        animation.values = [originValue, minimumValue, origin, minimumValue, origin]
        layer.add(animation, forKey: "bounce")
        layer.transform = origin
        
    }
    
}


