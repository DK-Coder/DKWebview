//
//  ViewController.m
//  DKWebview
//
//  Created by xuli on 2016/12/1.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "ViewController.h"
#import "DKWebview.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *arrayEmojis;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    DKWebview *webview = [[DKWebview alloc] initWithFrame:CGRectMake(0.f, 64.f, self.view.frame.size.width, self.view.frame.size.height - 64.f)];
//    [webview loadRequestWithURLString:@"https://www.baidu.com"];
//    [self.view addSubview:webview];
    
    NSArray *array = @[@"aaa", @"bbb"];
    NSString *str = array[4];
    NSLog(@"%@", str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
