//
//  ChangePassword.m
//  finalhw
//
//  Created by mazahs on 2021/12/26.
//

#import <Foundation/Foundation.h>
#import "ChangePassword.h"
#import "PersonalVC.h"

#define BackColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ChangePassword (){
    NSString *password;
}

@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextView *passwordText;
@property (nonatomic, strong) UILabel *newPasswordLabel;
@property (nonatomic, strong) UITextView *newPasswordText;

@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    self.navigationController.navigationBar.tintColor = MainColor;
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.newPasswordLabel];
    [self.view addSubview:self.newPasswordText];
}

- (void)loadUserMes {
    PersonalMes *mes = [DataManage getPersonalMes];
    password = mes.password;
}

- (UILabel *)passwordLabel {
    if (_passwordLabel == nil) {
        _passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(50 Wper-75, 9 Hper, 150, 30)];
        _passwordLabel.text = @"原密码";
        _passwordLabel.textAlignment = NSTextAlignmentCenter;
        _passwordLabel.textColor = MainColor;
    }
    return _passwordLabel;
}

- (UITextView *)passwordText {
    if (_passwordText == nil) {
        _passwordText = [[UITextView alloc]initWithFrame:CGRectMake(10 Wper, 17 Hper - 15, 80 Wper, 40)];
        _passwordText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _passwordText.frame.size.height - 1, _passwordText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _passwordText.backgroundColor = [UIColor clearColor];
        [_passwordText.layer addSublayer:layer];
        [_passwordText setScrollEnabled:NO];
    }
    return _passwordText;
}

- (UILabel *)newPasswordLabel {
    if (_newPasswordLabel == nil) {
        _newPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(50 Wper-75, 25 Hper, 150, 30)];
        _newPasswordLabel.text = @"新密码";
        _newPasswordLabel.textColor = MainColor;
        _newPasswordLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _newPasswordLabel;
}

- (UITextView *)newPasswordText {
    if (_newPasswordText == nil) {
        _newPasswordText = [[UITextView alloc]initWithFrame:CGRectMake(10 Wper, 32 Hper - 15, 80 Wper, 40)];
        _newPasswordText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _newPasswordText.frame.size.height - 1, _newPasswordText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _newPasswordText.backgroundColor = [UIColor clearColor];
        [_newPasswordText.layer addSublayer:layer];
        [_newPasswordText setScrollEnabled:NO];
    }
    return _newPasswordText;
}
@end
