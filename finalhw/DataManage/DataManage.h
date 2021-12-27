//
//  DataManage.h
//  finalhw
//
//  Created by hungyam on 2021/12/7.
//

#import <UIKit/UIKit.h>

/// Structure of user‘s personal information
@interface PersonalMes : NSObject

@property NSString *nickname;
@property UIImage *userImg;
@property NSString *username;
@property NSInteger points;
@property NSString *password;
@property NSString *phone;

@end

/// Structure of category selection button content
@interface IconType : NSObject

@property UIImage *icon;
@property NSString *label;

- (instancetype)initWithImg:(UIImage *)img label:(NSString *)label;

@end

/// Structure of account
@interface AccountType : NSObject

@property BOOL inOrOut;
@property NSString *type;
@property NSString *tips;
@property CGFloat amount;
@property NSInteger dateYear;
@property NSInteger dateMonth;
@property NSInteger dateDay;


- (instancetype)initWithType:(NSString *)type
                        tips:(NSString *)tips
                      amount:(CGFloat)amount
                    dateYear:(NSInteger)dateYear
                   dateMonth:(NSInteger)dateMonth
                     dateDay:(NSInteger)dateDay
                        kind:(BOOL)inOrOut;

@end


@interface DataManage : NSObject

+ (void)loadRequestData;

+ (BOOL)loginUser:(NSString *)username password:(NSString *)password;
+ (BOOL)signUpUser:(PersonalMes *)newUser;

+ (BOOL)addNewAccount:(AccountType *)newAccount;
+ (BOOL)loadAllAccounts;
+ (NSMutableArray *)getAllAccounts;
+ (NSMutableArray *)getAllAccountsTypeDate;

+ (bool)loadPersonalMes;
+ (BOOL)modifyPersonalMes:(PersonalMes *)newObject;
+ (PersonalMes *)getPersonalMes;

+ (NSMutableArray *)getIconArray:(BOOL)type;
+ (UIImage *)getIconByLabel:(NSString *)str;

@end
