//
//  MTRefreshHeaderAnimator.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/24.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESPullToRefresh

public class MTRefreshHeaderAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    
    public var insets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    public var view: UIView { return self }
    public var duration: TimeInterval = 0.3
    public var trigger: CGFloat = 24.0
    public var executeIncremental: CGFloat = 24.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "loadingIcon1@3x")
        return imageView
    }()
    
    private let titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = UIColor.red
        titleLable.text = "分享更快乐"
        titleLable.textColor = UIColor.init(r: 153, g: 172, b: 202)
        titleLable.font = UIFont.systemFont(ofSize: 12)
        return titleLable
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLable)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        imageView.center = self.center
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.imageView.frame = CGRect.init(x: (self.bounds.size.width - 20.0) / 2.0 - 30.0,
                                               y: self.bounds.size.height - 50.0,
                                               width: 20.0,
                                               height: 20.0)
            self.titleLable.frame = CGRect.init(x:(self.bounds.size.width - 20.0) / 2.0-5.0 , y: self.bounds.size.height - 70.0, width: 100, height: 20)

            }, completion: { (finished) in
                var images = [UIImage]()
                for idx in 1 ... 50 {
                    if let aImage = UIImage(named: "loadingIcon\(idx)@3x") {
                        images.append(aImage)
                    }
                }
                self.imageView.animationDuration = 1
                self.imageView.animationRepeatCount = 0
                self.imageView.animationImages = images
                self.imageView.startAnimating()
        })
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        imageView.stopAnimating()
        imageView.image = UIImage.init(named: "loadingIcon1@3x")
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.refresh(view: view, progressDidChange: 0.0)
        }, completion: { (finished) in
            self.titleLable.frame = CGRect.init(x:(self.bounds.size.width - 20.0) / 2.0-5.0 , y: self.bounds.size.height - 100, width: 100, height: 20)

        })
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = max(0.0, min(1.0, progress))
        imageView.frame = CGRect.init(x: (self.bounds.size.width - 20.0) / 2.0 - 30.0,
                                      y: self.bounds.size.height - 50.0 * p,
                                      width: 20.0,
                                      height: 20.0 * p)
        self.titleLable.frame = CGRect.init(x:(self.bounds.size.width - 20.0) / 2.0-5.0 , y: self.bounds.size.height - 50.0 * p, width: 100, height: 20)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
        case .pullToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 50 {
                if let aImage = UIImage(named: "loadingIcon\((50 - idx + 1))@3x") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 1
            imageView.animationRepeatCount = 0
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "loadingIcon1@3x")
            imageView.startAnimating()
            break
        case .releaseToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 50 {
                if let aImage = UIImage(named: "loadingIcon\(idx)@3x") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 1
            imageView.animationRepeatCount = 0
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "loadingIcon50@3x")
            imageView.startAnimating()
            break
        default:
            break
        }
    }
    
}
