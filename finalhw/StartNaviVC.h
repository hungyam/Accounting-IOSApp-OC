//
//  StartNaviVC.h
//  finalhw
//
//  Created by hungyam on 2021/12/2.
//

#import <UIKit/UIKit.h>
#import "LoginVC.h"
#import "SignUpVC.h"
#import "TabBarVC.h"

@interface StartNaviVC : UINavigationController

- (void)loginToSignUpVC;
- (void)signUpToLoginVC;
- (void)goToMianVC;

@end

