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
#define LastestSubWper *_loginArea.bounds.size.width/100
#define LastestSubHper *_loginArea.bounds.size.height/100
#define MainColor [UIColor colorWithRed:255/255.0 green:78/255.0 blue:105/255.0 alpha:1]

@interface LoginVC ()

@property (nonatomic, strong) UILabel *welcomeTips;
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
    [self.view addSubview:self.welcomeTips];
    self.view.backgroundColor = [UIColor clearColor];
    //Set backgroundColor
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.zPosition = -1;
    gradientLayer.colors = @[
        (__bridge id)[UIColor colorWithRed:255/255.0 green:54/255.0 blue:117/255.0 alpha:1].CGColor,
        (__bridge id)[UIColor colorWithRed:255/255.0 green:106/255.0 blue:93/255.0 alpha:1].CGColor
    ];
    [self.view.layer addSublayer:gradientLayer];
    
}

- (UILabel *)welcomeTips {
    if (_welcomeTips == nil) {
        _welcomeTips = [[UILabel alloc] initWithFrame:CGRectMake(15 Wper, 16 Hper - 30, 70 Wper, 6.5 Hper)];
        _welcomeTips.text = @"欢迎回来";
        _welcomeTips.alpha = 0;
        _welcomeTips.textAlignment = NSTextAlignmentCenter;
        _welcomeTips.textColor = [UIColor whiteColor];
        _welcomeTips.font = [UIFont systemFontOfSize:40];
    }
    return _welcomeTips;
}

- (UIButton *)goToLogin {
    if (_goToLogin == nil) {
        _goToLogin = [[UIButton alloc] initWithFrame:CGRectMake(5.6 Wper, 79 Hper, 88.8 Wper, 6 Hper)];
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
        [self.welcomeTips setAlpha:1];
    }
                     completion:nil];
    [self.goToLogin removeTarget:self action:@selector(goToLoginAction) forControlEvents:UIControlEventTouchDown];
}

- (UIButton *)goToSignUp {
    if (_goToSignUp == nil) {
        _goToSignUp = [[UIButton alloc] initWithFrame:CGRectMake(5.6 Wper, 87 Hper, 88.8 Wper, 6 Hper)];
        _goToSignUp.backgroundColor = [UIColor clearColor];
        _goToSignUp.layer.borderWidth = 1.5;
        _goToSignUp.layer.borderColor = [UIColor whiteColor].CGColor;
        _goToSignUp.layer.cornerRadius = 6;
        [_goToSignUp setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_goToSignUp addTarget:self action:@selector(goToSignUpAction) forControlEvents:UIControlEventTouchDown];
    }
    return _goToSignUp;
}
- (void)goToSignUpAction {
    [(StartNaviVC *)self.parentViewController loginToSignUpVC];
}

- (UIView *)loginArea {
    if (_loginArea == nil) {
        _loginArea = [[UIView alloc]initWithFrame:CGRectMake(5.6 Wper, 32 Hper, 88.8 Wper, 32.4 Hper)];
        _loginArea.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
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

#pragma mark - SubViewInLoginArea

-(UILabel *)usernameLable {
    if (_usernameLable == nil) {
        _usernameLable = [[UILabel alloc]initWithFrame:CGRectMake(11.85 LastestSubWper, 2 LastestSubHper, 26.3 LastestSubWper, 20 LastestSubHper)];
        _usernameLable.text = @"用户名";
        [_usernameLable setFont:[UIFont systemFontOfSize:16]];
        [_usernameLable setTextColor:[UIColor whiteColor]];
    }
    return _usernameLable;
}

- (UITextView *)usernameInput {
    if (_usernameInput == nil) {
        _usernameInput = [[UITextView alloc]initWithFrame:CGRectMake(50 LastestSubWper - 130, 23 LastestSubHper - 25, 260, 50)];
        _usernameInput.backgroundColor = [UIColor clearColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _usernameInput.frame.size.height - 1, _usernameInput.frame.size.width, 1);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_usernameInput.layer addSublayer:layer];
        [_usernameInput setFont:[UIFont systemFontOfSize:25]];
        [_usernameInput setTextColor:[UIColor whiteColor]];
    }
    return _usernameInput;
}

- (UILabel *)passwordLable {
    if (_passwordLable == nil) {
        _passwordLable = [[UILabel alloc]initWithFrame:CGRectMake(11.85 LastestSubWper , 45 LastestSubHper - 30, 26.3 LastestSubWper, 60)];
        _passwordLable.text = @"密码";
        [_passwordLable setFont:[UIFont systemFontOfSize:16]];
        [_passwordLable setTextColor:[UIColor whiteColor]];
    }
    return _passwordLable;
}

- (UITextView *)passwordInput {
    if (_passwordInput == nil) {
        _passwordInput = [[UITextView alloc]initWithFrame:CGRectMake(50 LastestSubWper - 130, 56 LastestSubHper - 25, 260, 50)];
        _passwordInput.backgroundColor = [UIColor clearColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _passwordInput.frame.size.height - 1, _passwordInput.frame.size.width, 1);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_passwordInput.layer addSublayer:layer];
        [_passwordInput setFont:[UIFont systemFontOfSize:25]];
        [_passwordInput setTextColor:[UIColor whiteColor]];
    }
    return _passwordInput;
}

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(50 LastestSubWper - 150, 100 LastestSubHper - 48, 300, 60)];
        _submitButton.backgroundColor = [UIColor whiteColor];
        _submitButton.layer.cornerRadius = 30;
        _submitButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _submitButton.layer.shadowOffset = CGSizeMake(5, 5);
        _submitButton.layer.shadowRadius = 5;
        _submitButton.layer.shadowOpacity = 0.4;
        [_submitButton setTitle:@"登录" forState:UIControlStateNormal];
        [_submitButton setTitleColor:MainColor forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    }
    return _submitButton;
}
- (void)submitAction {
    NSLog(@"GoToMainVC");
    [(StartNaviVC *)self.parentViewController goToMianVC];
}

#pragma mark end -


@end
