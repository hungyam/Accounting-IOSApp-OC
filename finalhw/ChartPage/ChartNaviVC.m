//
//  ChartNaviVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/8.
//

#import "ChartNaviVC.h"

@interface ChartNaviVC ()

@property(nonatomic, strong) ChartVC *chartVC;

@end

@implementation ChartNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushViewController:self.chartVC animated:NO];
    self.title = @"图表";
}

- (ChartVC *)chartVC {
    if (_chartVC == nil) {
        _chartVC = [[ChartVC alloc]init];
    }
    return _chartVC;
}

@end
