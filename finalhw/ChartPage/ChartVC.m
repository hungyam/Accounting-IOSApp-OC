//
//  ChartVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "ChartVC.h"
#import "DataManage.h"

#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ChartVC ()
@property(nonatomic, strong) NSMutableArray *maindata;
@property(nonatomic, strong) NSMutableArray *databytime;
@property(nonatomic, strong) NSMutableArray *databytype;
@property(nonatomic, strong) NSMutableArray *nameoftype;

@property(nonatomic, strong) UIScrollView *mainView;
@property(nonatomic, strong) UILabel *datePickerLabel;
@property(nonatomic, strong) UIScrollView *chartView; //图表主视图
@property(nonatomic, strong) CAShapeLayer *lineChartLayer;

@property(nonatomic, assign) int lineoffset;//横线偏移量
@property(nonatomic, assign) float ySpace;//y轴间隔
@property(nonatomic, assign) int yNum;//y轴一个间隔的数值
@property(nonatomic, assign) int xCount;//x轴的点数
@property(nonatomic, assign) float xSpace;//x轴间隔


@property(nonatomic, assign) NSInteger mode;
@property(nonatomic, assign) NSInteger inOrOut;

@property(nonatomic, strong) UIView *lineViewinUse;

@property(nonatomic, strong) UILabel *labelinUse;
@property(nonatomic, strong) CAShapeLayer *labelline;

@property(nonatomic, strong) UIButton *buttoninUse;

@property(nonatomic, strong) SubViewPieVC *showPieVC;

@property(nonatomic, strong) UIView *classifyList;

@property(nonatomic, strong) UIButton *showPieButton;
@property(nonatomic, strong) UIButton *topSegmentLeft;
@property(nonatomic, strong) UIButton *topSegmentRight;


@property(nonatomic, strong) UIPickerView *pickerViewOfWeek;
@property(nonatomic, strong) UIPickerView *pickerViewOfMonth;
@property(nonatomic, strong) UIPickerView *pickerViewOfYear;
@property(nonatomic, assign) NSInteger firstYear;
@property(nonatomic, assign) NSInteger lastYear;

@property(strong, nonatomic) UITableView*list;
@end

@implementation ChartVC
- (void)renewdata {
    self.maindata = [DataManage getAllAccounts];

    for (NSInteger i = 0; i < self.maindata.count; i++) {
        AccountType *account = (AccountType *) [self.maindata objectAtIndex:i];
        NSInteger year = account.dateYear;

        if (i == 0) {
            self.firstYear = year;
            self.lastYear = year;
        } else {
            if (self.firstYear > year) {
                self.firstYear = year;
            }
            if (self.lastYear < year) {
                self.lastYear = year;
            }
        }
    }
    [self.pickerViewOfYear reloadAllComponents];
    [self.pickerViewOfMonth reloadAllComponents];
    [self.pickerViewOfWeek reloadAllComponents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renewdata];
    self.inOrOut=1;
    self.view.backgroundColor = [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1];
    [self.view addSubview:self.mainView];
    [self setButtonLine];
    UIBarButtonItem *btnItemLeft = [[UIBarButtonItem alloc] initWithCustomView:self.topSegmentLeft];
    UIBarButtonItem *btnItemRight = [[UIBarButtonItem alloc] initWithCustomView:self.topSegmentRight];
    self.navigationItem.leftBarButtonItems = @[btnItemLeft, btnItemRight];
}

- (void)viewWillAppear:(BOOL)animated {
    [self renewdata];
    [self refresh];
}

- (void)refresh {
    if (self.labelinUse != nil) {
        [self.labelinUse removeFromSuperview];
        self.labelinUse = nil;
    }
    if (self.labelline != nil) {
        [self.labelline removeFromSuperlayer];
        self.labelline = nil;
    }
    [self refreshdata];
    [self beginDrawline];
    [self.list reloadData];
    [self.showPieVC refreshDataOfPie:self.databytype andNameofPie:self.nameoftype];
}

- (NSMutableArray *)databytime {
    if (_databytime == nil) {
        _databytime = [[NSMutableArray alloc] init];
    }
    return _databytime;
}

- (NSMutableArray *)databytype {
    if (_databytype == nil) {
        _databytype = [[NSMutableArray alloc] init];
    }
    return _databytype;
}

- (NSMutableArray *)maindata {
    if (_maindata == nil) {
        _maindata = [[NSMutableArray alloc] init];
    }
    return _maindata;
}

- (NSMutableArray *)nameoftype {
    if (_nameoftype == nil) {
        _nameoftype = [[NSMutableArray alloc] init];
    }
    return _nameoftype;
}

- (UIScrollView *)mainView {
    if (_mainView == nil) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 100 Wper, 100 Hper)];
        _mainView.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:self.chartView];
        [_mainView addSubview:self.classifyList];
        [_mainView addSubview:self.datePickerLabel];
        _mainView.contentSize = CGSizeMake(100 Wper, 105 Hper);
        [_mainView setShowsVerticalScrollIndicator:NO];
    }
    return _mainView;
}


#pragma mark - Setting selecting button - in, out, week, month, year

- (UIButton *)topSegmentLeft {
    if (_topSegmentLeft == nil) {
        _topSegmentLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15 Wper, 3 Hper)];
        _topSegmentLeft.tag = 1;
        _topSegmentLeft.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:114 / 255.0 alpha:1];
        _topSegmentLeft.layer.cornerRadius = 10;
        _topSegmentLeft.layer.shadowColor = [UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:114 / 255.0 alpha:1].CGColor;
        _topSegmentLeft.layer.shadowOffset = CGSizeMake(0, 0);
        _topSegmentLeft.layer.shadowRadius = 10;
        _topSegmentLeft.layer.shadowOpacity = 0.7;
        [_topSegmentLeft setTitle:@"支出" forState:UIControlStateNormal];
        [_topSegmentLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_topSegmentLeft addTarget:self action:@selector(topSegmentSelected:) forControlEvents:UIControlEventTouchDown];
    }
    return _topSegmentLeft;
}

- (UIButton *)topSegmentRight {
    if (_topSegmentRight == nil) {
        _topSegmentRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15 Wper, 3 Hper)];
        _topSegmentRight.tag = 2;
        _topSegmentRight.backgroundColor = [UIColor whiteColor];
        _topSegmentRight.layer.cornerRadius = 10;
        _topSegmentRight.layer.shadowColor = [UIColor grayColor].CGColor;
        _topSegmentRight.layer.shadowOffset = CGSizeMake(0, 0);
        _topSegmentRight.layer.shadowRadius = 10;
        _topSegmentRight.layer.shadowOpacity = 0.1;
        [_topSegmentRight setTitle:@"收入" forState:UIControlStateNormal];
        [_topSegmentRight setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_topSegmentRight addTarget:self action:@selector(topSegmentSelected:) forControlEvents:UIControlEventTouchDown];
    }
    return _topSegmentRight;
}

- (void)topSegmentSelected:(id)sender {
    UIButton *control = (UIButton *) sender;
    if (control.tag == 1) {
        if (self.inOrOut == 0) {
            self.inOrOut = 1;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.topSegmentLeft.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:114 / 255.0 alpha:1];
                                 self.topSegmentLeft.layer.shadowColor = [UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:114 / 255.0 alpha:1].CGColor;
                                 self.topSegmentLeft.layer.shadowOffset = CGSizeMake(0, 0);
                                 self.topSegmentLeft.layer.shadowRadius = 10;
                                 self.topSegmentLeft.layer.shadowOpacity = 0.7;
                                 [self.topSegmentLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                                 self.topSegmentRight.backgroundColor = [UIColor whiteColor];
                                 self.topSegmentRight.layer.shadowColor = [UIColor grayColor].CGColor;
                                 self.topSegmentRight.layer.shadowOffset = CGSizeMake(0, 0);
                                 self.topSegmentRight.layer.shadowRadius = 10;
                                 self.topSegmentRight.layer.shadowOpacity = 0.1;
                                 [self.topSegmentRight setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                             }
                             completion:nil];
            [self refresh];
        }
    } else {
        if (self.inOrOut == 1) {
            self.inOrOut = 0;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.topSegmentRight.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:114 / 255.0 alpha:1];
                                 self.topSegmentRight.layer.shadowColor = [UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:114 / 255.0 alpha:1].CGColor;
                                 self.topSegmentRight.layer.shadowOffset = CGSizeMake(0, 0);
                                 self.topSegmentRight.layer.shadowRadius = 10;
                                 self.topSegmentRight.layer.shadowOpacity = 0.7;
                                 [self.topSegmentRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                                 self.topSegmentLeft.backgroundColor = [UIColor whiteColor];
                                 self.topSegmentLeft.layer.shadowColor = [UIColor grayColor].CGColor;
                                 self.topSegmentLeft.layer.shadowOffset = CGSizeMake(0, 0);
                                 self.topSegmentLeft.layer.shadowRadius = 10;
                                 self.topSegmentLeft.layer.shadowOpacity = 0.1;
                                 [self.topSegmentLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                             }
                             completion:nil];
            [self refresh];
        }
    }
}

- (void)setButtonLine {
    UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(7 Wper, 2 Hper, 26 Wper, 4 Hper)];
    b1.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:229 / 255.0 blue:230 / 255.0 alpha:1];
    b1.tag = 1;
    b1.layer.borderWidth = 1;
    b1.layer.borderColor = [UIColor colorWithRed:255 / 255.0 green:88 / 255.0 blue:93 / 255.0 alpha:1].CGColor;
    b1.layer.cornerRadius = 15;
    b1.layer.shadowColor = [UIColor colorWithRed:255 / 255.0 green:88 / 255.0 blue:93 / 255.0 alpha:1].CGColor;
    b1.layer.shadowOffset = CGSizeMake(0, 0);
    b1.layer.shadowRadius = 6;
    b1.layer.shadowOpacity = 0.5;
    [b1 setTitle:@"周" forState:UIControlStateNormal];
    [b1 setTitleColor:[UIColor colorWithRed:255 / 255.0 green:88 / 255.0 blue:93 / 255.0 alpha:1] forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(timebuttonfunction:) forControlEvents:UIControlEventTouchDown];

    UIButton *b2 = [[UIButton alloc] initWithFrame:CGRectMake(37 Wper, 2 Hper, 26 Wper, 4 Hper)];
    b2.backgroundColor = [UIColor whiteColor];
    b2.tag = 2;
    b2.layer.cornerRadius = 15;
    b2.layer.shadowColor = [UIColor grayColor].CGColor;
    b2.layer.shadowOffset = CGSizeMake(0, 0);
    b2.layer.shadowRadius = 10;
    b2.layer.shadowOpacity = 0.1;
    [b2 setTitle:@"月" forState:UIControlStateNormal];
    [b2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(timebuttonfunction:) forControlEvents:UIControlEventTouchDown];

    UIButton *b3 = [[UIButton alloc] initWithFrame:CGRectMake(67 Wper, 2 Hper, 26 Wper, 4 Hper)];
    b3.backgroundColor = [UIColor whiteColor];
    b3.tag = 3;
    b3.layer.cornerRadius = 15;
    b3.layer.shadowColor = [UIColor grayColor].CGColor;
    b3.layer.shadowOffset = CGSizeMake(0, 0);
    b3.layer.shadowRadius = 10;
    b3.layer.shadowOpacity = 0.1;
    [b3 setTitle:@"年" forState:UIControlStateNormal];
    [b3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [b3 addTarget:self action:@selector(timebuttonfunction:) forControlEvents:UIControlEventTouchDown];

    [self.mainView addSubview:b1];
    [self.mainView addSubview:b2];
    [self.mainView addSubview:b3];
    [self timebuttonfunction:b1];
}

- (void)timebuttonfunction:(UIButton *)btn {
    if (btn == self.buttoninUse) {
        return;
    }
    self.mode = btn.tag;
    [self refresh];
    [self.pickerViewOfWeek removeFromSuperview];
    [self.pickerViewOfMonth removeFromSuperview];
    [self.pickerViewOfYear removeFromSuperview];
    if (btn.tag == 1) {
        [self.mainView addSubview:self.pickerViewOfWeek];
    } else if (btn.tag == 2) {
        [self.mainView addSubview:self.pickerViewOfMonth];
    } else {
        [self.mainView addSubview:self.pickerViewOfYear];
    }
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         btn.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:229 / 255.0 blue:230 / 255.0 alpha:1];
                         btn.layer.borderWidth = 1;
                         btn.layer.borderColor = [UIColor colorWithRed:255 / 255.0 green:88 / 255.0 blue:93 / 255.0 alpha:1].CGColor;
                         btn.layer.shadowColor = [UIColor colorWithRed:255 / 255.0 green:88 / 255.0 blue:93 / 255.0 alpha:1].CGColor;
                         btn.layer.shadowOffset = CGSizeMake(0, 0);
                         btn.layer.shadowRadius = 6;
                         btn.layer.shadowOpacity = 0.5;
                         [btn setTitleColor:[UIColor colorWithRed:255 / 255.0 green:88 / 255.0 blue:93 / 255.0 alpha:1] forState:UIControlStateNormal];

                         self.buttoninUse.backgroundColor = [UIColor whiteColor];
                         self.buttoninUse.layer.borderWidth = 0;
                         self.buttoninUse.layer.shadowColor = [UIColor grayColor].CGColor;
                         self.buttoninUse.layer.shadowOffset = CGSizeMake(0, 0);
                         self.buttoninUse.layer.shadowRadius = 10;
                         self.buttoninUse.layer.shadowOpacity = 0.1;
                         [self.buttoninUse setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                     }
                     completion:nil];
    self.buttoninUse = btn;
}

- (bool)isRun:(NSInteger)year {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return true;
    }
    return false;
}

- (int)getdaysin:(NSInteger)year and:(NSInteger)month {
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        return 31;
    } else if (month == 2) {
        if ([self isRun:year]) {
            return 29;
        }
        return 28;
    }
    return 30;
}

- (int)setyNumwithmax:(float)max {
    int tmp = (int) max / 6;
    if (tmp * 6 < max) {
        return tmp + 1;
    }
    return tmp;
}

- (NSInteger)weekdateinyear:(NSInteger)y month:(NSInteger)m day:(NSInteger)d {
    if (m == 1 || m == 2) {
        m += 12;
        y--;
    }
    int week = (d + 2 * m + 3 * (m + 1) / 5 + y + y / 4 - y / 100 + y / 400) % 7;
    return week + 1;
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

#pragma mark - main part

- (UIScrollView *)chartView {
    if (_chartView == nil) {
        _chartView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 Wper, 5 Hper, 100 Wper, 30 Hper)];
        _chartView.backgroundColor = [UIColor clearColor];
        _chartView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_chartView setShowsHorizontalScrollIndicator:NO];
        self.lineoffset = 30;
        self.ySpace = (self.chartView.frame.size.height) / 10;
    }
    return _chartView;
}

#pragma mark - Set DatePicker

- (UILabel *)datePickerLabel {
    if (_datePickerLabel == nil) {
        _datePickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 Wper, 32 Hper, 20 Wper, 6.5 Hper)];
        _datePickerLabel.text = @"日期";
//        _datePickerLabel
    }
    return _datePickerLabel;
}

- (UIPickerView *)pickerViewOfYear {
    if (_pickerViewOfYear == nil) {
        _pickerViewOfYear = [[UIPickerView alloc] initWithFrame:CGRectMake(15 Wper, 32 Hper, 80 Wper, 7 Hper)];
        _pickerViewOfYear.delegate = (id) self;
        _pickerViewOfYear.dataSource = (id) self;
        _pickerViewOfYear.backgroundColor = [UIColor clearColor];
        _pickerViewOfYear.tag = 3;
        NSInteger nowyear = [[self getNowdate] year];
        NSInteger chooseyear;
        if (self.firstYear <= nowyear && self.lastYear >= nowyear) {
            chooseyear = nowyear;
        } else {
            if (nowyear > self.lastYear) {
                chooseyear = self.lastYear;
            } else {
                chooseyear = self.firstYear;
            }
        }
        [_pickerViewOfYear selectRow:chooseyear - self.firstYear inComponent:0 animated:false];
    }
    return _pickerViewOfYear;
}

- (UIPickerView *)pickerViewOfMonth {
    if (_pickerViewOfMonth == nil) {
        _pickerViewOfMonth = [[UIPickerView alloc] initWithFrame:CGRectMake(15 Wper, 32 Hper, 80 Wper, 7 Hper)];
        _pickerViewOfMonth.delegate = (id) self;
        _pickerViewOfMonth.dataSource = (id) self;
        _pickerViewOfMonth.backgroundColor = [UIColor clearColor];
        _pickerViewOfMonth.tag = 2;

        NSInteger nowyear = [[self getNowdate] year];
        NSInteger chooseyear;
        if (self.firstYear <= nowyear && self.lastYear >= nowyear) {
            chooseyear = nowyear;
            NSInteger month = [[self getNowdate] month];
            [_pickerViewOfMonth selectRow:month - 1 inComponent:1 animated:false];
        } else {
            if (nowyear > self.lastYear) {
                chooseyear = self.lastYear;
            } else {
                chooseyear = self.firstYear;
            }
        }
        [_pickerViewOfMonth selectRow:chooseyear - self.firstYear inComponent:0 animated:false];
    }
    return _pickerViewOfMonth;
}


- (UIPickerView *)pickerViewOfWeek {
    if (_pickerViewOfWeek == nil) {
        _pickerViewOfWeek = [[UIPickerView alloc] initWithFrame:CGRectMake(15 Wper, 32 Hper, 80 Wper, 7 Hper)];
        _pickerViewOfWeek.delegate = (id) self;
        _pickerViewOfWeek.dataSource = (id) self;
        _pickerViewOfWeek.backgroundColor = [UIColor clearColor];
        _pickerViewOfWeek.tag = 1;
        NSInteger nowyear = [[self getNowdate] year];
        NSInteger chooseyear;
        if (self.firstYear <= nowyear && self.lastYear >= nowyear) {
            chooseyear = nowyear;
            NSInteger day = [[self getNowdate] day];
            NSInteger month = [[self getNowdate] month];

            for (NSInteger i = 0; i < 54; i++) {
                NSInteger tmp = [self ismonth:month day:day inWeekNo:i ofyear:chooseyear];
                if (tmp > -1) {
                    [_pickerViewOfWeek selectRow:i inComponent:1 animated:false];
                    break;
                }
            }
        } else {
            if (nowyear > self.lastYear) {
                chooseyear = self.lastYear;
            } else {
                chooseyear = self.firstYear;
            }
        }
        [_pickerViewOfWeek selectRow:chooseyear - self.firstYear inComponent:0 animated:false];
    }
    return _pickerViewOfWeek;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 3) {
        return 1;
    }
    return 2;
}

//设置指定列包含的项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.lastYear - self.firstYear + 1;
    }
    if (pickerView.tag == 1) {
        NSInteger chooseyear = [self.pickerViewOfWeek selectedRowInComponent:0] + self.firstYear;
        NSInteger weekdate = [self weekdateinyear:chooseyear month:1 day:1];
        if ([self isRun:chooseyear] && (weekdate == 7 || weekdate == 6)) {
            return 53;
        } else if (weekdate == 7) {
            return 53;
        }
        return 52;
    }
    return 12;
}


//设置每个选项显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%ld", self.firstYear + row];
    }
    if (pickerView.tag == 1) {
        NSInteger chooseyear = [self.pickerViewOfWeek selectedRowInComponent:0] + self.firstYear;
        return [self gettheNo:row weekin:chooseyear];
    }
    return [NSString stringWithFormat:@"%ld", row + 1];
}

- (NSString *)gettheNo:(NSInteger)num weekin:(NSInteger)year {
    NSInteger basedate = [self begindayin:year];
    NSInteger beginday = basedate + 7 * num, endday = beginday + 6;
    NSString *begin = [self dateof:beginday daysinyear:year];
    NSString *end = [self dateof:endday daysinyear:year];
    return [NSString stringWithFormat:@"%@-%@", begin, end];
}

- (NSInteger)ismonth:(NSInteger)month day:(NSInteger)day inWeekNo:(NSInteger)num ofyear:(NSInteger)year {
    NSInteger basedate = [self begindayin:year];
    NSInteger beginday = basedate + 7 * num, endday = beginday + 6;
    NSInteger daysinmonth[13] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 666};
    if ([self isRun:year]) {
        daysinmonth[1]++;
    }
    NSInteger days = day;
    for (NSInteger i = 0; i < month - 1; i++) {
        days += daysinmonth[i];
    }
    if (days >= beginday && days <= endday) {
        return days - beginday;
    }
    return -1;
}

- (NSString *)dateof:(NSInteger)day daysinyear:(NSInteger)year {
    NSInteger daysinmonth[13] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 666};
    NSInteger month = 1;
    if ([self isRun:year]) {
        daysinmonth[1]++;
    }
    while (day > daysinmonth[month - 1]) {
        day -= daysinmonth[month - 1];
        month++;
        if (month == 13) {
            month -= 12;
        }
    }
    return [NSString stringWithFormat:@"%ld.%ld", month, day];
}

- (NSInteger)begindayin:(NSInteger)year {
    return 8 - [self weekdateinyear:year month:1 day:1];
}

//用户进行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0 && pickerView.tag == 1) {
        [pickerView reloadAllComponents];
    }
    [self refresh];
}

#pragma mark end -


- (UIView *)classifyList {
    if (_classifyList == nil) {
        _classifyList = [[UIView alloc] initWithFrame:CGRectMake(4 Wper, 42 Hper, 92 Wper, 60 Hper)];
        _classifyList.backgroundColor = [UIColor whiteColor];
        _classifyList.layer.cornerRadius = 15;
        _classifyList.layer.shadowColor = [UIColor grayColor].CGColor;
        _classifyList.layer.shadowOffset = CGSizeMake(0, 0);
        _classifyList.layer.shadowRadius = 10;
        _classifyList.layer.shadowOpacity = 0.1;
        [_classifyList addSubview:self.showPieButton];
        [_classifyList addSubview:self.list];
    }
    return _classifyList;
}



- (UIButton *)showPieButton {
    if (_showPieButton == nil) {
        _showPieButton = [[UIButton alloc] initWithFrame:CGRectMake(66 Wper, 2 Hper, 20 Wper, 5 Hper)];
        _showPieButton.backgroundColor = [UIColor colorWithRed:170/250.0 green:216/255.0 blue:219/255.0 alpha:1];
        _showPieButton.layer.cornerRadius = 15;
        [_showPieButton setTitle:@"饼图" forState:UIControlStateNormal];
        [_showPieButton addTarget:self action:@selector(showPieButtonAction) forControlEvents:UIControlEventTouchDown];
    }
    return _showPieButton;
}
- (void)showPieButtonAction {
    [self presentViewController:self.showPieVC
                       animated:YES
                     completion:^{
                         [self.showPieVC beginDrawPie];
    }];
}

- (SubViewPieVC*)showPieVC {
    if (_showPieVC == nil) {
        _showPieVC = [[SubViewPieVC alloc] init];
       // UITapGestureRecognizer *uiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPieVC)];
        //_showPieVC.view.userInteractionEnabled = YES;
        //[_showPieVC.view addGestureRecognizer:uiTap];
    }
    return _showPieVC;
}


#pragma mark - base data of pic and list


- (void)refreshdata {
    [self.databytime removeAllObjects];
    [self.databytype removeAllObjects];
    [self.nameoftype removeAllObjects];
    NSInteger year;
    NSInteger weeknum = [self.pickerViewOfWeek selectedRowInComponent:1];
    NSInteger month = [self.pickerViewOfMonth selectedRowInComponent:1] + 1;
    if (self.mode == 1) {
        year = [self.pickerViewOfWeek selectedRowInComponent:0] + self.firstYear;
    } else if (self.mode == 2) {
        year = [self.pickerViewOfMonth selectedRowInComponent:0] + self.firstYear;
    } else {
        year = [self.pickerViewOfYear selectedRowInComponent:0] + self.firstYear;
    }
    float max = 0;
    float tmp[32] = {0};
    for (NSInteger i = 0; i < self.maindata.count; i++) {
        AccountType *account = (AccountType *) [self.maindata objectAtIndex:i];
        if (account.dateYear != year) {
            continue;
        }
        if (self.inOrOut == 0 && account.inOrOut) {
            continue;
        } else if (self.inOrOut == 1 && !account.inOrOut) {
            continue;
        }
        if (self.mode == 1) {
            NSInteger weekday = [self ismonth:account.dateMonth day:account.dateDay inWeekNo:weeknum ofyear:year];
            if (weekday > -1) {
                [self addindatabytype:account];
                tmp[weekday] += account.amount;
                if (max < tmp[weekday]) {
                    max = tmp[weekday];
                }
            }
        } else if (self.mode == 2) {
            if (account.dateMonth == month) {
                [self addindatabytype:account];
                tmp[account.dateDay - 1] += account.amount;
                if (max < tmp[account.dateDay - 1]) {
                    max = tmp[account.dateDay - 1];
                }
            }

        } else {
            [self addindatabytype:account];
            tmp[account.dateMonth - 1] += account.amount;
            if (max < tmp[account.dateMonth - 1]) {
                max = tmp[account.dateMonth - 1];
            }
        }
    }
    for (NSInteger i = 0; i < 32; i++) {
        [self.databytime addObject:[[NSNumber alloc] initWithFloat:tmp[i]]];
    }
    self.yNum = [self setyNumwithmax:max];
}

- (void)addindatabytype:(AccountType *)account {
    for (NSInteger i = 0; i < self.nameoftype.count; i++) {
        NSString *typename = [self.nameoftype objectAtIndex:i];
        if ([typename isEqual:account.type]) {
            float tmp = [[self.databytype objectAtIndex:i] floatValue];
            tmp += account.amount;
            [self.databytype replaceObjectAtIndex:i withObject:[[NSNumber alloc] initWithFloat:tmp]];
            return;
        }
    }

    [self.nameoftype addObject:account.type];
    [self.databytype addObject:[[NSNumber alloc] initWithFloat:account.amount]];
}

#pragma mark - linepic

- (UIView *)drawbaseline {
    UIView *picView;
    if (self.mode == 2) {
        picView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.chartView.frame.size.width * 2, self.chartView.frame.size.height)];
    } else {
        picView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.chartView.frame.size.width * 1, self.chartView.frame.size.height)];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapoflinechart:)];
    [picView addGestureRecognizer:tapGesture];
    tapGesture.view.tag = -1;

    picView.backgroundColor = [UIColor clearColor];

    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(self.lineoffset - 10, 8 * self.ySpace, picView.frame.size.width - (self.lineoffset - 10) * 2, 0.5)];

    bottomLineView.backgroundColor = [UIColor blackColor];
    [picView addSubview:bottomLineView];

    for (NSInteger i = 0; i < 6; i++) {
        CGPoint startPoint = CGPointMake(self.lineoffset, self.ySpace * 2 + self.ySpace * i);
        CGPoint endPoint = CGPointMake(picView.frame.size.width - self.lineoffset, self.ySpace * 2 + self.ySpace * i);

        UIBezierPath *linePath = [[UIBezierPath alloc] init];
        [linePath moveToPoint:startPoint];
        [linePath addLineToPoint:endPoint];

        CAShapeLayer *contentLineLayer = [[CAShapeLayer alloc] init];
        contentLineLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
        contentLineLayer.lineWidth = 0.5f;
        contentLineLayer.fillColor = [UIColor clearColor].CGColor;

        contentLineLayer.path = linePath.CGPath;
        [picView.layer addSublayer:contentLineLayer];
    }
    if (self.mode == 1) {
        self.xCount = 7;
    } else if (self.mode == 2) {
        NSInteger year = [self.pickerViewOfMonth selectedRowInComponent:0] + self.firstYear;
        NSInteger month = [self.pickerViewOfMonth selectedRowInComponent:1] + 1;
        self.xCount = [self getdaysin:year and:month];
    } else {
        self.xCount = 12;
    }
    self.xSpace = (picView.frame.size.width - 60 - 40) / (self.xCount - 1);
    for (NSInteger i = 0; i < self.xCount; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.xSpace * i, 8 * self.ySpace + 10, 40, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        if (self.mode == 1) {
            switch (i) {
                case 0:
                    label.text = @"星期天";
                    break;
                case 1:
                    label.text = @"星期一";
                    break;
                case 2:
                    label.text = @"星期二";
                    break;
                case 3:
                    label.text = @"星期三";
                    break;
                case 4:
                    label.text = @"星期四";
                    break;
                case 5:
                    label.text = @"星期五";
                    break;
                case 6:
                    label.text = @"星期六";
                    break;
                default:
                    NSLog(@"error");
                    break;
            }
        } else {
            label.text = [NSString stringWithFormat:@"%ld", i + 1];
        }
        [picView addSubview:label];
    }
    return picView;
}

- (void)drawline:(UIView *)picView {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.0;
    for (int i = 0; i < self.xCount; i++) {
        float y = [[self.databytime objectAtIndex:i] floatValue];
        CGPoint point;
        if (y == 0) {
            point = CGPointMake(self.lineoffset + self.xSpace * i + 20, 8 * self.ySpace - 3);
        } else {
            point = CGPointMake(self.lineoffset + self.xSpace * i + 20, 8 * self.ySpace - y * self.ySpace / self.yNum - 3);
        }
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
        UIView *pointview = [[UIView alloc] initWithFrame:CGRectMake(point.x - 3, point.y - 3, 6, 6)];
        pointview.layer.masksToBounds = YES;
        pointview.layer.cornerRadius = 3;
        pointview.backgroundColor = [UIColor whiteColor];
        pointview.layer.borderColor = [[UIColor blackColor] CGColor];
        pointview.layer.borderWidth = 1;

        UIView *taparea = [[UIView alloc] initWithFrame:CGRectMake(point.x - 6, point.y - 6, 12, 12)];
        taparea.layer.masksToBounds = YES;
        taparea.layer.cornerRadius = 6;
        taparea.backgroundColor = [UIColor clearColor];
        taparea.layer.borderWidth = 0;

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapoflinechart:)];
        [taparea addGestureRecognizer:tapGesture];

        [picView addSubview:pointview];
        [picView addSubview:taparea];
        tapGesture.view.tag = i;
    }

    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor grayColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    [picView.layer addSublayer:self.lineChartLayer];
}

- (void)tapoflinechart:(UITapGestureRecognizer *)gesture {
    NSInteger pos = gesture.view.tag;
    if (self.labelinUse != nil) {
        if (pos == self.labelinUse.tag) {
            return;
        }
        [self.labelinUse removeFromSuperview];
        self.labelinUse = nil;
    }
    if (self.labelline != nil) {
        [self.labelline removeFromSuperlayer];
        self.labelline = nil;
    }
    if (pos == -1) {
        return;
    }
    CGPoint startPoint = CGPointMake(self.lineoffset + self.xSpace * pos + 20, self.ySpace * 2);
    CGPoint endPoint = CGPointMake(self.lineoffset + self.xSpace * pos + 20, 8 * self.ySpace);

    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:endPoint];

    CAShapeLayer *labelLineLayer = [[CAShapeLayer alloc] init];
    labelLineLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
    labelLineLayer.lineWidth = 1;
    labelLineLayer.fillColor = [UIColor clearColor].CGColor;
    labelLineLayer.lineDashPattern = @[@10, @4];

    labelLineLayer.path = linePath.CGPath;
    self.labelline = labelLineLayer;
    [self.lineViewinUse.layer addSublayer:labelLineLayer];


    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.delegate = (id) self;
    [labelLineLayer addAnimation:pathAnimation forKey:@"strokeEnd"];


    float num = [[self.databytime objectAtIndex:gesture.view.tag] floatValue];
    NSString *str = [NSString stringWithFormat:@"%0.2f", num];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startPoint.x - str.length * 4, startPoint.y - 22, str.length * 8, 18)];
    label.text = str;
    label.backgroundColor = [UIColor grayColor];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.tag = pos;
    self.labelinUse = label;
    label.textAlignment = NSTextAlignmentCenter;
    [self.lineViewinUse addSubview:label];
}

- (void)beginDrawline {
    UIView *picView = [self drawbaseline];
    _chartView.contentSize = CGSizeMake(picView.frame.size.width, self.chartView.frame.size.height);
    if (self.lineChartLayer != nil) {
        [self.lineChartLayer removeFromSuperlayer];
    }
    [self drawline:picView];
    if (self.lineViewinUse != nil) {
        [self.lineViewinUse removeFromSuperview];
    }
    [self.chartView addSubview:picView];
    self.lineViewinUse = picView;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.delegate = (id) self;
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}



#pragma mark -  set the list, add in classfylist
-(UITableView*)list{
    if(_list==nil){
        _list = [[UITableView alloc]initWithFrame:CGRectMake(4 Wper, 9 Hper, 84 Wper, 51 Hper)];
        _list.backgroundColor = [UIColor whiteColor];
        _list.layer.cornerRadius = 10;
        _list.layer.shadowColor = [UIColor grayColor].CGColor;
        _list.layer.shadowOffset = CGSizeMake(5, 5);
        _list.layer.shadowRadius = 5;
        _list.layer.shadowOpacity = 0.7;
        _list.clipsToBounds = YES;
        _list.delegate = self;
        _list.dataSource = self;
        [_list setScrollEnabled:YES];
        [_list setShowsVerticalScrollIndicator:NO];
    }
    return _list;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.databytype.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    else{
        [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView*inside=[[UIView alloc]initWithFrame:CGRectMake(1 Hper, 0, 80 Wper, 6 Hper)];
    inside.backgroundColor=[UIColor whiteColor];
    inside.backgroundColor= [UIColor whiteColor];
    inside.layer.shadowColor = [UIColor grayColor].CGColor;
    inside.layer.shadowOffset = CGSizeMake(0, 5);
    inside.layer.shadowRadius = 5;
    inside.layer.shadowOpacity = 0.5;
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0.5 Hper, 0.5 Hper, 5 Hper, 5 Hper)];
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.image = [DataManage getIconByLabel:[self.nameoftype objectAtIndex:indexPath.section]];
    img.backgroundColor=[UIColor clearColor];
    
    UIView*box=[[UIView alloc]initWithFrame:CGRectMake(1 Hper, -1.5 Hper, 6 Hper, 6 Hper)];
    [box addSubview:img];
    box.layer.borderColor=[UIColor blackColor].CGColor;
    box.layer.borderWidth=0;
    box.backgroundColor=[UIColor whiteColor];
    box.layer.cornerRadius=1 Hper;
    box.layer.shadowColor = [UIColor grayColor].CGColor;
    box.layer.shadowOffset = CGSizeMake(0, 5);
    box.layer.shadowRadius = 5;
    box.layer.shadowOpacity = 0.7;
    
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(9 Hper, 0 Hper, 10 Hper, 6 Hper)];
    UILabel*price=[[UILabel alloc]initWithFrame:CGRectMake(20 Hper, 0 Hper,80 Wper- 22 Hper, 6 Hper)];
    name.backgroundColor=[UIColor clearColor];
    name.textAlignment=NSTextAlignmentLeft;
    name.text=[self.nameoftype objectAtIndex:indexPath.section];
    [name setFont:[UIFont fontWithName:@"Hiragino Sans" size:16]];
    
    price.backgroundColor=[UIColor clearColor];
    price.textAlignment=NSTextAlignmentRight;
    price.text=[NSString stringWithFormat:@"¥%0.2f", [[self.databytype objectAtIndex:indexPath.section] floatValue]];
    [price setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:20]];
    
    [inside addSubview:box];
    [inside addSubview:name];
    [inside addSubview:price];
    [cell addSubview:inside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 6 Hper;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7 Hper;
}
 
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.anchorPoint =CGPointMake(0,0.5);
    cell.layer.transform =CATransform3DMakeScale(0.1,0.1,1);
    cell.alpha =0.0;
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform =CATransform3DIdentity;
        cell.alpha =1.0;
    }];
}
@end
