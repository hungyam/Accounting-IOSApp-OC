//
//  DetailNaviVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/11.
//

#import "DetailNaviVC.h"

@interface DetailNaviVC ()

@property (nonatomic, strong) DetailVC *detailVC;
@property (nonatomic, strong) AccountDetailVC *accountDetailVC;

@end

@implementation DetailNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushViewController:self.detailVC animated:NO];
    [self.navigationController.navigationBar setHidden:YES];
    self.title = @"详情";
}

- (DetailVC *)detailVC {
    if (_detailVC == nil) {
        _detailVC = [[DetailVC alloc]init];
    }
    return _detailVC;
}

- (void)pushAccountDetailPage:(NSInteger)index {
    self.accountDetailVC = [[AccountDetailVC alloc] initWithIndex:index];
    [self pushViewController:self.accountDetailVC animated:YES];
}


@end
