//
//  TabBarVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/11.
//

#import "TabBarVC.h"
#define MainColor [UIColor colorWithRed:244/255.0 green:105/255.0 blue:123/255.0 alpha:1]

@interface TabBarVC ()

//DetailPage RootVC
@property (nonatomic, strong) DetailVC* detailVC;
//ChartPage RootVC
@property (nonatomic, strong) ChartVC* chartVC;
//NewEntry RootVC
@property (nonatomic, strong) NewEntryVC* addEntryVC;
//ExtendedPage RootVC
@property (nonatomic, strong) ExtendedVC* extendedVC;
//PersonalPage RootVC
@property (nonatomic, strong) PersonalVC* personalVC;

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewControllers = @[
        self.detailVC,
        self.chartVC,
        self.addEntryVC,
        self.extendedVC,
        self.personalVC
    ];
    self.tabBar.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.tabBar.tintColor = MainColor;
    UIView *test = [[UIView alloc]initWithFrame:CGRectMake(40 * self.tabBar.bounds.size.width, 0, 20 * self.tabBar.bounds.size.width,  self.tabBar.bounds.size.height)];
    test.backgroundColor = [UIColor purpleColor];
    self.tabBar add
    self.selectedIndex = 4;
}

- (DetailVC *)detailVC {
    if (_detailVC == nil) {
        _detailVC = [[DetailVC alloc] init];
        _detailVC.title = @"详情";
        _detailVC.tabBarItem.image = [UIImage systemImageNamed:@"list.dash"];
    }
    return _detailVC;
}

- (ChartVC *)chartVC {
    if (_chartVC == nil) {
        _chartVC = [[ChartVC alloc] init];
        _chartVC.title = @"图表";
        _chartVC.tabBarItem.image = [UIImage systemImageNamed:@"chart.line.uptrend.xyaxis"];
    }
    return _chartVC;
}

- (NewEntryVC *)addEntryVC {
    if (_addEntryVC == nil) {
        _addEntryVC = [[NewEntryVC alloc] init];
        _addEntryVC.title = @"添加纪录";
        _addEntryVC.tabBarItem.image = [UIImage systemImageNamed:@"plus"];
    }
    return _addEntryVC;
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



@end
