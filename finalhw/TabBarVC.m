//
//  TabBarVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/11.
//

#import "TabBarVC.h"
#define MainColor [UIColor colorWithRed:244/255.0 green:105/255.0 blue:123/255.0 alpha:1]

@interface TabBarVC () {
    BOOL flag;
}

//Plus Button
@property (nonatomic, strong) UIButton* plusButton;

@property (nonatomic, strong) DetailNaviVC* detailNaviVC;
@property (nonatomic, strong) ChartNaviVC* chartNaviVC;
@property (nonatomic, strong) NewEntryNaviVC* addEntryNaviVC;
@property (nonatomic, strong) ExtendedVC* extendedVC;
@property (nonatomic, strong) PersonalVC* personalVC;

@property (nonatomic, strong) StartNaviVC *startNaviVC;

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    flag = NO;
    self.viewControllers = @[
        self.detailNaviVC,
        self.chartNaviVC,
        [[UIViewController alloc]init],
        self.extendedVC,
        self.personalVC
    ];
    self.tabBar.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.tabBar.tintColor = MainColor;
    [self.view addSubview:self.plusButton];
    [self.view bringSubviewToFront:self.plusButton];
    [self setSelectedIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (flag) {
        [self presentViewController:self.startNaviVC animated:NO completion:nil];
        flag = NO;
    }
}

- (void)showStartNaviVC {
    [self presentViewController:self.startNaviVC animated:YES completion:nil];
}

- (UIButton *)plusButton {
    if (_plusButton == nil) {
        _plusButton = [[UIButton alloc]initWithFrame:CGRectMake((self.tabBar.frame.size.width - 60.0) / 2, (self.view.frame.size.height - 60.0) - 33.0, 60.0, 60.0)];
        _plusButton.backgroundColor = MainColor;
        _plusButton.layer.shadowColor = MainColor.CGColor;
        _plusButton.layer.shadowOffset = CGSizeMake(0, 0);
        _plusButton.layer.shadowRadius = 10;
        _plusButton.layer.shadowOpacity = 0.6;
        _plusButton.layer.cornerRadius = 20;
        [_plusButton setTintColor:[UIColor whiteColor]];
        [_plusButton setImage:[UIImage systemImageNamed:@"plus"] forState:UIControlStateNormal];
        [_plusButton addTarget:self action:@selector(showNewEntryPage) forControlEvents:UIControlEventTouchDown];
    }
    return _plusButton;
}

- (void)showNewEntryPage {
    [self presentViewController:self.addEntryNaviVC animated:YES completion:nil];
}

- (DetailNaviVC *)detailNaviVC {
    if (_detailNaviVC == nil) {
        _detailNaviVC = [[DetailNaviVC alloc] init];
        _detailNaviVC.title = @"详情";
        _detailNaviVC.tabBarItem.image = [UIImage systemImageNamed:@"list.dash"];
    }
    return _detailNaviVC;
}

- (ChartNaviVC *)chartNaviVC {
    if (_chartNaviVC == nil) {
        _chartNaviVC = [[ChartNaviVC alloc] init];
        _chartNaviVC.title = @"图表";
        _chartNaviVC.tabBarItem.image = [UIImage systemImageNamed:@"chart.line.uptrend.xyaxis"];
    }
    return _chartNaviVC;
}

- (NewEntryNaviVC *)addEntryNaviVC {
    if (_addEntryNaviVC == nil) {
        _addEntryNaviVC = [[NewEntryNaviVC alloc] init];
        _addEntryNaviVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return _addEntryNaviVC;
}

- (ExtendedVC *)extendedVC {
    if (_extendedVC == nil) {
        _extendedVC = [[ExtendedVC alloc] init];
        _extendedVC.title = @"扩展";
        _extendedVC.tabBarItem.image = [UIImage systemImageNamed:@"puzzlepiece.extension"];
    }
    return _extendedVC;
}

- (PersonalVC *)personalVC {
    if (_personalVC == nil) {
        _personalVC = [[PersonalVC alloc] init];
        _personalVC.title = @"我的";
        _personalVC.tabBarItem.image = [UIImage systemImageNamed:@"person"];
    }
    return _personalVC;
}

- (StartNaviVC *)startNaviVC {
    if (_startNaviVC == nil) {
        _startNaviVC = [[StartNaviVC alloc]init];
        _startNaviVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return _startNaviVC;
}



@end
