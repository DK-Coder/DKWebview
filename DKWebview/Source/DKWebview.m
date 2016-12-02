//
//  DKWebview.m
//  DKWebview
//
//  Created by xuli on 2016/12/1.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKWebview.h"

@interface DKWebview ()
{
    WKWebView *rootWebView;
    UIProgressView *progressView;
    
    
}
@end

@implementation DKWebview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    
    return self;
}

- (void)dealloc
{
    [rootWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)sharedInit
{
    self.backgroundColor = [UIColor whiteColor];
    
    CGRect frameForToolbar = CGRectMake(0.f, 0.f, self.frame.size.width, 40.f);
    CGRect frameForProgress = CGRectMake(0.f, frameForToolbar.size.height - 2.f, frameForToolbar.size.width, 2.f);
    CGRect frameForWebview = CGRectMake(0.f, frameForToolbar.size.height, self.frame.size.width, self.frame.size.height - frameForToolbar.size.height);
    // 工具栏区
    UIView *toolBar = [[UIView alloc] initWithFrame:frameForToolbar];
    toolBar.backgroundColor = [UIColor lightGrayColor];
    [self addButtonOnToolbar:toolBar tag:1 imageName:@"Back" selector:@selector(webViewGoBack)];
    [self addButtonOnToolbar:toolBar tag:2 imageName:@"Forward" selector:@selector(webViewGoForward)];
    [self addButtonOnToolbar:toolBar tag:3 imageName:@"Refresh" selector:@selector(webViewRefresh)];
    [self addButtonOnToolbar:toolBar tag:4 imageName:@"Stop" selector:@selector(webViewStopLoading)];
    [self addSubview:toolBar];
    // 进度条区
    progressView = [[UIProgressView alloc] initWithFrame:frameForProgress];
    [self addSubview:progressView];
    // webview区
    rootWebView = [[WKWebView alloc] initWithFrame:frameForWebview];
//    rootWebView.UIDelegate = self;
    rootWebView.navigationDelegate = self;
    [self addSubview:rootWebView];
    [rootWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)loadRequest:(NSURLRequest *)request
{
    if (rootWebView) {
        [rootWebView loadRequest:request];
    }
}

- (void)loadRequestWithURLString:(NSString *)urlString
{
    if (urlString) {
        // 将url中的中文进行转义
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        if (url) {
            NSURLRequest* request = [NSURLRequest requestWithURL:url];
            [rootWebView loadRequest:request];
        }
    }
}

- (void)webViewGoBack
{
    if (rootWebView && [rootWebView canGoBack]) {
        [rootWebView goBack];
    }
}

- (void)webViewGoForward
{
    if (rootWebView && [rootWebView canGoForward]) {
        [rootWebView goForward];
    }
}

- (void)webViewRefresh
{
    if (rootWebView) {
        [rootWebView reload];
    }
}

- (void)webViewStopLoading
{
    if (rootWebView && [rootWebView isLoading]) {
        progressView.alpha = 0.f;
        [self setStopButtonEnabled:NO];
        [rootWebView stopLoading];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == rootWebView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            double progress = rootWebView.estimatedProgress;
            [progressView setProgress:progress animated:YES];
            
            if (progress >= 1.f) {
                [self updateGoBackAndGoForwardStatus];
                [self setStopButtonEnabled:NO];
                
                [UIView animateWithDuration:1.f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    progressView.alpha = 0.f;
                } completion:nil];
            }
        }
    }
}

- (void)updateGoBackAndGoForwardStatus
{
    ((UIButton *)[self viewWithTag:1]).enabled = [rootWebView canGoBack];
    ((UIButton *)[self viewWithTag:2]).enabled = [rootWebView canGoForward];
}

- (void)setStopButtonEnabled:(BOOL)enabled
{
    ((UIButton *)[self viewWithTag:4]).enabled = enabled;
}

- (void)addButtonOnToolbar:(UIView *)toolBar tag:(NSInteger)tag imageName:(NSString *)name selector:(SEL)selector
{
    CGFloat widthForButton = 25.f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:tag];
    [button setFrame:CGRectMake(10.f * tag + widthForButton * (tag - 1), (toolBar.frame.size.height - widthForButton) / 2.f, widthForButton, widthForButton)];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Resources.bundle/%@", name]] forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:button];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    progressView.progress = 0.f;
    progressView.alpha = 1.f;
    [self setStopButtonEnabled:YES];
}
@end
