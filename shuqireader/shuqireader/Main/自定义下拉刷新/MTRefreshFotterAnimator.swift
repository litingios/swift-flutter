//
//  MTRefreshFotterAnimator.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/30.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESPullToRefresh

public class MTRefreshFotterAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public let loadingMoreDescription: String = "努力加载中..."
    public let noMoreDataDescription: String  = "没有书籍了"
    public let loadingDescription: String     = "努力加载中..."
    
    private var timer: Timer?
    private var timerProgress: Double = 0.0

    public var view: UIView {
        return self
    }
    public var insets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    public var trigger: CGFloat = 48.0
    public var executeIncremental: CGFloat = 48.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let topLine: UIView = {
        let topLine = UIView.init(frame: CGRect.zero)
        topLine.backgroundColor = UIColor.clear
        return topLine
    }()
    private let bottomLine: UIView = {
        let bottomLine = UIView.init(frame: CGRect.zero)
        bottomLine.backgroundColor = UIColor.clear
        return bottomLine
    }()
    private let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(r: 153, g: 172, b: 202)
        label.textAlignment = .center
        label.backgroundColor = BackViewColor
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "loading")
        imageView.sizeToFit()
        imageView.center = CGPoint.init(x:UIScreen.main.bounds.size.width / 2.0 - 60, y: 48.0 / 2.0)
        imageView.width = 18
        imageView.height = 18
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        titleLabel.text = loadingMoreDescription
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(topLine)
        addSubview(bottomLine)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        self.startAnimating()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.imageView.center = CGPoint.init(x: UIScreen.main.bounds.size.width / 2.0-60, y: 24.0)
            }, completion: { (finished) in })
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.imageView.transform = CGAffineTransform.identity
            self.imageView.center = CGPoint.init(x: UIScreen.main.bounds.size.width / 2.0-60, y: 24.0)
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.imageView.transform = CGAffineTransform.identity
                self.imageView.center = CGPoint.init(x: UIScreen.main.bounds.size.width / 2.0-60, y: 24.0)
            }, completion: { (finished) in
                self.stopAnimating()
            })
        })
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = min(1.0, max(0.0, progress))
        let y = (-self.trigger * progress) + 16.0 - (size.height + 16.0) * (1 - p)
        let center = CGPoint.init(x: UIScreen.main.bounds.size.width / 2.0-60, y: 24.0)
        self.imageView.center = center
        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * progress)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {return}
        self.state = state
        switch state {
        case .refreshing :
            titleLabel.text = loadingDescription
            break
        case .autoRefreshing :
            titleLabel.text = loadingDescription
            break
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
            imageView.isHidden = true
            break
        default:
            titleLabel.text = loadingMoreDescription
            break
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        titleLabel.frame = self.bounds
        imageView.center = CGPoint.init(x:UIScreen.main.bounds.size.width / 2.0 - 60, y: h / 2.0)
        topLine.frame = CGRect.init(x: 0.0, y: 0.0, width: w, height: 0.5)
        bottomLine.frame = CGRect.init(x: 0.0, y: h - 1.0, width: w, height: 1.0)
    }
    
    @objc func timerAction() {
        timerProgress += 0.1
        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * CGFloat(timerProgress))
    }
    
    func startAnimating() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MTRefreshFotterAnimator.timerAction), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    func stopAnimating() {
        if timer != nil {
            timerProgress = 0.0
            timer?.invalidate()
            timer = nil
        }
    }
    
}
