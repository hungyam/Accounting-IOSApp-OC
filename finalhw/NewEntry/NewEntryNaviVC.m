//
//  NewEntryNavi.m
//  finalhw
//
//  Created by hungyam on 2021/12/11.
//

#import "NewEntryNaviVC.h"
#define MainColor [UIColor colorWithRed:244/255.0 green:105/255.0 blue:123/255.0 alpha:1]

@interface NewEntryNaviVC ()

@property(nonatomic, strong) NewEntryVC *newEntryVC;

@end

@implementation NewEntryNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self pushViewController:self.newEntryVC animated:NO];
    [self.navigationController.navigationBar setHidden:YES];
}

- (NewEntryVC *)newEntryVC {
    if (_newEntryVC == nil) {
        _newEntryVC = [[NewEntryVC alloc]init];
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:MainColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismissPresentView) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        _newEntryVC.navigationItem.rightBarButtonItems = @[btnItem];
    }
    return _newEntryVC;
}

- (void)dismissPresentView {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
