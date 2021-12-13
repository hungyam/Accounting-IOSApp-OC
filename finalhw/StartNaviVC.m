//
//  StartNaviVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/2.
//

#import "StartNaviVC.h"
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]

@interface StartNaviVC ()

@property (nonatomic, strong) LoginVC *loginVC;
@property (nonatomic, strong) SignUpVC *signUpVC;

@end

@implementation StartNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pushViewController:self.loginVC animated:NO];
}

- (LoginVC *)loginVC {
    if (_loginVC == nil) {
        _loginVC = [[LoginVC alloc]init];
        [_loginVC.navigationItem setHidesBackButton:YES];
    }
    return _loginVC;
}

- (SignUpVC *)signUpVC {
    if (_signUpVC == nil) {
        _signUpVC = [[SignUpVC alloc]init];
        _signUpVC.view.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage systemImageNamed:@"chevron.backward"] forState:UIControlStateNormal];
        [btn setTintColor:MainColor];
        [btn addTarget:self action:@selector(signUpToLoginVC) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        _signUpVC.navigationItem.leftBarButtonItems = @[btnItem];
    }
    return _signUpVC;
}


- (void)loginToSignUpVC {
    [self pushViewController:self.signUpVC animated:YES];
}

- (void)signUpToLoginVC {
    [self popViewControllerAnimated:YES];
}

- (void)goToMianVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
