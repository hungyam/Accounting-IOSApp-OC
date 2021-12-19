//
//  ChartVC.h
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import <UIKit/UIKit.h>
#import "SubViewPieVC.h"
@interface ChartVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(void)refresh;
-(void)renewdata;
@end
