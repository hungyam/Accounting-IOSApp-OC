//
//  ChartVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "ChartVC.h"
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
@property(nonatomic, strong) CAShapeLayer *pieMaskLayer;

@property(nonatomic, assign) int lineoffset;//横线偏移量
@property(nonatomic, assign) float ySpace;//y轴间隔
@property(nonatomic, assign) int yNum;//y轴一个间隔的数值
@property(nonatomic, assign) int xCount;//x轴的点数
@property(nonatomic, assign) float xSpace;//x轴间隔


@property(nonatomic, assign) NSInteger mode;
@property(nonatomic, assign) NSInteger inOrOut;

@property(nonatomic, strong) UIView *lineViewinUse;
@property(nonatomic, strong) UIView *pieViewinUse;

@property(nonatomic, strong) UILabel *labelinUse;
@property(nonatomic, strong) CAShapeLayer *labelline;

@property(nonatomic, strong) UIButton *buttoninUse;

@property(nonatomic, strong) UIView *dateChooseArea;

@property(nonatomic, strong) UIView *classifyPie;
@property(nonatomic, strong) NSMutableArray *colorofpie;
@property(nonatomic, assign) NSInteger pieNum;
@property(nonatomic, strong) UIView *colorexp;
@property(nonatomic, strong) UILabel *midpielabel;
@property(nonatomic, strong) UILabel *toppielabel;
@property(nonatomic, strong) UILabel *bottompielabel;
@property(nonatomic, assign) float total;
@property(nonatomic, assign) float radius;
@property(nonatomic, assign) CGPoint midpoint;
@property(nonatomic, assign) bool drawdelay;

@property(nonatomic, strong) UIView *classifyList;

@property(nonatomic, strong) UISegmentedControl *segment;
//@property (nonatomic, strong) UISegmentedControl *topSegment;
@property(nonatomic, strong) UIButton *topSegmentLeft;
@property(nonatomic, strong) UIButton *topSegmentRight;


@property(nonatomic, strong) UIPickerView *pickerViewOfWeek;
@property(nonatomic, strong) UIPickerView *pickerViewOfMonth;
@property(nonatomic, strong) UIPickerView *pickerViewOfYear;
@property(nonatomic, assign) NSInteger firstYear;
@property(nonatomic, assign) NSInteger lastYear;
@property(nonatomic, assign) NSInteger chooseYear;

@end

@implementation ChartVC
-(void)initdata{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    self.view.backgroundColor = [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1];
    [self.view addSubview:self.mainView];
    [self setButtonLine];
    UIBarButtonItem *btnItemLeft = [[UIBarButtonItem alloc]initWithCustomView:self.topSegmentLeft];
    UIBarButtonItem *btnItemRight = [[UIBarButtonItem alloc]initWithCustomView:self.topSegmentRight];
    self.navigationItem.leftBarButtonItems = @[btnItemLeft,btnItemRight];
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
    [self setlist];
    if (self.segment.selectedSegmentIndex == 0) {
        self.drawdelay = 1;
    } else {
        [self beginDrawpie];
    }
}

- (NSMutableArray *)databytime {
    if (_databytime == nil) {
        _databytime = [[NSMutableArray alloc] init];
        [_databytime addObject:[NSNumber numberWithFloat:123.00]];
        [_databytime addObject:[NSNumber numberWithFloat:513.00]];
        [_databytime addObject:[NSNumber numberWithFloat:423.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:633.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:139.00]];
        [_databytime addObject:[NSNumber numberWithFloat:253.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:233.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:193.00]];
        [_databytime addObject:[NSNumber numberWithFloat:263.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:13.00]];
        [_databytime addObject:[NSNumber numberWithFloat:263.00]];
        [_databytime addObject:[NSNumber numberWithFloat:273.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:13.00]];
        [_databytime addObject:[NSNumber numberWithFloat:23.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:13.00]];
        [_databytime addObject:[NSNumber numberWithFloat:23.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
    }
    return _databytime;
}

-(NSMutableArray*)databytype{
    if(_databytype==nil){
        _databytype=[[NSMutableArray alloc]init];
    }
    return  _databytype;
}

-(NSMutableArray*)maindata{
    if(_maindata==nil){
        _maindata=[[NSMutableArray alloc] init];
    }
    return  _maindata;
}

-(NSMutableArray*)nameoftype{
    if(_nameoftype==nil){
        _nameoftype=[[NSMutableArray alloc] init];
    }
    return  _nameoftype;
}

- (UIScrollView *)mainView {
    if (_mainView == nil) {
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 100 Wper, 100 Hper)];
        _mainView.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:self.chartView];
        [_mainView addSubview:self.classifyList];
        [_mainView addSubview:self.segment];
        [_mainView addSubview:self.datePickerLabel];
        _mainView.contentSize = CGSizeMake(100 Wper, 120 Hper);
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
        [_topSegmentLeft setTitle:@"收入" forState:UIControlStateNormal];
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
        [_topSegmentRight setTitle:@"支出" forState:UIControlStateNormal];
        [_topSegmentRight setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_topSegmentRight addTarget:self action:@selector(topSegmentSelected:) forControlEvents:UIControlEventTouchDown];
    }
    return _topSegmentRight;
}

- (void)topSegmentSelected:(id)sender {
    UIButton *control = (UIButton *) sender;
    if (control.tag == 1) {
        if (self.inOrOut == 1) {
            self.inOrOut = 0;
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
        if (self.inOrOut == 0) {
            self.inOrOut = 1;
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
-(bool)isRun:(NSInteger)year{
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

-(NSInteger)weekdatein:(NSInteger)y and:(NSInteger)m and:(NSInteger)d{
    if (m == 1 || m == 2)
    {
        m += 12;
        y--;
    }
    int week=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7;
    return week+1;
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
        _datePickerLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 Wper, 32 Hper, 20 Wper, 6.5 Hper)];
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
        [_pickerViewOfYear selectRow:self.chooseYear-self.firstYear inComponent:0 animated:false];
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
        [_pickerViewOfMonth selectRow:self.chooseYear-self.firstYear inComponent:0 animated:false];
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
        [_pickerViewOfWeek selectRow:self.chooseYear-self.firstYear inComponent:0 animated:false];
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
        return self.lastYear-self.firstYear+1;
    }
    if(pickerView.tag==1){
        NSInteger weekdate=[self weekdatein:self.chooseYear and:1 and:1];
        if([self isRun:self.chooseYear]&&(weekdate==7||weekdate==6)){
            return  53;
        
        }
        else if(weekdate==7){
            return  53;
        }
        return 52;
    }
    return 12;
}



//设置每个选项显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%ld",self.firstYear+row];
    }
    if(pickerView.tag==1){
        return [self gettheNo:row weekin:self.chooseYear];
    }
    return [NSString stringWithFormat:@"%ld",row+1];
}
-(NSString*)gettheNo:(NSInteger)num weekin:(NSInteger)year{
    NSInteger basedate=[self begindayin:year];
    NSInteger beginday=basedate+7*num,endday=beginday+6;
    NSString*begin=[self dateof:beginday daysinyear:year];
    NSString*end=[self dateof:endday daysinyear:year];
    return [NSString stringWithFormat:@"%@-%@",begin,end];
}
-(NSString*)dateof:(NSInteger)day daysinyear:(NSInteger)year{
    NSInteger daysinmonth[13]={31,28,31,30,31,30,31,31,30,31,30,31,666};
    NSInteger month=1;
    if([self isRun:year]){
        daysinmonth[1]++;
    }
    while (day>daysinmonth[month-1]){
        day-=daysinmonth[month-1];
        month++;
        if(month==13){
            month-=12;
        }
    }
    return [NSString stringWithFormat:@"%ld.%ld",month,day];
}
-(NSInteger)begindayin:(NSInteger)year{
    return 8-[self weekdatein:year and:1 and:1];
}
//用户进行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0&&pickerView.tag==1) {
        self.chooseYear=[pickerView selectedRowInComponent:0]+self.firstYear;
        [pickerView reloadAllComponents];
    }
    [self refresh];
}

#pragma mark end -


- (UIView *)classifyList {
    if (_classifyList == nil) {
        _classifyList = [[UIView alloc] initWithFrame:CGRectMake(4 Wper, 45 Hper, 92 Wper, 60 Hper)];
        _classifyList.backgroundColor = [UIColor whiteColor];
        _classifyList.layer.cornerRadius = 15;
        _classifyList.layer.shadowColor = [UIColor grayColor].CGColor;
        _classifyList.layer.shadowOffset = CGSizeMake(0, 0);
        _classifyList.layer.shadowRadius = 10;
        _classifyList.layer.shadowOpacity = 0.1;
    }
    return _classifyList;
}

- (UIView *)classifyPie {
    if (_classifyPie == nil) {
        _classifyPie = [[UIView alloc] initWithFrame:CGRectMake(4 Wper, 45 Hper, 92 Wper, 45 Hper)];
        self.midpoint = CGPointMake(_classifyPie.frame.size.width / 2, _classifyPie.frame.size.height / 2);
        self.radius = self.midpoint.y < self.midpoint.x ? self.midpoint.y / 3 * 2 : self.midpoint.x / 3 * 2;
        _classifyPie.backgroundColor = [UIColor whiteColor];
        _classifyPie.layer.cornerRadius = 15;
        _classifyPie.layer.shadowColor = [UIColor grayColor].CGColor;
        _classifyPie.layer.shadowOffset = CGSizeMake(0, 0);
        _classifyPie.layer.shadowRadius = 10;
        _classifyPie.layer.shadowOpacity = 0.1;

    }
    return _classifyPie;
}

- (UISegmentedControl *)segment {
    if (_segment == nil) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"排行榜", @"扇形图"]];
        _segment.frame = CGRectMake(70 Wper, 40 Hper , 25 Wper, 30);
        _segment.selectedSegmentIndex = 1;
        _segment.tintColor = [UIColor whiteColor];
        _segment.apportionsSegmentWidthsByContent = YES;
        [_segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
    }
    return _segment;
}

- (void)segmentSelected:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *) sender;
    if (control.selectedSegmentIndex == 0) {
        [self.classifyPie removeFromSuperview];
        [self.mainView addSubview:self.classifyList];
        [self.mainView sendSubviewToBack:self.classifyList];
    } else {
        [self.classifyList removeFromSuperview];
        if (self.drawdelay == 1) {
            self.drawdelay = 0;
            [self beginDrawpie];
        }
        [self.mainView addSubview:self.classifyPie];
        [self.mainView sendSubviewToBack:self.classifyPie];
    }
}

#pragma mark - part of pie

- (NSMutableArray *)colorofpie {
    if (_colorofpie == nil) {
        _colorofpie = [[NSMutableArray alloc] init];
        [_colorofpie addObject:[UIColor redColor]];
        [_colorofpie addObject:[UIColor orangeColor]];
        [_colorofpie addObject:[UIColor yellowColor]];
        [_colorofpie addObject:[UIColor greenColor]];
        [_colorofpie addObject:[UIColor cyanColor]];
        [_colorofpie addObject:[UIColor blueColor]];
        [_colorofpie addObject:[UIColor purpleColor]];
        [_colorofpie addObject:[UIColor grayColor]];
        [_colorofpie addObject:[UIColor brownColor]];
        [_colorofpie addObject:[UIColor magentaColor]];
    }
    return _colorofpie;
}

- (UILabel *)midpielabel {
    if (_midpielabel == nil) {
        CGFloat radius = self.radius / 2;
        _midpielabel = [[UILabel alloc] initWithFrame:CGRectMake(self.midpoint.x - 0.86 * radius, self.midpoint.y - 0.5 * radius, 1.72 * radius, radius)];
        _midpielabel.backgroundColor = [UIColor clearColor];
        _midpielabel.font = [UIFont systemFontOfSize:35];
        _midpielabel.textColor = [UIColor blackColor];
        _midpielabel.textAlignment = NSTextAlignmentCenter;
        _midpielabel.layer.borderWidth = 0;
        _midpielabel.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _midpielabel;
}

- (UIView *)colorexp {
    if (_colorexp == nil) {
        CGFloat radius = self.radius;
        _colorexp = [[UIView alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - radius / 2, self.classifyPie.frame.size.height / 6 - radius / 3, self.classifyPie.frame.size.height / 6 - radius / 3, self.classifyPie.frame.size.height / 6 - radius / 3)];
        _colorexp.layer.borderColor = [UIColor blackColor].CGColor;
        _colorexp.layer.borderWidth = 1;
    }
    return _colorexp;
}

- (UILabel *)toppielabel {
    if (_toppielabel == nil) {
        CGFloat radius = self.radius;
        _toppielabel = [[UILabel alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - radius / 2 + self.classifyPie.frame.size.height / 3 - radius / 3 * 2, self.classifyPie.frame.size.height / 6 - radius / 3, radius, self.classifyPie.frame.size.height / 6 - radius / 3)];
        _toppielabel.text = @"某个类名";
        _toppielabel.backgroundColor = [UIColor clearColor];

        _toppielabel.font = [UIFont systemFontOfSize:20];
        _toppielabel.textColor = [UIColor blackColor];
    }
    return _toppielabel;
}

- (UILabel *)bottompielabel {
    if (_bottompielabel == nil) {
        _bottompielabel = [[UILabel alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - self.radius / 2, self.classifyPie.frame.size.height * 5 / 8 + self.radius * 3 / 4, self.radius, self.classifyPie.frame.size.height / 4 - self.radius / 2)];
        _bottompielabel.backgroundColor = [UIColor clearColor];
        _bottompielabel.font = [UIFont systemFontOfSize:25];
        _bottompielabel.textColor = [UIColor blackColor];
        _bottompielabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottompielabel;
}

- (CAShapeLayer *)pieMaskLayer {
    if (_pieMaskLayer == nil) {
        CGPoint midpoint = CGPointMake(self.classifyPie.frame.size.width / 2, self.classifyPie.frame.size.height / 2);
        CGFloat bgRadius = midpoint.y < midpoint.x ? midpoint.y * 2 / 3 : midpoint.x * 2 / 3;
        UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:midpoint
                                                              radius:bgRadius / 2
                                                          startAngle:-M_PI_2
                                                            endAngle:M_PI_2 * 3
                                                           clockwise:YES];
        self.pieMaskLayer = [CAShapeLayer layer];
        self.pieMaskLayer.fillColor = [UIColor clearColor].CGColor;
        self.pieMaskLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        self.pieMaskLayer.strokeStart = 0.0f;
        self.pieMaskLayer.strokeEnd = 1.0f;
        self.pieMaskLayer.zPosition = 1;
        self.pieMaskLayer.lineWidth = bgRadius;
        self.pieMaskLayer.path = bgPath.CGPath;
    }
    return _pieMaskLayer;
}

#pragma mark - base data of pic and list


- (void)refreshdata {
    NSString*week;
    NSInteger month;
    NSMutableArray*basedata=[[NSMutableArray alloc] init];
    if(self.chooseYear==0){
        self.chooseYear=2021;
        week=[self gettheNo:0 weekin:self.chooseYear];
        month=1;
    }
    else{
        week=[self gettheNo:[self.pickerViewOfWeek selectedRowInComponent:1] weekin:self.chooseYear];
        month=[self.pickerViewOfMonth selectedRowInComponent:1]+1;
    }
    
    for(NSInteger i=0;i<self.maindata.count;i++){
        if(self.mode==1){
            
        }
        else if(self.mode==2){
            
        }
    }
    
    self.firstYear=2017;
    self.lastYear=2025;
    self.pieNum = 15;
    self.yNum = [self setyNumwithmax:633.00];

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
        self.xCount = [self getdaysin:2020 and:2];
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
        CGPoint point = CGPointMake(self.lineoffset + self.xSpace * i + 20, 8 * self.ySpace - y * self.ySpace / self.yNum - 3);
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
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
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
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = (id) self;
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}


#pragma mark - piepic

- (void)beginDrawpie {
    UIView *picView = [self drawpie];
    if (self.pieViewinUse != nil) {
        [self.pieViewinUse removeFromSuperview];
    }
    [self.classifyPie addSubview:picView];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [self.pieMaskLayer addAnimation:animation forKey:@"circleAnimation"];

    self.pieViewinUse = picView;
}

- (UIView *)drawpie {
    UIView *picView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.classifyPie.frame.size.width, self.classifyPie.frame.size.height)];
    picView.backgroundColor = [UIColor clearColor];
    self.total = 0;
    for (int i = 0; i < self.pieNum; i++) {
        self.total += [[self.databytime objectAtIndex:i] floatValue];
    }
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;

    for (int i = 0; i < self.pieNum; i++) {
        //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        end = [[self.databytime objectAtIndex:i] floatValue] * M_PI * 2 / self.total + start;
        //图层

        UIColor *color;
        if (i < self.colorofpie.count) {
            color = [self.colorofpie objectAtIndex:i];
        } else {
            CGFloat red = arc4random_uniform(256) / 255.0;
            CGFloat green = arc4random_uniform(256) / 255.0;
            CGFloat blue = arc4random_uniform(256) / 255.0;
            color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            [self.colorofpie addObject:color];
        }

        UIBezierPath *partPath = [UIBezierPath bezierPathWithArcCenter:self.midpoint
                                                                radius:self.radius
                                                            startAngle:start - M_PI_2
                                                              endAngle:end - M_PI_2
                                                             clockwise:YES];
        [partPath addLineToPoint:self.midpoint];
        CAShapeLayer *pie = [CAShapeLayer layer];
        pie.fillColor = color.CGColor;
        pie.strokeColor = [UIColor whiteColor].CGColor;
        pie.lineWidth = 0;
        pie.zPosition = 2;
        pie.path = partPath.CGPath;

        [picView.layer addSublayer:pie];
        //计算下一个start位置 = 当前end位置
        start = end;
    }
    picView.layer.mask = self.pieMaskLayer;
    picView.hidden = NO;

    UIBezierPath *partPath = [UIBezierPath bezierPathWithArcCenter:self.midpoint
                                                            radius:self.radius / 2
                                                        startAngle:-M_PI_2
                                                          endAngle:3 * M_PI_2
                                                         clockwise:YES];
    CAShapeLayer *midview = [CAShapeLayer layer];
    midview.fillColor = [UIColor whiteColor].CGColor;
    midview.strokeColor = [UIColor whiteColor].CGColor;
    midview.zPosition = 3;
    midview.path = partPath.CGPath;
    [picView.layer addSublayer:midview];

    return picView;
}


- (NSInteger)layerpos:(CGPoint)point {
    __block NSInteger i = -1;
    CGAffineTransform transform = CGAffineTransformIdentity;
    [self.pieViewinUse.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *) obj;
        CGPathRef path = [shapeLayer path];
        if (CGPathContainsPoint(path, &transform, point, 0)) {
            i = idx;
        }
    }];
    return i;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    //获取触摸点的集合
    NSSet *allTouches = [event allTouches];
    //获取触摸对象
    UITouch *touch = [allTouches anyObject];
    //返回触摸点所在视图中的坐标
    CGPoint point = [touch locationInView:[touch view]];
    NSInteger num = [self layerpos:point];
    if (num >= 0 && num < self.pieNum) {

        float ratio = [[self.databytime objectAtIndex:num] floatValue] / self.total * 100;
        self.midpielabel.text = [NSString stringWithFormat:@"%0.1f%%", ratio];
        [self.classifyPie addSubview:self.midpielabel];
        [self.view bringSubviewToFront:self.midpielabel];
        self.colorexp.backgroundColor = [self.colorofpie objectAtIndex:num];
        [self.classifyPie addSubview:self.colorexp];
        [self.classifyPie addSubview:self.toppielabel];
        self.bottompielabel.text = [NSString stringWithFormat:@"%0.2f元", [[self.databytime objectAtIndex:num] floatValue]];
        [self.classifyPie addSubview:self.bottompielabel];

    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.midpielabel removeFromSuperview];
    [self.colorexp removeFromSuperview];
    [self.toppielabel removeFromSuperview];
    [self.bottompielabel removeFromSuperview];
}

#pragma mark -  set the list, add in classfylist

- (void)setlist {

}
@end
