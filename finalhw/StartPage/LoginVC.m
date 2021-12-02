//
//  LoginVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/22.
//

#import "LoginVC.h"
#import "StartNaviVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define SubWper *_loginArea.bounds.size.width/100
#define SubHper *_loginArea.bounds.size.height/100
#define MainColor [UIColor colorWithRed:119/255.0 green:97/255.0 blue:188/255.0 alpha:1]

@interface LoginVC ()

@property (nonatomic, strong) UIButton *goToLogin;
@property (nonatomic, strong) UIButton *goToSignUp;
@property (nonatomic, strong) UIView *loginArea;
@property (nonatomic, strong) UILabel *usernameLable;
@property (nonatomic, strong) UILabel *passwordLable;
@property (nonatomic, strong) UITextView *usernameInput;
@property (nonatomic, strong) UITextView *passwordInput;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.goToSignUp];
    [self.view addSubview:self.goToLogin];
    [self.view addSubview:self.loginArea];
    self.view.backgroundColor = MainColor;
}

- (UIButton *)goToLogin {
    if (_goToLogin == nil) {
        _goToLogin = [[UIButton alloc] initWithFrame:CGRectMake(50 Wper - 190, 82 Hper - 28, 380, 56)];
        _goToLogin.backgroundColor = [UIColor whiteColor];
        _goToLogin.layer.cornerRadius = 6;
        [_goToLogin setTitleColor:MainColor forState:UIControlStateNormal];
        [_goToLogin setTitle:@"通过账号密码登录" forState:UIControlStateNormal];
        [_goToLogin addTarget:self action:@selector(goToLoginAction) forControlEvents:UIControlEventTouchDown];
    }
    return _goToLogin;
}
- (void)goToLoginAction {
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
    }
                     completion:nil];
}

- (UIButton *)goToSignUp {
    if (_goToSignUp == nil) {
        _goToSignUp = [[UIButton alloc] initWithFrame:CGRectMake(50 Wper - 190, 90 Hper - 28, 380, 56)];
        _goToSignUp.backgroundColor = MainColor;
        _goToSignUp.layer.borderWidth = 1.5;
        _goToSignUp.layer.borderColor = [UIColor whiteColor].CGColor;
        _goToSignUp.layer.cornerRadius = 6;
        [_goToSignUp setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_goToSignUp addTarget:self action:@selector(goToSignUpAction) forControlEvents:UIControlEventTouchDown];
    }
    return _goToSignUp;
}
- (void)goToSignUpAction {
    [(StartNaviVC *)self.parentViewController goToSignUpVC];
}

- (UIView *)loginArea {
    if (_loginArea == nil) {
        _loginArea = [[UIView alloc]initWithFrame:CGRectMake(50 Wper - 190, 42 Hper - 200, 380, 400)];
        _loginArea.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9];
        _loginArea.layer.cornerRadius = 20;
        [_loginArea addSubview:self.usernameLable];
        [_loginArea addSubview:self.usernameInput];
        [_loginArea addSubview:self.passwordLable];
        [_loginArea addSubview:self.passwordInput];
        [_loginArea addSubview:self.submitButton];
        [_loginArea setAlpha:0];
    }
    return _loginArea;
}

#pragma mark SubViewInLoginArea

-(UILabel *)usernameLable {
    if (_usernameLable == nil) {
        _usernameLable = [[UILabel alloc]initWithFrame:CGRectMake(20 SubWper - 50, 12 SubHper - 30, 100, 60)];
        _usernameLable.text = @"用户名";
        [_usernameLable setFont:[UIFont systemFontOfSize:16]];
        [_usernameLable setTextColor:[UIColor colorWithRed:49/255.0 green:32/255.0 blue:79/255.0 alpha:1]];
    }
    return _usernameLable;
}

- (UITextView *)usernameInput {
    if (_usernameInput == nil) {
        _usernameInput = [[UITextView alloc]initWithFrame:CGRectMake(50 SubWper - 150, 23 SubHper - 25, 300, 50)];
        _usernameInput.backgroundColor = [UIColor clearColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _usernameInput.frame.size.height - 1, _usernameInput.frame.size.width, 1);
        layer.backgroundColor = [UIColor grayColor].CGColor;
        [_usernameInput.layer addSublayer:layer];
        [_usernameInput setFont:[UIFont systemFontOfSize:25]];
    }
    return _usernameInput;
}

- (UILabel *)passwordLable {
    if (_passwordLable == nil) {
        _passwordLable = [[UILabel alloc]initWithFrame:CGRectMake(20 SubWper - 50, 41 SubHper - 30, 100, 60)];
        _passwordLable.text = @"密码";
        [_passwordLable setFont:[UIFont systemFontOfSize:16]];
        [_passwordLable setTextColor:[UIColor colorWithRed:49/255.0 green:32/255.0 blue:79/255.0 alpha:1]];
    }
    return _passwordLable;
}

- (UITextView *)passwordInput {
    if (_passwordInput == nil) {
        _passwordInput = [[UITextView alloc]initWithFrame:CGRectMake(50 SubWper - 150, 52 SubHper - 25, 300, 50)];
        _passwordInput.backgroundColor = [UIColor clearColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _usernameInput.frame.size.height - 1, _usernameInput.frame.size.width, 1);
        layer.backgroundColor = [UIColor grayColor].CGColor;
        [_passwordInput.layer addSublayer:layer];
        [_passwordInput setFont:[UIFont systemFontOfSize:25]];
    }
    return _passwordInput;
}

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(50 SubWper - 100, 82 SubHper - 25, 200, 50)];
        _submitButton.backgroundColor = [UIColor colorWithRed:102/255.0 green:82/255.0 blue:160/255.0 alpha:1];
        _submitButton.layer.cornerRadius = 22;
        _submitButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _submitButton.layer.shadowOffset = CGSizeMake(5, 5);
        _submitButton.layer.shadowRadius = 5;
        _submitButton.layer.shadowOpacity = 0.4;
        [_submitButton setTitle:@"登录" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    }
    return _submitButton;
}
- (void)submitAction {
    NSLog(@"GoToMainVC");
    [(StartNaviVC *)self.parentViewController goToMianVC];
}

#pragma end


@end
