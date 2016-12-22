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

@property (nonatomic, strong) UIColor *progressTintColor; /**< 进度条的颜色*/

@property (nonatomic, strong) UIColor *progressNotFilledColor;/**< 还没有被进度条覆盖的填充颜色*/

@property (nonatomic, strong) UIColor *progressFilledColor; /**< 已经被进度条覆盖的填充颜色，该颜色会覆盖tintColor设置的颜色*/

- (void)loadRequest:(NSURLRequest *)request;

- (void)loadRequestWithURLString:(NSString *)urlString;
@end
