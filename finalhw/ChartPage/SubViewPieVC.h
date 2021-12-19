//
// Created by hungyam on 2021/12/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SubViewPieVC : UIViewController
- (instancetype)init;

- (void)refreshDataOfPie:(NSMutableArray *)dataArr andNameofPie:(NSMutableArray *)nameArr;

- (void)beginDrawPie;

- (void)clearTheView;
@end