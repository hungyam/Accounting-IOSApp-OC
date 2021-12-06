//
//  SettingRootVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/5.
//

#import "SettingRootVC.h"
#import "SettingVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define BackColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]


@interface SettingRootVC ()

@property (nonatomic, strong) UIButton *modifyButton;

@end

@implementation SettingRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.modifyButton];
}

- (UIButton *)modifyButton {
    if (_modifyButton == nil) {
        _modifyButton = [[UIButton alloc]initWithFrame:CGRectMake(5 Wper, 8 Hper, 90 Wper, 6 Hper)];
        _modifyButton.backgroundColor = [UIColor whiteColor];
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(90 Wper * 0.05, 0, 90 Wper * 0.3, 6 Hper)];
        text.text = @"账号设置";
        text.textColor = [UIColor blackColor];
        [_modifyButton addSubview:text];
        _modifyButton.layer.cornerRadius = 10;
        [_modifyButton addTarget:self action:@selector(modifyButtonAction) forControlEvents:UIControlEventTouchDown];
    }
    return _modifyButton;
}
- (void)modifyButtonAction {
    [(SettingVC *)self.parentViewController pushModifyMes];
}

@end
