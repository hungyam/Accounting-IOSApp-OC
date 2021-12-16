//
//  DetailVC.h
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import <UIKit/UIKit.h>
#import "DataManage.h"

@interface DetailVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithIndex:(NSInteger)index;

@end
