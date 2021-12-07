//
//  DataManage.m
//  finalhw
//
//  Created by hungyam on 2021/12/7.
//

#import "DataManage.h"

@implementation PersonalMes

@end

@interface DataManage ()

@end

@implementation DataManage

+ (PersonalMes *)getPersonalMes {
    PersonalMes *re = [[PersonalMes alloc]init];
    re.username = @"HungyamHui0530";
    re.points = 233;
    re.nickname = @"Hungyam";
    re.userImg = [UIImage imageNamed:@"userImg.png"];
    return re;
}






@end
