//
//  ViewController.m
//  DKWebview
//
//  Created by xuli on 2016/12/1.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "ViewController.h"
#import "DKWebview.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DKWebview *webview = [[DKWebview alloc] initWithFrame:CGRectMake(0.f, 64.f, self.view.frame.size.width, self.view.frame.size.height - 64.f)];
    [webview loadRequestWithURLString:@"https://www.baidu.com"];
    [self.view addSubview:webview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
