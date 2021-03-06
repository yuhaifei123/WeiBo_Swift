//
//  OAuth_ViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
// 微博，OAuth 授权


import UIKit

class OAuth_ViewController: UIViewController {
    
    let App_Key = "2456904034";
    let App_Secret = "52352b4b2476e00c6c20ed2ed052be22";
    let webURL = "http://www.520it.com";
    var code : String?;
    
    override func loadView() {
        super.loadView();
        
        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addView();
        
        OAuthGet();
    }
    
    
    /// 设置开始 view
    private func addView(){
        
        self.navigationItem.title = "微博登录";
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: UIBarButtonItemStyle.plain, target: self, action:"closea");
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.close));
    }
    
    func close(){
        
        dismiss(animated: true, completion: nil);
    }
    
    /// 请求授权
    private func OAuthGet(){
        
         let  string_url = "https://api.weibo.com/oauth2/authorize?client_id=\(App_Key)&redirect_uri=\(webURL)";
        let url = URL(string: string_url);
        //设置请求路径
        let request = URLRequest(url: url!);
        //webview 发送一个请求
        webView.loadRequest(request);
    }
    
    //MARK -- 懒加载
    private lazy var webView : UIWebView = {
    
        let webView = UIWebView();
        webView.delegate = self;
        return webView;
    }();
}


// MARK: - <#UIWebViewDelegate#>
extension OAuth_ViewController :UIWebViewDelegate{

    
    /// weiview 每次请求网络时候，调用这个方法
    ///
    /// - Parameters:
    ///   - webView: <#webView description#>
    ///   - request: <#request description#>
    ///   - navigationType: <#navigationType description#>
    /// - Returns: <#return value description#>
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let string_code = "code=";
        //得到访问路径
        let string_url = request.url?.absoluteString;
        let  string_range = string_url!.range(of:string_code);
        //是不是以"webURL" 为头部
        let bool_hasPre : Bool = (string_url!.hasPrefix(webURL));
        //到授权界面
        if bool_hasPre {
            
            //授权了
            if string_range != nil{
                
                //截取 code
                let array_code : Array<String?> = string_url!.components(separatedBy: string_code);
                code = array_code[1];
                access_token();
                return false;
            }
            //取消授权
        }
        
        return true;
    }
    
    
    /// 开始加载 webview 时 调用方法
    ///
    /// - Parameter webView: <#webView description#>
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        SVProgressHUD.showInfo(withStatus: "正在加载");
    }
    
    /// 结束加载 webview 时 调用方法
    ///
    /// - Parameter webView: <#webView description#>
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        //关闭
        SVProgressHUD.dismiss();
    }
    
    /// 获取授权过的Access Token
    private func access_token(){
        
        let string_url : String = "oauth2/access_token";
        let parametersa : Dictionary = ["client_id":App_Key,"client_secret" : App_Secret,"grant_type" : "authorization_code","code" : code, "redirect_uri" : webURL];
        
        AFNetworkTools.shareNetwork().post(string_url, parameters: parametersa, progress: {
            (Progress) -> Void in
            
        }, success: {
            (_, JSON) -> Void in
            
            let accessToken_Model = AccessToken_Model(dic: JSON as! [String : AnyObject]);
            //获得用户详细信息
            accessToken_Model.loadUserInfo(finished: { (accessTokenModel, Error) -> (Void) in
                
                if accessTokenModel != nil {
                    accessToken_Model.saveAccessToken();
                    // 去欢迎界面
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SwitchRootViewControllerKey), object: false, userInfo: nil);
                    
                    return;
                }
                
                SVProgressHUD.showInfo(withStatus: "网络不给力");
                let acc = AccessToken_Model.loadAccessToken();
            });

        }, failure: {
            (URLSessionDataTask, Error) -> Void in
            
            print(Error as! String);
        });
    }
    
}









