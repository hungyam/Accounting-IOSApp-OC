//
//  keepMethod.m
//  finalhw
//
//  Created by hungyam on 2021/12/2.
//

#import <UIKit/UIKit.h>
//毛玻璃效果 添加进view
UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
UIVisualEffectView *visual = [[UIVisualEffectView alloc]initWithEffect:blur];
visual.frame = _loginArea.frame;
visual.alpha = 0.6;
//渐变
CAGradientLayer *gradientLayer = [CAGradientLayer layer];
gradientLayer.frame = self.view.bounds;
gradientLayer.startPoint = CGPointMake(0, 1);
gradientLayer.endPoint = CGPointMake(1, 0);
gradientLayer.zPosition = -1;
gradientLayer.colors = @[
    (__bridge id)[UIColor colorWithRed:255/255.0 green:54/255.0 blue:117/255.0 alpha:1].CGColor,
    (__bridge id)[UIColor colorWithRed:255/255.0 green:106/255.0 blue:93/255.0 alpha:1].CGColor
];
//动画
CAKeyframeAnimation *ani= [CAKeyframeAnimation animationWithKeyPath:@"position"];
ani.duration = 1.0;
ani.removedOnCompletion = NO;
ani.fillMode = kCAFillModeForwards;
ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50 Wper, 82 Hper)];
NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(50 Wper, 100 Hper + 28)];
ani.values = @[value1, value2];
[self.goToLogin.layer addAnimation:ani forKey:@"hide"];

[UIView animateWithDuration:0.5
                      delay:0
                    options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
    [self.loginArea setAlpha:1];
    [self.welcomeTips setAlpha:1];
}
                 completion:nil];
