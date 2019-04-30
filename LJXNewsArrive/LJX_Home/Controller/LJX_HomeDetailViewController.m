//
//  LJX_HomeDetailViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_HomeDetailViewController.h"
#import <WebKit/WebKit.h>

@interface LJX_HomeDetailViewController () <WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UIActionSheetDelegate,WKScriptMessageHandler>

@property (nonatomic , strong) WKWebView * webView;

@end

@implementation LJX_HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"新闻详情";
    
    [self createWeb];
}

- (void) createWeb{
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    /*禁止缩放*/
    NSString *js = @" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContentController addUserScript:script];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    config.userContentController = [[WKUserContentController alloc]init];
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    wkWebView.allowsBackForwardNavigationGestures = YES;
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    wkWebView.scrollView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [wkWebView loadRequest:request];
    
    [self.view addSubview:wkWebView];
    __weak typeof (self) weakSelf = self;
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(NAScreenW);
        make.height.mas_equalTo(NAScreenH);
    }];
    self.webView = wkWebView;
}

#pragma mark -- WKScriptMessageHandler
//JS调用OC方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

}

#pragma mark -- 捏合手势禁止缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

#pragma mark - wkWebView代理
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *javaScript = [NSString stringWithFormat:@"document.getElementsByClassName('top-wrap gg-item J-gg-item')[0].remove();"];

    [_webView evaluateJavaScript:javaScript completionHandler:^(id _Nullable json, NSError * _Nullable error) {
        NSLog(@"json is %@, error is %@",json, error);
    }];
    
    NSString *article = [NSString stringWithFormat:@"document.getElementsByClassName('article-src-time')[0].remove();"];
    
    [_webView evaluateJavaScript:article completionHandler:^(id _Nullable json, NSError * _Nullable error) {
        NSLog(@"json is %@, error is %@",json, error);
    }];
}

#pragma mark -网络加载指示器
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 获取完整url并进行UTF-8转码
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    if ([strRequest hasPrefix:@"app://"]) {
        // 拦截点击链接
        //        [self handleCustomAction:strRequest];
        // 不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//接收到警告面板
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();//此处的completionHandler()就是调用JS方法时，`evaluateJavaScript`方法中的completionHandler
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


// 记得取消监听
- (void)dealloc {
    
}

@end
