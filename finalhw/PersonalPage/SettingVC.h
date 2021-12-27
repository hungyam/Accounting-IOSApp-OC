//
//  SettingVC.h
//  finalhw
//
//  Created by hungyam on 2021/12/5.
//

#import <UIKit/UIKit.h>
#import "SettingRootVC.h"
#import "ModifyMes.h"
#import "ChangePassword.h"
@interface SettingVC : UINavigationController

- (void)pushModifyMes;
- (void)pushPasswordMes;
@end
