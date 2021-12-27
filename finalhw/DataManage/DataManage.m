//
//  DataManage.m
//  finalhw
//
//  Created by hungyam on 2021/12/7.
//

#import <ModelIO/ModelIO.h>
#import "DataManage.h"

@implementation PersonalMes

- (instancetype)initWithNickname:(NSString *)nickname
                         userImg:(UIImage *)userImg
                         username:(NSString *)username
                         points:(NSInteger)points
                         password:(NSString *)password
                         phone:(NSString *)phone{
    self.nickname = nickname;
    self.userImg = userImg;
    self.username = username;
    self.points = points;
    self.password = password;
    self.phone = phone;
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
                        kind:(BOOL)inOrOut
{
    self.inOrOut = inOrOut;
    self.type = type;
    self.tips = tips;
    self.amount = amount;
    self.dateYear = dateYear;
    self.dateMonth = dateMonth;
    self.dateDay = dateDay;
    return self;
}

@end

static NSMutableArray *inIconArray;
static NSMutableArray *outIconArray;
static PersonalMes *userInformation;
static NSMutableArray *allAccounts;
static NSString *token;

@interface DataManage ()


@end

@implementation DataManage

+ (void)loadRequestData {
    [self loadIconArray];
}

#pragma mark - Login Interface

/// If username and password is accepted RETURN YES
/// Otherwise RETURN NO
/// @param username username
/// @param password password
+ (BOOL)loginUser:(NSString *)username password:(NSString *)password {
    /*
     Request:(json)
     {
         "username": "ppss99",
         "password": "dolore"
     }
     Response:
     {
       "status": true
     }
     */

    NSDictionary *dic = @{@"username": username, @"password": password};

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                      delegate:(id)self
                                                                 delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL *url = [NSURL URLWithString:@"http://mosad.darkyzhou.net:8888/login"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[NSJSONSerialization
            dataWithJSONObject:dic
                       options:NSJSONWritingPrettyPrinted
                         error:nil]];
    __block NSDictionary *dict;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [delegateFreeSession
            dataTaskWithRequest:urlRequest
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                  if (error == nil) {
                      dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                      NSLog(@"%@",text);
                      dispatch_semaphore_signal(signal);
                  }
              }];
    [dataTask resume];
    
    bool flag;
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if ([dict[@"code"] integerValue] == 200) {
        token = dict[@"token"];
        flag = YES;
    }else{
        flag = NO;
    }
    return flag;
}

#pragma mark - SignUp Interface

/// If username is accepted RETURN YES
/// @param newUser new user's information
+ (BOOL)signUpUser:(PersonalMes *)newUser {
    /*
     Request:(form-data)
     {
         "img": binaryFile
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
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                      delegate:(id)self
                                                                 delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL * url = [NSURL URLWithString:@"http://mosad.darkyzhou.net:8888/signup"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";
    urlRequest.allHTTPHeaderFields = @{@"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]};
    
    NSDictionary *dic = @{
        @"nickname": newUser.nickname,
        @"username": newUser.username,
        @"phone": newUser.phone,
        @"password": newUser.password
    };
    NSMutableData *postData = [[NSMutableData alloc]init];
    for (NSString *key in [dic allKeys]) {
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n", boundary, key];
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        id value = [dic objectForKey:key];
        [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSString *filename = @"img.png";
    NSString *contentType = @"image/png";
    
    NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n", boundary, @"img", filename, contentType];
    [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:UIImagePNGRepresentation(newUser.userImg)];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:postData];
    [urlRequest setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    __block NSDictionary *dict;
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"%@",text);
                dispatch_semaphore_signal(signal);
            }
    }];
    [dataTask resume];
    
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if ([dict[@"code"] intValue] == 200) {
        return YES;
    }
    return NO;
}

#pragma mark - User Information Interface
// Load user's information
+ (bool)loadPersonalMes {
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
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                      delegate:(id)self
                                                                 delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mosad.darkyzhou.net:8888/getmes?token=%@",token]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    __block NSDictionary *dict;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [delegateFreeSession
            dataTaskWithRequest:urlRequest
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                  if (error == nil) {
                      dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                      NSLog(@"%@",text);
                      dispatch_semaphore_signal(signal);
                  }
              }];
    [dataTask resume];

    
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if ([dict[@"code"] intValue] == 401) {
        return NO;
    }
    userInformation =  [[PersonalMes alloc]init];
    userInformation.username = userInformation.username;
    userInformation.points = [dict[@"points"] intValue];
    userInformation.nickname = dict[@"nickname"];
    userInformation.userImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"imgUrl"]]]];
    userInformation.password = nil;
    userInformation.phone = dict[@"phone"];
    return YES;
}

/// Modify user's information
/// @param newUser new user's information
+ (BOOL)modifyPersonalMes:(PersonalMes *)newUser {
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
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                      delegate:(id)self
                                                                 delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mosad.darkyzhou.net:8888/modify?token=%@",token]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";
    urlRequest.allHTTPHeaderFields = @{@"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]};
    
    NSDictionary *dic = @{
        @"nickname": newUser.nickname,
        @"username": newUser.username,
        @"phone": newUser.phone,
        @"password": newUser.password
    };
    NSMutableData *postData = [[NSMutableData alloc]init];
    for (NSString *key in [dic allKeys]) {
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n", boundary, key];
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        id value = [dic objectForKey:key];
        [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSString *filename = @"img.png";
    NSString *contentType = @"image/png";
    
    NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n", boundary, @"img", filename, contentType];
    [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:UIImagePNGRepresentation(newUser.userImg)];
    [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:postData];
    [urlRequest setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    __block NSDictionary *dict;
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
              dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"%@",text);
                dispatch_semaphore_signal(signal);
            }
    }];
    [dataTask resume];
    
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if ([dict[@"code"] intValue] == 200) {
        newUser.points = userInformation.points;
        userInformation = newUser;
        return YES;
    }
    return NO;
}

/// Return user's information
+ (PersonalMes *)getPersonalMes {
    return userInformation;
}

#pragma mark - Account Interface

+ (BOOL)addNewAccount:(AccountType *)newAccount {
    /*
     Request:
     {
        "username": "曹静",
        "data": {
            "type": "veniam in",
            "tips": "proident Duis minim",
            "amount": 49,
            "date": "1983-02-12 21:31"
        },
        "points": 92
     }
     Response:
     {
         "status": true
     }
     */

    NSString *date = [[NSString alloc]initWithFormat:@"%4lu-%2lu-%2lu",
                      (unsigned long)newAccount.dateYear,
                      (unsigned long)newAccount.dateMonth,
                      (unsigned long)newAccount.dateDay
    ];
    
    NSDictionary *dic = @{@"username": @"hungyam", @"type": newAccount.type, @"tips": newAccount.tips, @"amount": @(newAccount.amount), @"date": date, @"points": @(userInformation.points)};

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                      delegate:(id)self
                                                                 delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mosad.darkyzhou.net:8888/add?token=%@",token]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[NSJSONSerialization
            dataWithJSONObject:dic
                       options:NSJSONWritingPrettyPrinted
                         error:nil]];
    __block NSDictionary *dict;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [delegateFreeSession
            dataTaskWithRequest:urlRequest
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                  if (error == nil) {
                      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                      NSLog(@"%@",text);
                      dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                      dispatch_semaphore_signal(signal);
                  }
              }];
    [dataTask resume];
    
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if ([dict[@"code"] integerValue] == 200) {
        [allAccounts addObject:newAccount];
        return YES;
    }
    return NO;
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
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                      delegate:(id)self
                                                                 delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mosad.darkyzhou.net:8888/getlist?token=%@",token]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    __block NSDictionary *dict;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [delegateFreeSession
            dataTaskWithRequest:urlRequest
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                  if (error == nil) {
                      dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                      NSLog(@"%@",text);
                      dispatch_semaphore_signal(signal);
                  }
              }];
    [dataTask resume];

    
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if ([dict[@"code"] intValue] == 401) {
        return NO;
    }
    allAccounts = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < [(NSArray *)dict[@"data"] count]; i++) {
        NSString *date = dict[@"data"][i][@"date"];
        NSInteger year = [[date substringWithRange:NSMakeRange(0, 4)] intValue];
        NSInteger month = [[date substringWithRange:NSMakeRange(5, 2)] intValue];
        NSInteger day = [[date substringWithRange:NSMakeRange(8, 2)] intValue];
        AccountType *account = [[AccountType alloc]initWithType:dict[@"data"][i][@"type"]
                                                           tips:dict[@"data"][i][@"tips"]
                                                         amount:[dict[@"data"][i][@"amount"] floatValue]
                                                       dateYear:year
                                                      dateMonth:month
                                                        dateDay:day
                                                           kind:[self getTypeByLabel:dict[@"data"][i][@"type"]]
        ];
        [allAccounts addObject:account];
    }
    return YES;
}

/// Return All of accounts
+ (NSMutableArray *)getAllAccounts {
    return allAccounts;
}

+ (NSMutableArray *)getAllAccountsTypeDate {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:20];
    for (int i = 0; i < 20; i++) {
        NSMutableArray *year = [[NSMutableArray alloc] initWithCapacity:12];
        for (int j = 0; j < 12; j++) {
            NSMutableArray *month = [[NSMutableArray alloc] initWithCapacity:31];
            for (int k = 0; k < 31; k++) {
                NSMutableArray *day = [[NSMutableArray alloc] init];
                [month addObject:day];
            }
            [year addObject:month];
        }
        [arr addObject:year];
    }
    for (NSInteger i = 0; i < allAccounts.count; i++) {
        NSInteger year = ((AccountType *)allAccounts[i]).dateYear;
        NSInteger month = ((AccountType *)allAccounts[i]).dateMonth;
        NSInteger day = ((AccountType *)allAccounts[i]).dateDay;
        [arr[year-2010][month-1][day-1] addObject:allAccounts[i]];
    }
    return arr;
}

#pragma mark - Category Selection Interface

/// Load the array of  icons
+ (void)loadIconArray {
    inIconArray = [[NSMutableArray alloc]init];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"caipiao.png"] label:@"彩票"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"canyin.png"] label:@"餐饮"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"chongwu.png"] label:@"宠物"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"dianying.png"] label:@"电影"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"fangdai.png"] label:@"房贷"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"guoshu.png"] label:@"果蔬"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"jianshen.png"] label:@"健身"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"jiaotong.png"] label:@"交通"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"jiezhi.png"] label:@"饰品"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"licai.png"] label:@"理财"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"lingshi.png"] label:@"零食"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"lvyou.png"] label:@"旅游"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"meirong.png"] label:@"美容"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"muying.png"] label:@"母婴"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"naicha.png"] label:@"奶茶"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"qiche.png"] label:@"汽车"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"shejiao.png"] label:@"社交"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"shuji.png"] label:@"书籍"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"shuma.png"] label:@"数码"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"tongxun.png"] label:@"通讯"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"wangluo.png"] label:@"网络"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"wenjv.png"] label:@"文具"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"xiemao.png"] label:@"鞋帽"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yanjiu.png"] label:@"烟酒"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yifu.png"] label:@"衣服"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yiliao.png"] label:@"医疗"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yundong.png"] label:@"运动"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"yvle.png"] label:@"娱乐"]];
    [inIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"zhufang.png"] label:@"住房"]];

    outIconArray = [[NSMutableArray alloc] init];
    [outIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"fangdai.png"] label:@"工资"]];
    [outIconArray addObject:[[IconType alloc] initWithImg:[UIImage imageNamed:@"licai.png"] label:@"投资"]];
}

+ (UIImage *)getIconByLabel:(NSString *)str {
    for (NSInteger i = 0; i < inIconArray.count; i++) {
        if ([((IconType *)inIconArray[i]).label isEqual:str]) {
            return ((IconType *)inIconArray[i]).icon;
        }
    }
    for (NSInteger i = 0; i < outIconArray.count; i++) {
        if ([((IconType *)outIconArray[i]).label isEqual:str]) {
            return ((IconType *)outIconArray[i]).icon;
        }
    }
    return nil;
}

+ (BOOL)getTypeByLabel:(NSString *)str {
    for (NSInteger i = 0; i < inIconArray.count; i++) {
        if ([((IconType *)inIconArray[i]).label isEqual:str]) {
            return YES;
        }
    }
    for (NSInteger i = 0; i < outIconArray.count; i++) {
        if ([((IconType *)outIconArray[i]).label isEqual:str]) {
            return NO;
        }
    }
    return YES;
}

/// Return Icon array (type: IconType)
+ (NSMutableArray *)getIconArray:(BOOL)type {
    return type? inIconArray : outIconArray;
}






@end
