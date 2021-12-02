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

