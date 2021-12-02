//
//  StartNaviVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/2.
//

#import "StartNaviVC.h"

@interface StartNaviVC ()

@property (nonatomic, strong) LoginVC *loginVC;
@property (nonatomic, strong) SignUpVC *signUpVC;
@property (nonatomic, strong) TabBarVC *tabBarVC;

@end

@implementation StartNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pushViewController:self.tabBarVC animated:NO];
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
        [_signUpVC.navigationItem.backBarButtonItem setTitle:@"返回登录"];
    }
    return _signUpVC;
}

- (TabBarVC *)tabBarVC {
    if (_tabBarVC == nil) {
        _tabBarVC = [[TabBarVC alloc]init];
    }
    return _tabBarVC;
}

- (void)goToSignUpVC {
    [self pushViewController:self.signUpVC animated:YES];
}

- (void)backToLoginVC {
    [self popViewControllerAnimated:YES];
}

- (void)goToMianVC {
    [self popToRootViewControllerAnimated:YES];
}

@end
