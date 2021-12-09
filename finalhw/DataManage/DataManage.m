//
//  DataManage.m
//  finalhw
//
//  Created by hungyam on 2021/12/7.
//

#import "DataManage.h"

@implementation PersonalMes

@end

@implementation IconType

- (instancetype)initWithImg:(UIImage *)img label:(NSString *)label {
    self.icon = img;
    self.label = label;
    return self;
}

@end

static NSMutableArray *iconArray;

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

+ (void)setIconArray {
    iconArray = [[NSMutableArray alloc]init];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"caipiao.png"] label:@"彩票"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"canyin.png"] label:@"餐饮"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"chongwu.png"] label:@"宠物"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"dianying.png"] label:@"电影"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"fangdai.png"] label:@"房贷"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"guoshu.png"] label:@"果蔬"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"jianshen.png"] label:@"健身"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"jiaotong.png"] label:@"交通"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"jiezhi.png"] label:@"饰品"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"licai.png"] label:@"理财"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"lingshi.png"] label:@"零食"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"lvyou.png"] label:@"旅游"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"meirong.png"] label:@"美容"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"muying.png"] label:@"母婴"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"naicha.png"] label:@"奶茶"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"qiche.png"] label:@"汽车"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"shejiao.png"] label:@"社交"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"shuji.png"] label:@"书籍"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"shuma.png"] label:@"数码"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"tongxun.png"] label:@"通讯"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"wangluo.png"] label:@"网络"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"wenjv.png"] label:@"文具"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"xiemao.png"] label:@"鞋帽"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yanjiu.png"] label:@"烟酒"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yifu.png"] label:@"衣服"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yiliao.png"] label:@"医疗"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yundong.png"] label:@"运动"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yvle.png"] label:@"娱乐"]];
    [iconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"zhufang.png"] label:@"住房"]];
}

+ (NSMutableArray *)getIconArray {
    [self setIconArray];
    return iconArray;
}






@end
