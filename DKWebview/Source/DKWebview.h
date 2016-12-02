//
//  DKWebview.h
//  DKWebview
//
//  Created by xuli on 2016/12/1.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DKWebview : UIView <WKUIDelegate, WKNavigationDelegate>

- (void)loadRequest:(NSURLRequest *)request;

- (void)loadRequestWithURLString:(NSString *)urlString;
@end
