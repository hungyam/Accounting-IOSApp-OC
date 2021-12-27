//
//  SignUpVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/22.
//

#import "SignUpVC.h"
#import "StartNaviVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]

@interface SignUpVC ()

@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UITextView *nicknameText;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UITextView *usernameText;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextView *phoneText;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextView *passwordText;
@property (nonatomic, strong) UILabel *rePasswordLabel;
@property (nonatomic, strong) UITextView *rePasswordText;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tips];
    [self.view addSubview:self.userImg];
    [self.view addSubview:self.nicknameLabel];
    [self.view addSubview:self.nicknameText];
    [self.view addSubview:self.usernameLabel];
    [self.view addSubview:self.usernameText];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.rePasswordLabel];
    [self.view addSubview:self.rePasswordText];
    [self.view addSubview:self.submitButton];
}

- (UILabel *)tips {
    if (_tips == nil) {
        _tips = [[UILabel alloc]initWithFrame:CGRectMake(7 Wper, 10 Hper, 40 Wper, 8 Hper)];
        [_tips setFont:[UIFont systemFontOfSize:40 weight:UIFontWeightBold]];
        _tips.text = @"注册";
        _tips.textColor = [UIColor blackColor];
    }
    return _tips;
}

- (UIImageView *)userImg {
    if (_userImg == nil) {
        _userImg = [[UIImageView alloc] initWithFrame:CGRectMake(7 Wper, 20 Hper, 28 Wper, 28 Wper)];
        _userImg.image = [UIImage imageNamed:@"userImg.png"];
        _userImg.layer.cornerRadius = 60;
        _userImg.layer.masksToBounds = YES;
        _userImg.backgroundColor = [UIColor orangeColor];
    }
    return _userImg;
}

- (UILabel *)nicknameLabel {
    if (_nicknameLabel == nil) {
        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 35 Hper, 150, 30)];
        _nicknameLabel.text = @"昵称";
        _nicknameLabel.textColor = MainColor;
    }
    return _nicknameLabel;
}

- (UITextView *)nicknameText {
    if (_nicknameText == nil) {
        _nicknameText = [[UITextView alloc]initWithFrame:CGRectMake(8 Wper, 40 Hper - 15, 80 Wper, 40)];
        _nicknameText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        _nicknameText.backgroundColor = [UIColor whiteColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _nicknameText.frame.size.height - 1, _nicknameText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
        [_nicknameText.layer addSublayer:layer];
        [_nicknameText setScrollEnabled:NO];
    }
    return _nicknameText;
}

- (UILabel *)usernameLabel {
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 43 Hper, 150, 30)];
        _usernameLabel.text = @"用户名";
        _usernameLabel.textColor = MainColor;
    }
    return _usernameLabel;
}

- (UITextView *)usernameText {
    if (_usernameText == nil) {
        _usernameText = [[UITextView alloc]initWithFrame:CGRectMake(8 Wper, 48 Hper - 15, 80 Wper, 40)];
        _usernameText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _usernameText.frame.size.height - 1, _usernameText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
        [_usernameText.layer addSublayer:layer];
        [_usernameText setScrollEnabled:NO];
    }
    return _usernameText;
}

- (UILabel *)passwordLabel {
    if (_passwordLabel == nil) {
        _passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 51 Hper, 150, 30)];
        _passwordLabel.text = @"密码";
        _passwordLabel.textColor = MainColor;
    }
    return _passwordLabel;
}

- (UITextView *)passwordText {
    if (_passwordText == nil) {
        _passwordText = [[UITextView alloc]initWithFrame:CGRectMake(8 Wper, 56 Hper - 15, 80 Wper, 40)];
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
        _rePasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 59 Hper, 150, 30)];
        _rePasswordLabel.text = @"确认密码";
        _rePasswordLabel.textColor = MainColor;
    }
    return _rePasswordLabel;
}

- (UITextView *)rePasswordText {
    if (_rePasswordText == nil) {
        _rePasswordText = [[UITextView alloc]initWithFrame:CGRectMake(8 Wper, 64 Hper - 15, 80 Wper, 40)];
        _rePasswordText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _rePasswordText.frame.size.height - 1, _rePasswordText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
        [_rePasswordText.layer addSublayer:layer];
        [_rePasswordText setScrollEnabled:NO];
    }
    return _rePasswordText;
}

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(10 Wper, 80 Hper, 80 Wper, 55)];
        _submitButton.backgroundColor = MainColor;
        _submitButton.layer.cornerRadius = 10;
        [_submitButton setTitle:@"注册" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    }
    return _submitButton;
}
-(void)submitAction {
    [(StartNaviVC *)self.parentViewController signUpToLoginVC];
}

@end
