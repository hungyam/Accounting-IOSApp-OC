//
//  ChartVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "ChartVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ChartVC ()

@property (nonatomic, strong) UIScrollView *chartView;

@end

@implementation ChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIScrollView *)chartView {
    if (_chartView == nil) {
        _chartView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 100 Wper, 40 Hper)];
        
        
    }
    return _chartView;
}


@end
