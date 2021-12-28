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
#define LastestSubWper *_subArea.bounds.size.width/100
#define LastestSubHper *_subArea.bounds.size.height/100
#define BackColor [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:105/255.0 blue:123/255.0 alpha:1]


@interface NewEntryVC () {
    BOOL inOrOut;
    BOOL showKB;
}

@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) NSMutableArray *inIconArr;
@property(nonatomic, strong) UICollectionView *inCollectView;
@property(nonatomic, strong) NSMutableArray *outIconArr;
@property(nonatomic, strong) UICollectionView *outCollectView;

@property(nonatomic, strong) UIView *subArea;
    @property(nonatomic, strong) UILabel *dateLabel;
    @property(nonatomic, strong) UITextField *tipsText;
    @property(nonatomic, strong) UIImageView *bigImg;
    @property(nonatomic, strong) UITextField *amount;
    @property(nonatomic, strong) UILabel *tipsLabel;

@property(nonatomic, strong) UIViewController *datePickerVC;
    @property(nonatomic, strong) UIDatePicker *datePicker;

@property(nonatomic, strong) UIButton *chooseOne;

@end

@implementation NewEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.inCollectView];
    [self.view addSubview:self.outCollectView];
    self.title = @"添加新纪录";
    showKB = NO;
    inOrOut = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view addSubview:self.subArea];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:self.segmentedControl]];
}

- (UISegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"支出", @"收入"]];
        _segmentedControl.frame = CGRectMake(0 , 0, 22 Wper, 4 Hper);
        _segmentedControl.tintColor = [UIColor whiteColor];
        _segmentedControl.apportionsSegmentWidthsByContent = YES;
        [_segmentedControl addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}
- (void)segmentSelected:(UISegmentedControl *)control {
    if (control.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.inCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 100 Hper);
                             self.outCollectView.frame = CGRectMake(102 Wper, 0, 96 Wper, 100 Hper);
                         }
                         completion:nil];
        inOrOut = YES;
    } else {
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.inCollectView.frame = CGRectMake(-98 Wper, 0, 96 Wper, 100 Hper);
                             self.outCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 100 Hper);
                         }
                         completion:nil];
        inOrOut = NO;
    }
}

- (NSMutableArray *)inIconArr {
    if (_inIconArr == nil) {
        _inIconArr = [DataManage getIconArray:YES];
    }
    return _inIconArr;
}

- (UICollectionView *)inCollectView {
    if (_inCollectView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _inCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 Wper, 0, 96 Wper, 100 Hper) collectionViewLayout:layout];
        _inCollectView.backgroundColor = [UIColor clearColor];
        _inCollectView.delegate = self;
        _inCollectView.dataSource = self;
        _inCollectView.clipsToBounds = NO;
        _inCollectView.showsVerticalScrollIndicator = NO;
        [_inCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID1"];
    }
    return _inCollectView;
}

- (NSMutableArray *)outIconArr {
    if (_outIconArr == nil) {
        _outIconArr = [DataManage getIconArray:NO];
    }
    return _outIconArr;
}

- (UICollectionView *)outCollectView {
    if (_outCollectView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _outCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(102 Wper, 0, 96 Wper, 100 Hper) collectionViewLayout:layout];
        _outCollectView.backgroundColor = [UIColor clearColor];
        _outCollectView.delegate = self;
        _outCollectView.dataSource = self;
        _outCollectView.clipsToBounds = NO;
        _inCollectView.showsVerticalScrollIndicator = NO;
        [_outCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID2"];
    }
    return _outCollectView;
}

- (UIView *)subArea {
    if (_subArea == nil) {
        _subArea = [[UIView alloc] initWithFrame:CGRectMake(-1, 100 Hper, 100 Wper + 2, 35 Hper + 1)];
        _subArea.backgroundColor = [UIColor whiteColor];
        _subArea.layer.borderWidth = 1;
        _subArea.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15].CGColor;

        UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(75 LastestSubWper, 4 LastestSubHper, 12 LastestSubHper, 12 LastestSubHper)];
        [submitButton setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        submitButton.layer.shadowColor = [UIColor colorWithRed:40 / 255.0 green:182 / 255.0 blue:120 / 255.0 alpha:1].CGColor;
        submitButton.layer.shadowOffset = CGSizeMake(0, 0);
        submitButton.layer.shadowOpacity = 0.8;
        submitButton.layer.shadowRadius = 4;
        [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];

        UIButton *quitButton = [[UIButton alloc] initWithFrame:CGRectMake(87 LastestSubWper, 4 LastestSubHper, 12 LastestSubHper, 12 LastestSubHper)];
        [quitButton setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        quitButton.layer.shadowColor = [UIColor colorWithRed:243 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:1].CGColor;
        quitButton.layer.shadowOffset = CGSizeMake(0, 0);
        quitButton.layer.shadowOpacity = 0.8;
        quitButton.layer.shadowRadius = 4;
        [quitButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchDown];

        CALayer *backlayer = [[CALayer alloc] init];
        backlayer.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:240 / 255.0 blue:204 / 255.0 alpha:0.4].CGColor;
        backlayer.frame = CGRectMake(12 LastestSubWper, 25 LastestSubHper, 76 LastestSubWper, 55 LastestSubHper);
        backlayer.zPosition = -100;
        backlayer.cornerRadius = 15;

        UIView *bigImgBack = [[UIView alloc] initWithFrame:CGRectMake(68 LastestSubWper, 53 LastestSubHper, 26 LastestSubWper, 26 LastestSubWper)];
        [bigImgBack addSubview:self.bigImg];
        bigImgBack.layer.shadowColor = [UIColor grayColor].CGColor;
        bigImgBack.layer.shadowOffset = CGSizeMake(2, 5);
        bigImgBack.layer.shadowOpacity = 0.3;
        bigImgBack.layer.shadowRadius = 5;
        bigImgBack.backgroundColor = BackColor;
        bigImgBack.layer.cornerRadius = 15;
        CGAffineTransform rotate = CGAffineTransformMakeRotation(15 / 180.0 * M_PI);
        [bigImgBack setTransform:rotate];

        [_subArea addSubview:bigImgBack];
        [_subArea addSubview:submitButton];
        [_subArea addSubview:quitButton];
        [_subArea addSubview:self.tipsText];
        [_subArea.layer addSublayer:backlayer];
        [_subArea addSubview:self.amount];
        [_subArea addSubview:self.dateLabel];
        [_subArea addSubview:self.tipsLabel];
    }
    return _subArea;
}
- (void)submit {
    BOOL flag = [self.amount.text isEqual:@""];
    NSString *regex = @"(^[0-9]{1,5}+\\.+[0-9]{1,2}$)|([0-9]{1,5})";
    NSPredicate *test = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", regex];
    flag |= ![test evaluateWithObject:self.amount.text];
    if (flag) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的金额！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:conform];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        NSDate *date = self.datePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy";
        NSInteger year = [dateFormatter stringFromDate:date].integerValue;
        dateFormatter.dateFormat = @"MM";
        NSInteger month = [dateFormatter stringFromDate:date].integerValue;
        dateFormatter.dateFormat = @"dd";
        NSInteger day = [dateFormatter stringFromDate:date].integerValue;
        NSString *type;
        if (inOrOut) {
            type = ((IconType *) self.inIconArr[(NSUInteger) self.chooseOne.tag]).label;
        }else {
            type = ((IconType *) self.outIconArr[(NSUInteger) self.chooseOne.tag]).label;
        }
        AccountType *newAccount = [[AccountType alloc]
                initWithType:type
                        tips:self.tipsText.text
                      amount:self.amount.text.doubleValue
                    dateYear:year
                   dateMonth:month
                     dateDay:day
                        kind:inOrOut];
        [DataManage addNewAccount:newAccount];
        [self reset];
    }
}

- (void)reset {
    if (self.chooseOne != nil) {
        self.chooseOne.layer.shadowRadius = 0;
        self.chooseOne.backgroundColor = [UIColor clearColor];
        self.chooseOne.layer.shadowOpacity = 0;
    }
    self.tipsText.text = @"";
    self.tipsLabel.text = @"";
    self.amount.text = @"";
    self.datePicker.date = [NSDate date];
    [self resetDateLabel];
    if (inOrOut) {
        self.inCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 100 Hper);
    }else {
        self.outCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 100 Hper);
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.inCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 100 Hper);
                             self.outCollectView.frame = CGRectMake(102 Wper, 0, 96 Wper, 100 Hper);
                         }
                         completion:nil];
        inOrOut = YES;
    }
    self.segmentedControl.selectedSegmentIndex = 0;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.subArea.frame = CGRectMake(-1, 100 Hper, 100 Wper + 2, 35 Hper + 1);
                     }
                     completion:nil];
    [self.tipsText endEditing:YES];
}

#pragma mark - SubArea Views

- (UITextField *)tipsText {
    if (_tipsText == nil) {
        _tipsText = [[UITextField alloc] initWithFrame:CGRectMake(3 LastestSubWper, 4 LastestSubHper, 69 LastestSubWper, 12 LastestSubHper)];
        _tipsText.placeholder = @"备注";
        _tipsText.layer.cornerRadius = 18;
        _tipsText.backgroundColor = BackColor;
        _tipsText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4 LastestSubWper, 12 LastestSubHper)];
        _tipsText.delegate = self;
        _tipsText.leftViewMode = UITextFieldViewModeAlways;
        _tipsText.tintColor = [UIColor grayColor];
        [_tipsText addTarget:self action:@selector(listenInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return _tipsText;
}

- (void)listenInput:(UITextField *)textField {
    self.tipsLabel.text = textField.text;
}

- (UIImageView *)bigImg {
    if (_bigImg == nil) {
        _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(3 LastestSubWper, 3 LastestSubHper, 20 LastestSubWper, 20 LastestSubWper)];
        _bigImg.backgroundColor = [UIColor clearColor];
    }
    return _bigImg;
}

- (UILabel *)dateLabel {
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 LastestSubWper, 67 LastestSubHper, 60 LastestSubWper, 10 LastestSubHper)];
        _dateLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:20];
        _dateLabel.textColor = [UIColor darkGrayColor];
        UITapGestureRecognizer *uiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
        _dateLabel.userInteractionEnabled = YES;
        [_dateLabel addGestureRecognizer:uiTap];
        [self resetDateLabel];
    }
    return _dateLabel;
}
- (void)showDatePicker{
    [self presentViewController:self.datePickerVC animated:YES completion:nil];
}

- (UITextField *)amount {
    if (_amount == nil) {
        _amount = [[UITextField alloc] initWithFrame:CGRectMake(17 LastestSubWper, 29 LastestSubHper, 30 LastestSubWper, 15 LastestSubHper)];
        _amount.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:40];
        _amount.textAlignment = NSTextAlignmentCenter;
        _amount.placeholder = @"0";
        _amount.tintColor = [UIColor brownColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15 LastestSubHper)];
        label.text = @"¥";
        label.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:45];
        _amount.delegate = (id)self;
        _amount.rightViewMode = UITextFieldViewModeAlways;
        _amount.rightView = label;
    }
    return _amount;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 LastestSubWper, 52 LastestSubHper, 40 LastestSubWper, 15 LastestSubHper)];
        _tipsLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:16];
        _tipsLabel.textColor = [UIColor grayColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

#pragma mark - DatePicker

- (UIViewController *)datePickerVC {
    if (_datePickerVC == nil) {
        _datePickerVC = [[UIViewController alloc] init];
        [_datePickerVC.view addSubview:self.datePicker];
        _datePickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
        UITapGestureRecognizer *uiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker)];
        _datePickerVC.view.userInteractionEnabled = YES;
        [_datePickerVC.view addGestureRecognizer:uiTap];
    }
    return _datePickerVC;
}
- (void)dismissDatePicker {
    [self resetDateLabel];
    [self.datePickerVC dismissViewControllerAnimated:YES completion:nil];
}

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        //设置本地化支持的语言（在此是中文)
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setDate:[NSDate date] animated:YES];
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        [_datePicker setFrame:CGRectMake(7 Wper, 30 Hper, 86 Wper, 25 Hper)];
        _datePicker.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        _datePicker.layer.cornerRadius = 18;
        _datePicker.layer.masksToBounds = YES;

        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:3];//设置最大时间为：当前时间推后十年
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [comps setYear:-3];//设置最小时间为：当前时间前推十年
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [_datePicker setMaximumDate:maxDate];
        [_datePicker setMinimumDate:minDate];
    }
    return _datePicker;
}

- (void)resetDateLabel {
    NSDate *theDate = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.dateLabel.text = [NSString stringWithFormat:@"> %@", [dateFormatter stringFromDate:theDate]];
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

#pragma mark - UICollectionVC DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView == self.inCollectView? self.inIconArr.count : self.outIconArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (collectionView == self.inCollectView){
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID1" forIndexPath:indexPath];
    }else {
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID2" forIndexPath:indexPath];
    }
    UIButton *button = [self setIconButton:indexPath.item type:collectionView == self.inCollectView];
    for (UIView *view in [cell subviews]) {
        [view removeFromSuperview];
    }
    [cell addSubview:button];
    return cell;
}

- (UIButton *)setIconButton:(NSInteger)index type:(BOOL)isIn{
    UIImage *img;
    NSString *name;
    if (isIn) {
        img = ((IconType *) self.inIconArr[index]).icon;
        name = ((IconType *) self.inIconArr[index]).label;
    }else{
        img = ((IconType *) self.outIconArr[index]).icon;
        name = ((IconType *) self.outIconArr[index]).label;
    }
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(2.5, 2.5, 96 Wper / 4 - 5, 96 Wper / 4 - 5)];
    button.tag = index;
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 20;
    button.titleLabel.font = [UIFont fontWithName:@"Hiragino Sans" size:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(3 Wper, 6 Wper, 9 Wper, 6 Wper)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height + 15, -button.imageView.frame.size.width, 0, 0)];
    [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchDown];
    button.layer.shadowColor = [UIColor whiteColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 0);
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowRadius = 0.0;
    return button;
}

- (void)selectButtonAction:(id)sender {
    if (self.chooseOne != nil) {
        self.chooseOne.layer.shadowRadius = 0;
        self.chooseOne.backgroundColor = [UIColor clearColor];
        self.chooseOne.layer.shadowOpacity = 0;
    }
    UIButton *button = (UIButton *) sender;
    self.chooseOne = button;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.chooseOne.layer.shadowColor = [UIColor grayColor].CGColor;
                         self.chooseOne.layer.shadowOffset = CGSizeMake(1, 1);
                         self.chooseOne.layer.shadowOpacity = 0.2;
                         self.chooseOne.layer.shadowRadius = 6;
                         self.chooseOne.backgroundColor = [UIColor whiteColor];
                         self.subArea.frame = CGRectMake(-1, 65 Hper, 100 Wper + 2, 35 Hper + 1);
                     }
                     completion:^(BOOL fin) {
                         if (fin) {
                             if (inOrOut) {
                                 self.inCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 65 Hper);
                             }else {
                                 self.outCollectView.frame = CGRectMake(2 Wper, 0, 96 Wper, 65 Hper);
                             }
                         }
                     }];
    self.bigImg.image = inOrOut? ((IconType *) self.inIconArr[(NSUInteger) self.chooseOne.tag]).icon : ((IconType *) self.outIconArr[(NSUInteger) self.chooseOne.tag]).icon;
}

#pragma mark - UICollectionVC Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(96 Wper / 4 , 96 Wper / 4);
}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - KeyBoard

- (void)keyboardWillShow:(NSNotification *)note {
    if (showKB == NO) {
        self.subArea.transform = CGAffineTransformTranslate(self.subArea.transform, 0, -20 Hper);
        showKB = YES;
    }
}

- (void)keyboardWillHide:(NSNotification *)note {
    if (showKB == YES) {
        self.subArea.transform = CGAffineTransformTranslate(self.subArea.transform, 0, 20 Hper);
        showKB = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]){
        [textField endEditing:YES];
        //在这里做你响应return键的代码
    }

    return YES;
}

@end
