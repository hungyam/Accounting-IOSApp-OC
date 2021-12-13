//
//  NewEntryVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "NewEntryVC.h"
#import "DataManage.h"

#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define SubWper *_subArea.bounds.size.width/100
#define SubHper *_subArea.bounds.size.height/100
#define BackColor [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:105/255.0 blue:123/255.0 alpha:1]


@interface NewEntryVC ()

@property(nonatomic, strong) NSMutableArray *listArr;
@property(nonatomic, strong) UIButton *chooseone;
@property(nonatomic, strong) UICollectionView *collect;

@property(nonatomic, strong) UIView *subArea;
    @property(nonatomic, strong) UIDatePicker *datelist;
    @property(nonatomic, strong) UILabel *datelabel;
    @property(nonatomic, strong) UITextField *tipsText;
    @property(nonatomic, strong) UIImageView *bigImg;

@end

@implementation NewEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.collect];
    self.title = @"添加新纪录";
}

- (NSMutableArray *)listArr {
    if (_listArr == nil) {
        _listArr = [DataManage getIconArray];
    }
    return _listArr;
}

- (UICollectionView *)collect {
    if (_collect == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(3 Wper, 0, 94 Wper, 100 Hper) collectionViewLayout:layout];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = (id) self;
        _collect.dataSource = (id) self;
        [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    }
    return _collect;
}

- (UIView *)subArea {
    if (_subArea == nil) {
        _subArea = [[UIView alloc] initWithFrame:CGRectMake(0, 60 Hper, 100 Wper, 40 Hper)];
        _subArea.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];

        UIButton *submitbutton = [[UIButton alloc] initWithFrame:CGRectMake(75 SubWper, 3 SubHper, 12 SubHper, 12 SubHper)];
        [submitbutton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        submitbutton.layer.shadowColor = [UIColor colorWithRed:40/255.0 green:182/255.0 blue:120/255.0 alpha:1].CGColor;
        submitbutton.layer.shadowOffset = CGSizeMake(0, 0);
        submitbutton.layer.shadowOpacity = 0.8;
        submitbutton.layer.shadowRadius = 4;
        [submitbutton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];

        UIButton *quitbutton = [[UIButton alloc] initWithFrame:CGRectMake(87 SubWper, 3 SubHper, 12 SubHper, 12 SubHper)];
        [quitbutton setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        quitbutton.layer.shadowColor = [UIColor colorWithRed:243/255.0 green:104/255.0 blue:104/255.0 alpha:1].CGColor;
        quitbutton.layer.shadowOffset = CGSizeMake(0, 0);
        quitbutton.layer.shadowOpacity = 0.8;
        quitbutton.layer.shadowRadius = 4;
        [quitbutton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchDown];

        [_subArea addSubview:submitbutton];
        [_subArea addSubview:quitbutton];
        [_subArea addSubview:self.tipsText];
        [_subArea addSubview:self.bigImg];
    }
    return _subArea;
}

#pragma mark - SubArea Views

- (UITextField *)tipsText {
    if (_tipsText == nil) {
        _tipsText = [[UITextField alloc] initWithFrame:CGRectMake(3 SubWper, 3 SubHper, 69 SubWper, 12 SubHper)];
        _tipsText.placeholder = @"备注";
        _tipsText.layer.cornerRadius = 18;
        _tipsText.backgroundColor = BackColor;
        _tipsText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4 SubWper, 12 SubHper)];
        _tipsText.leftViewMode = UITextFieldViewModeAlways;
        _tipsText.tintColor = [UIColor grayColor];
    }
    return _tipsText;
}

- (UIImageView *)bigImg {
    if (_bigImg == nil) {
        _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(20 SubWper, 25 SubHper, 30 SubWper, 30 SubWper)];
        CGAffineTransform rotate = CGAffineTransformMakeRotation(number / 180.0 * M_PI );
        [viewDemo setTransform:rotate];
    }
    return _bigImg;
}

- (UILabel *)datelabel {
    if (_datelabel == nil) {
        _datelabel = [[UILabel alloc] initWithFrame:CGRectMake(_subArea.frame.size.width / 4, _subArea.frame.size.height / 6, _subArea.frame.size.width * 3 / 4, _subArea.frame.size.height / 6)];

        _datelabel.textColor = [UIColor blackColor];
        _datelabel.textAlignment = NSTextAlignmentCenter;
        [self resetdatelabel];
    }
    return _datelabel;
}

- (UIDatePicker *)datelist {
    if (_datelist == nil) {
        _datelist = [[UIDatePicker alloc] init];
        //设置本地化支持的语言（在此是中文)
        _datelist.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        _datelist.datePickerMode = UIDatePickerModeDate;
        [_datelist setDate:[NSDate date] animated:YES];
        _datelist.preferredDatePickerStyle = UIDatePickerStyleWheels;
        [_datelist setFrame:CGRectMake(0, 0, 100 Wper, 40 Hper)];

        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:3];//设置最大时间为：当前时间推后十年
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [comps setYear:-3];//设置最小时间为：当前时间前推十年
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [_datelist setMaximumDate:maxDate];
        [_datelist setMinimumDate:minDate];
    }
    return _datelist;
}

- (void)resetdatelabel {

    NSDate *theDate = self.datelist.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    self.datelabel.text = [dateFormatter stringFromDate:theDate];
}

- (void)submit {

}

- (void)reset {
    if (self.chooseone != nil) {
        self.chooseone.layer.shadowRadius = 0;
        self.chooseone.backgroundColor = BackColor;
        self.chooseone.layer.shadowOpacity = 0;
    }
    self.collect.frame = CGRectMake(3 Wper, 0, 94 Wper, 100 Hper);
    [self.subArea removeFromSuperview];
}

- (void)selectdate {
    [self resetdatelabel];
}


- (NSDateComponents *)getNowdate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

#pragma mark end -

#pragma mark - UICollectionVC DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UIButton *button = [self seticonbutton:indexPath.item];
    [cell addSubview:button];
    return cell;
}

- (UIButton *)seticonbutton:(NSInteger)index {
    UIImage *img = ((IconType *) self.listArr[index]).icon;
    NSString *name = ((IconType *) self.listArr[index]).label;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 94 Wper / 4 - 5, 94 Wper / 4 - 5)];
    button.tag = index;
    button.backgroundColor = BackColor;
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 20;
    button.titleLabel.font = [UIFont fontWithName:@"Hiragino Sans" size:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(3 Wper, 6 Wper, 9 Wper, 6 Wper)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height + 15, -button.imageView.frame.size.width, 0, 0)];
    [button addTarget:self action:@selector(inputdata:) forControlEvents:UIControlEventTouchDown];
    button.layer.shadowColor = [UIColor whiteColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 0);
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowRadius = 0.0;
    return button;
}

- (void)inputdata:(id)sender {
    if (self.chooseone != nil) {
        self.chooseone.layer.shadowRadius = 0;
        self.chooseone.backgroundColor = BackColor;
        self.chooseone.layer.shadowOpacity = 0;
    }
    UIButton *button = (UIButton *) sender;
    self.chooseone = button;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.chooseone.layer.shadowColor = [UIColor grayColor].CGColor;
                         self.chooseone.layer.shadowOffset = CGSizeMake(1, 1);
                         self.chooseone.layer.shadowOpacity = 0.2;
                         self.chooseone.layer.shadowRadius = 6;
                         self.chooseone.backgroundColor = [UIColor whiteColor];
                         self.collect.frame = CGRectMake(3 Wper, 0, 94 Wper, 60 Hper);
                         [self.view addSubview:self.subArea];
                     }
                     completion:nil];
    self.bigImg.image = ((IconType *) self.listArr[(NSUInteger) self.chooseone.tag]).icon;
}

#pragma mark - UICollectionVC Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(94 Wper / 4 - 5, 94 Wper / 4 - 5);
}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
@end
