//
//  ChangePassword.m
//  finalhw
//
//  Created by mazahs on 2021/12/26.
//

#import <Foundation/Foundation.h>
#import "ChangePassword.h"

#define BackColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ChangePassword ()

@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextView *passwordText;
@property (nonatomic, strong) UILabel *rePasswordLabel;
@property (nonatomic, strong) UITextView *rePasswordText;

@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    self.navigationController.navigationBar.tintColor = MainColor;
}

- (UILabel *)passwordLabel {
    if (_passwordLabel == nil) {
        _passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 59 Hper, 150, 30)];
        _passwordLabel.text = @"密码";
        _passwordLabel.textColor = MainColor;
    }
    return _passwordLabel;
}

- (UITextView *)passwordText {
    if (_passwordText == nil) {
        _passwordText = [[UITextView alloc]initWithFrame:CGRectMake(8 Wper, 64 Hper - 15, 80 Wper, 40)];
        _passwordText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _passwordText.frame.size.height - 1, _passwordText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
        [_passwordText.layer addSublayer:layer];
        [_passwordText setScrollEnabled:NO];
    }
    return _passwordText;
}

- (UILabel *)rePasswordLabel {
    if (_rePasswordLabel == nil) {
        _rePasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 67 Hper, 150, 30)];
        _rePasswordLabel.text = @"确认密码";
        _rePasswordLabel.textColor = MainColor;
    }
    return _rePasswordLabel;
}

- (UITextView *)rePasswordText {
    if (_rePasswordText == nil) {
        _rePasswordText = [[UITextView alloc]initWithFrame:CGRectMake(8 Wper, 72 Hper - 15, 80 Wper, 40)];
        _rePasswordText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _rePasswordText.frame.size.height - 1, _rePasswordText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
        [_rePasswordText.layer addSublayer:layer];
        [_rePasswordText setScrollEnabled:NO];
    }
    return _rePasswordText;
}
@end
