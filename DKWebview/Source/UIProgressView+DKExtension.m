//
//  UIProgressView+DKExtension.m
//  DKWebview
//
//  Created by xuli on 2016/12/5.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "UIProgressView+DKExtension.h"

@implementation UIProgressView (DKExtension)

- (void)setAlpha:(CGFloat)alpha animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:1.f delay:.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = alpha;
        } completion:nil];
    } else {
        self.alpha = alpha;
    }
}
@end
