//
//  playVideoController.swift
//  OTBMagazine
//
//  Created by Adriano Ramos on 8/7/17.
//  Copyright © 2017 Adriano Ramos. All rights reserved.
//

import UIKit

class playVideoController: UIViewController, UIWebViewDelegate {
    
    var myWebView = UIWebView()
    
    private var videoID: String?
    
    func fetchVideoID(_ youtubeId: String) {
//        print("A>", youtubeId)
        videoID = youtubeId
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myWebView.delegate = self
        setupController()
        playVideo(videoID: videoID!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(OrientationDidChange), name: .UIDeviceOrientationDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(video), name: .UIWindowDidBecomeKey, object: nil)
    }
    
    
    @objc func OrientationDidChange() {
        print("OrientationDidChange")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @objc func video() {
        print("video")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.isStatusBarHidden = true
        OrientationDidChange()
    }
    
    
    func setupController() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationItem.title = "Video"
        myWebView.frame = CGRect(x: 0, y: ( (self.view.frame.height / 2) - ( (self.view.frame.width / (16 / 9)) / 2 ) ), width: self.view.frame.width, height: (self.view.frame.width / (16 / 9)) )
        view.addSubview(myWebView)
        myWebView.isOpaque = false
        myWebView.backgroundColor = .rgb(red: 247, green: 252, blue: 255)
        myWebView.scrollView.isScrollEnabled = false
        myWebView.allowsPictureInPictureMediaPlayback = false
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    
    func playVideo(videoID: String) {
        
        homeController().customActivityIndicator(self.view, startAnimate: true)
        
        let url = URL(string: "https://www.youtube.com/embed/\(videoID)?modestbranding=1;rel=0;showinfo=0;")

        self.myWebView.loadRequest(URLRequest(url: url!))

        homeController().customActivityIndicator(self.view, startAnimate: false)
        
    }
    
    
    // UIWebViewDelegate
    public func webViewDidStartLoad(_ webView: UIWebView) {
        homeController().customActivityIndicator(self.view, startAnimate: true)
    }
    
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        homeController().customActivityIndicator(self.view, startAnimate: false)
    }
    
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        homeController().customActivityIndicator(self.view, startAnimate: false)
        print("E>", error)
        
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong...\nCheck you internet connection.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        
        self.present(alert, animated: true)
    }

}




















