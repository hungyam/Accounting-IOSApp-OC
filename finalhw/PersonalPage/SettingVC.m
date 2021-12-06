//
//  SettingVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/5.
//

#import "SettingVC.h"
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]

@interface SettingVC ()

@property (nonatomic, strong) SettingRootVC *rootVC;
@property (nonatomic, strong) ModifyMes *modifyVC;

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

- (void)dismissPresentView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushModifyMes {
    [self pushViewController:self.modifyVC animated:YES];
}



@end
