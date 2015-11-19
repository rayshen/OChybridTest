//
//  ViewController.m
//  OChybridTest
//
//  Created by shen on 15/11/19.
//  Copyright © 2015年 shen. All rights reserved.
//

#import "ViewController.h"


#define kURL @"http://dong14.sinaapp.com/testhtml.html"

@interface ViewController (){
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view  setBackgroundColor:[UIColor lightGrayColor]];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,22, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-66)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kURL]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    [webView setDelegate:self];
    
    UIButton *clkbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-44, 88, 44)];
    [clkbtn setTitle:@"调用JS" forState:UIControlStateNormal];
    [clkbtn setBackgroundColor:[UIColor redColor]];
    [clkbtn addTarget:self action:@selector(jsclk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clkbtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 网页中的每一个请求都会被触发
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    // 每次跳转时候判断URL
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/openMyAlbum"])
    {
        NSLog(@"openMyAlbum");
        [self openMyAlbum];
        return NO;
    }
    
    // 每次跳转时候判断URL
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/openMyCamera"])
    {
        NSLog(@"openMyCamera");
        [self openMyCamera];
        return NO;
    }
    
    return YES;
}

-(void)openMyAlbum
{
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)openMyCamera
{
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)jsclk{
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"postStr();"];
    NSLog(@"JS返回值：%@",str);
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 2,  CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-66)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    NSLog(@"webViewDidStartLoad");
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
    
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"didFailLoadWithError:%@", error);
}
@end