//
//  NewEntryVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "NewEntryVC.h"
#import "DataManage.h"

@interface NewEntryVC ()

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation NewEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self listArr];
}

- (NSMutableArray *)listArr {
    if (_listArr == nil) {
        _listArr = [DataManage getIconArray];
        NSLog(@"%@",((IconType *)_listArr[10]).label);
    }
    return _listArr;
}

@end
