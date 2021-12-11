//
//  DataManage.m
//  finalhw
//
//  Created by hungyam on 2021/12/7.
//

#import "DataManage.h"

@implementation PersonalMes

@end

@implementation Entry

- (instancetype)initWithIcon:(UIImage *)icon
                    iconName:(NSString *)iconName
                 description:(NSString *)description
                        cost:(CGFloat)cost
                    moreText:(NSString *)moreText
                  morePhotos:(NSMutableArray *)morePhotos
                    dateYear:(NSInteger)dateYear
                   dateMonth:(NSInteger)dateMonth
                     dateDay:(NSInteger)dateDay
                    dateHour:(NSInteger)dateHour
                  dateMinute:(NSInteger)dateMinute {
    self.icon = icon;
    self.iconName = iconName;
    self.description = description;
    self.moreText = moreText;
    self.morePhotos = morePhotos;
    self.dateYear = dateYear;
    self.dateMonth = dateMonth;
    self.dateDay = dateDay;
    self.dateHour = dateHour;
    self.dateMonth = dateMinute;
    return self;
}

@end

@implementation IconType

- (instancetype)initWithImg:(UIImage *)img label:(NSString *)label {
    self.icon = img;
    self.label = label;
    return self;
}

@end

@implementation AccountType

- (instancetype)initWithType:(NSString *)type
                        tips:(NSString *)tips
                      amount:(CGFloat)amount
                    dateYear:(NSInteger)dateYear
                   dateMonth:(NSInteger)dateMonth
                     dateDay:(NSInteger)dateDay
                    dateHour:(NSInteger)dateHour
                  dateMinute:(NSInteger)dateMinute {
    self.type = type;
    self.tips = tips;
    self.amount = amount;
    self.dateYear = dateYear;
    self.dateMonth = dateMonth;
    self.dateDay = dateDay;
    self.dateHour = dateHour;
    self.dateMonth = dateMinute;
    return self;
}

@end

static NSMutableArray *iconArray;
static PersonalMes *userInformation;
static NSMutableArray *allAccounts;

@interface DataManage ()


@end

@implementation DataManage

+ (void)loadRequestData {
    [self loadIconArray];
    [self loadPersonalMes];
    [self loadAllAccounts];
}

#pragma mark - Login Interface

/// If username and password is accepted RETURN YES
/// Otherwise RETURN NO
/// @param username username
/// @param password password
+ (BOOL)loginUser:(NSString *)username password:(NSString *)password {
    /*
     Request:
     {
         "username": "ppss99",
         "password": "dolore"
     }
     Response:
     {
       "status": true
     }
     */
    if (YES/* accept */) {
        return YES;
    }
    return NO;
}

#pragma mark - SignUp Interface

/// If username is accepted RETURN YES
/// @param newUser new user's information
+ (BOOL)signUpUser:(PersonalMes *)newUser {
    /*
     Request:
     {
         "nickname": "zhuping",
         "username": "zhuping123",
         "phone": "12345678910",
         "password": "dolore"
     }
     Response:
     {
         "status": true
     }
     */
    
    if (YES/* accept */) {
        return YES;
    }
    return NO;
}

#pragma mark - User Information Interface
/// Load user's information
+ (void)loadPersonalMes {
    userInformation =  [[PersonalMes alloc]init];
    userInformation.username = @"HungyamHui0530";
    userInformation.points = 233;
    userInformation.nickname = @"Hungyam";
    userInformation.userImg = [UIImage imageNamed:@"userImg.png"];
    userInformation.password = @"xhx0530";
    userInformation.phone = @"18350507093";
    /*
     Request:
     {
         "username": "hinn11"
     }
     Response:
     {
         "nickname": "冯丽",
         "points": 25,
         "phone": "18174847183"
     }
     */
    
}

/// Modify user's information
/// @param newObject new user's information
+ (BOOL)modifyPersonalMes:(PersonalMes *)newObject {
    userInformation = newObject;
    /*
     Request:
     {
         "nickname": "zhuping",
         "username": "zhuping123",
         "phone": "12345678910",
         "password": "dolore",
     }
     Response:
     {
         "status": true
     }
     */
    
    if (YES/* accept */) {
        userInformation = newObject;
        return YES;
    }
    return NO;
}

/// Return user's information
+ (PersonalMes *)getPersonalMes {
    return userInformation;
}

#pragma mark - Account Interface

+ (BOOL)addNewAccount:(AccountType *)newAccount addPoints:(NSUInteger)point {
//    {
//        "username": "曹静",
//        "data": {
//            "type": "veniam in",
//            "tips": "proident Duis minim",
//            "amount": 49,
//            "date": "1983-02-12 21:31"
//        },
//        "points": 92
//    }
    NSString *date = [[NSString alloc]initWithFormat:@"%4lu-%2lu-%2lu %2lu:%2lu",
                      (unsigned long)newAccount.dateYear,
                      (unsigned long)newAccount.dateMonth,
                      (unsigned long)newAccount.dateDay,
                      (unsigned long)newAccount.dateHour,
                      (unsigned long)newAccount.dateMinute
    ];
    NSLog(@"%@",date);
    userInformation.points += point;
    /*
     Get from API
     */
    
    return YES;
}

/// Load all of accounts
+ (BOOL)loadAllAccounts {
    /*
     Request:
     {
         "username": "hungyam"
     }
     Response:
     {
         "status": true,
         "data": [
             {
                 "id": 19,
                 "type": "food",
                 "tips": "aliqua nulla sunt",
                 "amount": 16,
                 "date": "1977-07-29 21:30"
             },
             {
                 "id": 38,
                 "type": "play",
                 "tips": "in Duis ex ad pariatur",
                 "amount": 82,
                 "date": "1982-12-09 10:01"
             }
         ]
     }
     */
    
    allAccounts = [[NSMutableArray alloc]init];
    /*
     Testing Data
     */
    [allAccounts addObject:[[AccountType alloc] initWithType:@"交通" tips:@"fhsafjk" amount:10.5 dateYear:2021 dateMonth:5 dateDay:30 dateHour:12 dateMinute:30]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"宠物" tips:@"dsadasd" amount:20.8 dateYear:2021 dateMonth:4 dateDay:10 dateHour:11 dateMinute:32]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"电影" tips:@"asdf" amount:9.8 dateYear:2021 dateMonth:4 dateDay:9 dateHour:12 dateMinute:45]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"理财" tips:@"csdac" amount:100.6 dateYear:2021 dateMonth:4 dateDay:8 dateHour:23 dateMinute:23]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"饰品" tips:@"adsf" amount:30 dateYear:2021 dateMonth:4 dateDay:8 dateHour:12 dateMinute:46]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"零食" tips:@"afasdf" amount:12.5 dateYear:2021 dateMonth:3 dateDay:12 dateHour:11 dateMinute:42]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"奶茶" tips:@"adfs" amount:14.4 dateYear:2021 dateMonth:3 dateDay:11 dateHour:9 dateMinute:2]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"汽车" tips:@"sdfs" amount:23.5 dateYear:2021 dateMonth:3 dateDay:1 dateHour:8 dateMinute:23]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"美容" tips:@"vsdvsd" amount:143.5 dateYear:2021 dateMonth:3 dateDay:1 dateHour:7 dateMinute:43]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"旅游" tips:@"sdfas" amount:23.5 dateYear:2021 dateMonth:3 dateDay:1 dateHour:3 dateMinute:12]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"果蔬" tips:@"bsf" amount:10.5 dateYear:2021 dateMonth:2 dateDay:25 dateHour:17 dateMinute:43]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"娱乐" tips:@"dasfs" amount:10.5 dateYear:2021 dateMonth:2 dateDay:20 dateHour:21 dateMinute:54]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"衣服" tips:@"usdnfkasf" amount:10.5 dateYear:2021 dateMonth:2 dateDay:17 dateHour:23 dateMinute:23]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"医疗" tips:@"asdfosdn" amount:10.5 dateYear:2021 dateMonth:1 dateDay:5 dateHour:8 dateMinute:34]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"网络" tips:@"dsaf" amount:10.5 dateYear:2020 dateMonth:12 dateDay:30 dateHour:18 dateMinute:51]];
    [allAccounts addObject:[[AccountType alloc] initWithType:@"文具" tips:@"fsduio" amount:10.5 dateYear:2020 dateMonth:11 dateDay:28 dateHour:9 dateMinute:31]];
    
    return YES;
}

/// Return All of accounts
+ (NSMutableArray *)getAllAccounts {
    return allAccounts;
}

#pragma mark - Category Selection Interface

/// Load the array of  icons
+ (void)loadIconArray {
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

+ (UIImage *)getIconByLabel:(NSString *)str {
    for (NSInteger i = 0; i < iconArray.count; i++) {
        if ([((IconType *)iconArray[i]).label isEqual:str]) {
            return ((IconType *)iconArray[i]).icon;
        }
    }
    return nil;
}

/// Return Icon array (type: IconType)
+ (NSMutableArray *)getIconArray {
    return iconArray;
}






@end
