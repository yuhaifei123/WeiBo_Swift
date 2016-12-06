//
//  QrCode_ViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/11/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit
import AVFoundation//二维码库

class QrCode_ViewController: UIViewController,UITabBarDelegate{
    
    
    /// 二维码 view
    @IBOutlet weak var view_QRCode: UIView!
    /// 视图 view的高度
    @IBOutlet weak var layoutView_Height: NSLayoutConstraint!
    /// 冲击波 top
    @IBOutlet weak var layyoutCJB_Top: NSLayoutConstraint!
    /// 选择，条形码与二维码
    @IBOutlet weak var tabBar: UITabBar!
    /// 关闭 Bar
    @IBOutlet weak var guanBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.tabBar.delegate = self;
        
        //冲击波动画
        self.startAnimated();
        
        self.startQR();
    }
    
    /// 加载完成以后，触发事件
    ///
    /// - Parameter animated: <#animated description#>
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        tabBar.selectedItem = tabBar.items![0];
    }

    
    /// 启动扫描二维码
    private func startQR(){
        
        //判断回话里面能不能添加，输入视图
        if self.session.canAddInput(deviceInput) == false {
            return;
        }
        //同上
        if self.session.canAddOutput(output) == false{
            
            return;
        }
        //添加
        self.session.addInput(deviceInput);
        self.session.addOutput(output);
        //添加扫描类型(可以扫描所有类型)
        self.output.metadataObjectTypes = output.availableMetadataObjectTypes;
        //设置输出对象，代理 (在主线程里面)
        self.output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main);
        //添加预览视图
        self.view.layer.insertSublayer(self.previewlayer, at: 0);
        //启动
        self.session.startRunning();
    }
    
    /// 点击关闭按钮，触发事件
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func guanBarClick(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil);
    }
    
    
    /// 启动动画
    private func startAnimated (){
    
        //冲击波的头部与 view 的高度相反
        self.layyoutCJB_Top.constant = -self.layoutView_Height.constant;
        //牢记，就是"自动布局"里面改变了，就要刷新一下 view
        self.view_QRCode.layoutIfNeeded();
        //动画方法
        UIView.animate(withDuration: 2.0, animations: {() -> Void in
            //设置约束
            self.layyoutCJB_Top.constant = 0;//self.layoutView_Height.constant * 0.1;
            //设置动画次数
            UIView.setAnimationRepeatCount(MAXFLOAT);
            //必须更新一下
            self.view_QRCode.layoutIfNeeded();
        });
    }
    
    
    /// tabBar delegate 选择以后，触发事件
    ///
    /// - Parameters:
    ///   - tabBar: <#tabBar description#>
    ///   - item: <#item description#>
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 0 {
        
            self.layoutView_Height.constant = 300;
        }
        else{
    
            self.layoutView_Height.constant = 150;
        }
        self.view_QRCode.layoutIfNeeded();
        //先取消前面的动画
        self.view_QRCode.layer.removeAllAnimations();
        //在启动新的动画
        self.startAnimated();
    }
    
/******************************  二维码 懒加载 **************************/
    private lazy var session : AVCaptureSession = AVCaptureSession();//回话
    
    /// 拿到输入设备 因为会返回nil，所以"?"
    private lazy var deviceInput : AVCaptureInput? = {
    
        //获取摄像头
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo);
        
        do{
            let input = try AVCaptureDeviceInput(device: device);
            return input;
        }
        catch{
            
            print(error);
            return nil;
        }
    }();
    
    /// 输出设备
    private lazy var output : AVCaptureMetadataOutput = AVCaptureMetadataOutput();
    
    //创建预览视图
    private lazy var previewlayer : AVCaptureVideoPreviewLayer = {
    
        let pre = AVCaptureVideoPreviewLayer(session: self.session);
        pre?.frame = UIScreen.main.bounds;
        return pre!;
    }();
}

/*************************** ************* 扫描二维码，输出代理 ************* ************* *************/
extension QrCode_ViewController : AVCaptureMetadataOutputObjectsDelegate{
    
    
    /// 显示二维扫描成功以后
    ///
    /// - Parameters:
    ///   - captureOutput: <#captureOutput description#>
    ///   - metadataObjects: <#metadataObjects description#>
    ///   - connection: <#connection description#>
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        
        let readableObject = metadataObjects.last as! AVMetadataMachineReadableCodeObject;
        print(readableObject.stringValue);
    }
        
}
