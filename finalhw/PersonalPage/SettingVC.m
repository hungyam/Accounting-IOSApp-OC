//
//  SettingVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/5.
//

#import "SettingVC.h"
#import "PersonalVC.h"
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]

@interface SettingVC ()

@property (nonatomic, strong) SettingRootVC *rootVC;
@property (nonatomic, strong) ModifyMes *modifyVC;
@property (nonatomic, strong) ChangePassword *passwordVC;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pushViewController:self.rootVC animated:NO];
}

- (SettingRootVC *)rootVC {
    if (_rootVC == nil) {
        _rootVC = [[SettingRootVC alloc]init];
        _rootVC.title = @"设置";
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:MainColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismissPresentView) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        _rootVC.navigationItem.rightBarButtonItems = @[btnItem];
    }
    return _rootVC;
}

- (ModifyMes *)modifyVC {
    if (_modifyVC == nil) {
        _modifyVC = [[ModifyMes alloc]init];
        _modifyVC.title = @"账号设置";
    }
    return _modifyVC;
}
- (ChangePassword *)passwordVC {
    if (_passwordVC == nil) {
        _passwordVC = [[ChangePassword alloc]init];
        _passwordVC.title = @"密码修改";
    }
    return _passwordVC;
}

- (void)dismissPresentView {
    [(PersonalVC *)self.parentViewController resetMes];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushModifyMes {
    [self pushViewController:self.modifyVC animated:YES];
}
- (void)pushPasswordMes {
    [self pushViewController:self.passwordVC animated:YES];
}

-(void)poptosettingview{
    [self popToRootViewControllerAnimated:YES];
}

-(void)resetpre{
    [(PersonalVC *)self.parentViewController test];
    [(PersonalVC *)self.parentViewController resetMes];
    NSLog(@"%@",[DataManage getPersonalMes].nickname );
}



@end
