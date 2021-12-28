//
//  PersonalVC.h
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import <UIKit/UIKit.h>
#import "SettingVC.h"
#import "DataManage.h"


@interface PersonalVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (void)loadUserMes;

@end
