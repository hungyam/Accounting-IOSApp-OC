//
//  AccountDetailVC.m
//  finalhw
//
//  Created by hungyam on 2021/12/11.
//

#import "AccountDetailVC.h"

@interface AccountDetailVC () {
    NSInteger accountIndex;
}

@property (nonatomic, strong) UILabel *test;

@end

@implementation AccountDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.test];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithIndex:(NSInteger)index{
    self = [super init];
    accountIndex = index;
    return self;
}

- (UILabel *)test {
    if (_test == nil) {
        _test = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 200)];
        _test.text = [NSString stringWithFormat:@"%d",accountIndex];
        _test.backgroundColor = [UIColor purpleColor];
    }
    return _test;
}



@end
