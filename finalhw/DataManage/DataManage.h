//
//  DataManage.h
//  finalhw
//
//  Created by hungyam on 2021/12/7.
//

#import <UIKit/UIKit.h>

@interface PersonalMes : NSObject

@property NSString *nickname;
@property UIImage *userImg;
@property NSString *username;
@property NSInteger points;

@end

@interface IconType : NSObject

@property UIImage *icon;
@property NSString *label;

- (instancetype)initWithImg:(UIImage *)img label:(NSString *)label;

@end

@interface DataManage : NSObject

+ (PersonalMes *)getPersonalMes;
+ (NSMutableArray *)getIconArray;

@end
