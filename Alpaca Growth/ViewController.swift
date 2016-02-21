//
//  ViewController.swift
//  Alpaca Growth
//
//  Created by 野中美穂 on 2016/02/21.
//  Copyright © 2016年 nonono. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 背景設定用
    var bg = UIImage(named: "bg_natural_sougen.jpg")

    // アルパカ設定用
    var alpaca = UIImageView()
    var timer = NSTimer()
    var borderRight:CGFloat = 0
    var borderLeft:CGFloat = 0
    var borderTop:CGFloat = 0
    var borderBottom:CGFloat = 0
    var speed:CGFloat = 0
    
    //　子アルパカ設定用
    var birthCount = 0
    var children:[UIImageView] = []
    var childSpeed:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 背景画像の配置
        let imageView = UIImageView(image:bg)
        imageView.frame = CGRectMake(0, 150, 700, 300)
        self.view.addSubview(imageView)
        
        //親子のスピード設定
        speed = -0.5
        childSpeed = -0.3
        
        // アルパカの配置
        borderRight = self.view.frame.size.width
        borderBottom = self.view.frame.size.height
        
        alpaca.image = UIImage(named:"run_1.png")
        alpaca.frame = CGRectMake(0,0,50,50)
        alpaca.center = self.view.center
        self.view.addSubview(alpaca)
        
        // アルパカのアニメーション
        
        alpaca.animationImages = [
         UIImage(named: "run_1.png")!,
         UIImage(named: "run_2.png")!,
         UIImage(named: "run_3.png")!,
        ]
        
        alpaca.animationDuration = 0.25
        alpaca.animationRepeatCount = -1
        self.view.addSubview(alpaca)
        alpaca.startAnimating()
        
        borderLeft = alpaca.frame.size.width/2
        borderRight = self.view.frame.size.width - alpaca.frame.size.width/2
        borderTop = alpaca.frame.size.height/2
        borderBottom = self.view.frame.size.height - alpaca.frame.size.height/2
        
        //　アルパカの進む速さ
        timer = NSTimer.scheduledTimerWithTimeInterval(
            0.02,
            target: self,
            selector:  "doFrame",
            userInfo: nil,
            repeats: true
        )
    }

    func doFrame(){
        // アルパカの動作方向
        alpaca.center = CGPointMake(alpaca.center.x+speed, alpaca.center.y)
        if alpaca.center.x < borderLeft {
            speed = 0.5
            alpaca.transform = CGAffineTransformMakeScale(-1 ,1)
        }
        if alpaca.center.x > borderRight{
            speed = -0.5
            alpaca.transform = CGAffineTransformMakeScale(1 ,1)
        }
        
        // 子アルパカの派生用
        if birthCount >= 150 {
            let child = UIImageView()
            child.image = alpaca.image
            child.frame = CGRectMake(0,0,alpaca.frame.width/2,alpaca.frame.height/2)
            child.center = CGPointMake(alpaca.center.x, alpaca.center.y + child.frame.size.height/2)
            child.animationImages = alpaca.animationImages
            child.animationDuration = alpaca.animationDuration
            self.view.addSubview(child)
            children.append(child)
            child.startAnimating()
            birthCount = 0
        }else{
            birthCount++
        }
        for child in children{
            if child.center.x < alpaca.center.x{
                child.center = CGPointMake(child.center.x-childSpeed, child.center.y)
                child.transform = CGAffineTransformMakeScale(-1, 1)
            }else{
                child.center = CGPointMake(child.center.x+childSpeed, child.center.y)
                child.transform = CGAffineTransformMakeScale(1, 1)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

