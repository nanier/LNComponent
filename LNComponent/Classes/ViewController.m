//
//  ViewController.m
//  LNWebViewTest
//
//  Created by lina on 25/04/2017.
//  Copyright © 2017 lina. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate, WKScriptMessageHandler>

@end

@implementation ViewController
{
    WKWebView *_webView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    NSString *scriptSource = @"navigator.geolocation.getCurrentPosition = function() { var error ={code:1,message:'User denied Geolocation'}; if(arguments.length > 1) { arguments[1](error); } }; navigator.geolocation.watchPosition = function() { var error ={ code:1,message:'User denied Geolocation'}; if(arguments.length > 1) { arguments[1](error); } }";
    WKUserScript *script = [[WKUserScript alloc] initWithSource:scriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [config.userContentController addUserScript:script];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    _webView.allowsBackForwardNavigationGestures = YES;
    _webView.userInteractionEnabled = YES;
    [self.view addSubview:_webView];
    _webView.frame = self.view.frame;
//    UICalloutBar *bar = [UICalloutBar activeCalloutBar];

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
//    dianping://home?utm_=__278du
    NSString *urlString = @"https://www.baidu.com";
//    urlString = @"dianping://home?utm_=__278du";
//    urlString = @"openapp.jdmobile://virtual?&params=%7B%22category%22:%22jump%22,%22des%22:%22HomePage%22,%22sourceType%22:%22JSHOP_SOURCE_TYPE%22,%22sourceValue%22:%22JSHOP_SOURCE_VALUE%22,%22M_sourceFrom%22:%22index%22,%22msf_type%22:%22auto%22,%22m_param%22:%7B%22m_source%22:%220%22,%22event_series%22:%7B%7D,%22jda%22:%22122270672.149318852698431881472.1493188526.1493188526.1493188526.1%22,%22usc%22:%22direct%22,%22ucp%22:%22-%22,%22umd%22:%22none%22,%22utr%22:%22-%22,%22jdv%22:%22122270672%7Cdirect%7C-%7Cnone%7C-%7C1493188526984%22,%22ref%22:%22https%3A%2F%2Fm.jd.com%2F%22,%22psn%22:%22149318852698431881472%7C1%22,%22psq%22:1,%22unpl%22:%22%22,%22pc_source%22:%22%22,%22mba_muid%22:%22149318852698431881472%22,%22mba_sid%22:%2214931885269884762463418301195%22,%22mt_xid%22:%22%22,%22mt_subsite%22:%22%22%7D,%22SE%22:%7B%22mt_subsite%22:%22%22,%22__jdv%22:%22122270672%7Cdirect%7C-%7Cnone%7C-%7C1493188526984%22,%22unpl%22:%22%22,%22__jda%22:%22122270672.149318852698431881472.1493188526.1493188526.1493188526.1%22%7D%7D";
    NSURL *webURL = [NSURL URLWithString:urlString];
    [_webView loadRequest:[NSURLRequest requestWithURL:webURL]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"------did finish Navigation");
    
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"------did start Navigation");
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"------did fail error = %@",error);
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"------didCommit Navigation = %@",navigation);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"------decideAction --- %@,",navigationAction);
    
    NSURL *url = navigationAction.request.URL;
    NSString *newUrlStr = @"dianping://home?utm_=__278du";
    NSLog(@"-----url = %@",url.absoluteString);
    if (![url.absoluteString containsString:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newUrlStr]];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;

//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//
//        } 
    }
//    //    _decideActionURL = navigationAction.request.URL;
//    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
//        if (_decideActionURL) {
//            url = _decideActionURL;
//        }
//        if ([SGIOpenUtil canOpenURL:url]) {
//            [SGIOpenUtil openURL:url];
//            decisionHandler(WKNavigationActionPolicyCancel);
//        } else {
//            decisionHandler(WKNavigationResponsePolicyAllow);
//        }
//    } else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//    _decideActionURL = navigationAction.request.URL;
    
    decisionHandler(WKNavigationActionPolicyAllow);
 
    
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"------didReciveScriptMessage = %@",message);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"------ddcidePolicy --responde = %@",navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSLog(@"----createWEbview ---- configuration = %@,action = %@,feature = %@",configuration, navigationAction, windowFeatures);
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"----alert ---message = %@",message);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
    NSLog(@"----confirmPanel ---message = %@",message);
}


- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    NSLog(@"----textinput --prompt = %@-defaultText = %@",prompt, defaultText);
}

@end
