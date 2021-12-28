//
//  ExtendedVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "ExtendedVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define SubWper *_calendarArea.bounds.size.width/100
#define SubHper *_calendarArea.bounds.size.height/100
#define BackColor [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]

@interface ExtendedVC ()

//@property (nonatomic, strong) NSMutableArray *allAccountData;
//
@property (nonatomic, strong) CAGradientLayer *backLayer;
@property (nonatomic, strong) UIView *calendarArea;
@property (nonatomic, strong) UIImageView *calendarImage;
//@property (nonatomic, strong) UIImageView *latestImage1;
//@property (nonatomic, strong) UIImageView *latestImage2;
//@property (nonatomic, strong) UIImageView *latestImage3;
@property (nonatomic, strong) UILabel *latestLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
//@property (nonatomic, strong) UIView *dashBoard;
@property (nonatomic, strong) UITableView *calendarList;
//@property (nonatomic, strong) NSMutableArray *allEntry;
//@property (nonatomic, strong) NSMutableArray *allDate;
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIButton *waterButton;
@property (assign) NSInteger days;
@end

@implementation ExtendedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.days = 0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.backImage];
    [self.view.layer addSublayer:self.backLayer];
    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.waterButton];
    [self.view addSubview:self.calendarArea];
    [self.view addSubview:self.calendarImage];
//    [self.view addSubview:self.calendarList];
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(3 Wper, 60 Hper, 10 Hper, 10 Hper)];
//    img.contentMode = UIViewContentModeScaleAspectFill;
//    img.image = [UIImage imageNamed:@"cal.png"];
//    [self.view addSubview:img];
}

- (CAGradientLayer *)backLayer {
    if (_backLayer == nil) {
        _backLayer = [CAGradientLayer layer];
        _backLayer.frame = CGRectMake(0, 0, 100 Wper, 30 Hper);
        _backLayer.startPoint = CGPointMake(0, 1);
        _backLayer.endPoint = CGPointMake(0, 0);
        _backLayer.zPosition = -1;
        _backLayer.colors = @[
            (__bridge id)[UIColor colorWithRed:170/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithRed:170/255.0 green:210/255.0 blue:210/255.0 alpha:0.5].CGColor,
            (__bridge id)[UIColor colorWithRed:170/255.0 green:210/255.0 blue:210/255.0 alpha:0.2].CGColor,
            (__bridge id)[UIColor colorWithRed:170/255.0 green:210/255.0 blue:210/255.0 alpha:0].CGColor
            
        ];
    }
    return _backLayer;
}


- (UIImageView *)backImage {
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 Wper, 30 Hper, 100 Wper, 59 Hper)];
        _backImage.image = [UIImage imageNamed:@"extend.png"];
        _backImage.layer.cornerRadius = 10;
        _backImage.layer.shadowColor = [UIColor grayColor].CGColor;
        _backImage.layer.shadowOffset = CGSizeMake(5, 5);
        _backImage.layer.shadowRadius = 5;
        _backImage.layer.shadowOpacity = 0.2;
    }
    return _backImage;
}

- (UIImageView *)calendarImage {
    if (_calendarImage == nil) {
        _calendarImage = [[UIImageView alloc]initWithFrame:CGRectMake(6 Wper, 20 Hper, 90 Wper, 8 Hper)];
        _calendarImage.image = [UIImage imageNamed:@"cal.png"];
//        _calendarImage.layer.cornerRadius = 10;
//        _calendarImage.layer.shadowColor = [UIColor grayColor].CGColor;
//        _calendarImage.layer.shadowOffset = CGSizeMake(5, 5);
//        _calendarImage.layer.shadowRadius = 5;
//        _calendarImage.layer.shadowOpacity = 0.2;
    }
    return _calendarImage;
}

- (UILabel *)bottomLabel {
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc]initWithFrame: CGRectMake(33 Wper, 65 Hper, 35 Wper, 3.5 Hper) ];
        _bottomLabel.text = [NSString  stringWithFormat:@"你已连续签到\t%ld天" , self.days];
        _bottomLabel.font = [UIFont systemFontOfSize:16];
        _bottomLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _bottomLabel.layer.opacity = 1;
        
        _bottomLabel.layer.cornerRadius = 10;
        _bottomLabel.layer.shadowColor = [UIColor grayColor].CGColor;
        _bottomLabel.layer.shadowOffset = CGSizeMake(5, 5);
        _bottomLabel.layer.shadowRadius = 5;
        _bottomLabel.layer.shadowOpacity = 0.2;
    }
    return _bottomLabel;
}

- (UIButton *)waterButton {
    if (_waterButton == nil) {
        _waterButton = [[UIButton alloc]initWithFrame: CGRectMake(70 Wper, 39 Hper, 22 Wper, 9 Hper) ];
        _waterButton.layer.borderColor = [UIColor greenColor].CGColor;
        _waterButton.layer.backgroundColor = [UIColor greenColor].CGColor;
        _waterButton.layer.opacity = 0.3;
        [_waterButton addTarget:self action:@selector( CheckOut ) forControlEvents:UIControlEventTouchDown];
        
//        [leftBtn addTarget:self action:@selector(LRButtonAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _waterButton;
}

- (void) CheckOut{
    self.days = self.days + 1;
    self.bottomLabel.text =  [NSString  stringWithFormat:@"你已连续签到\t%ld天" ,self.days];
    [self UpdatePoints];
}

- (void) UpdatePoints{
    // points = points + self.days;
}

-(UIView *)calendarArea {
    if (_calendarArea == nil) {
        _calendarArea = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 10 Hper, 90 Wper, 20 Hper)];
        _calendarArea.backgroundColor = [UIColor whiteColor];
//        _calendarArea.backgroundColor = [UIColor colorWithRed:170/255.0 green:210/255.0 blue:210/255.0 alpha:1];
        _calendarArea.layer.opacity = 1;
        _calendarArea.layer.cornerRadius = 10;
        _calendarArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _calendarArea.layer.shadowOffset = CGSizeMake(5, 5);
        _calendarArea.layer.shadowRadius = 5;
        _calendarArea.layer.shadowOpacity = 0.2;
        [_calendarArea addSubview:self.latestLabel];
    }
    return _calendarArea;
}

#pragma mark - calendarAreaSubView

- (UILabel *)latestLabel {
    if (_latestLabel == nil) {
        _latestLabel = [[UILabel alloc]initWithFrame: CGRectMake(35 SubWper, 10 SubHper, 50 SubWper, 16 SubHper) ];
        _latestLabel.text = @"签到领积分";
        _latestLabel.font = [UIFont systemFontOfSize:20];
    }
    return _latestLabel;
}

//
//- (UIImageView* )latestImage1 {
//    if (_latestImage1 == nil) {
//        _latestImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(3 SubWper, 35 SubHper, 50 SubWper, 50 SubHper)];
//        _latestImage1.layer.cornerRadius = 10;
//        _latestImage1.clipsToBounds = YES;
//        _latestImage1.contentMode = UIViewContentModeScaleAspectFill;
//        _latestImage1.image = [UIImage imageNamed:@"userTest.png"];
//    }
//    return _latestImage1;
//}
//
//- (UIImageView* )latestImage2 {
//    if (_latestImage2 == nil) {
//        _latestImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(55 SubWper, 28 SubHper, 40 SubWper, 30 SubHper)];
//        _latestImage2.layer.cornerRadius = 10;
//        _latestImage2.clipsToBounds = YES;
//        _latestImage2.image = [UIImage imageNamed:@"userImg.png"];
//    }
//    return _latestImage2;
//}
//- (UIImageView* )latestImage3 {
//    if (_latestImage3 == nil) {
//        _latestImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(55 SubWper, 62 SubHper, 40 SubWper, 30 SubHper)];
//        _latestImage3.layer.cornerRadius = 10;
//        _latestImage3.clipsToBounds = YES;
//        _latestImage3.image = [UIImage imageNamed:@"userImg.png"];
//    }
//    return _latestImage3;
//}
//
//
#pragma mark end -


- (UITableView *)calendarList {
    if (_calendarList == nil) {
        _calendarList = [[UITableView alloc]initWithFrame:CGRectMake(95 Wper, -20 Hper, 50 Wper, 80 Hper)];
        _calendarList.backgroundColor = [UIColor blueColor];
        _calendarList.transform = CGAffineTransformMakeRotation(M_PI/-2);


        _calendarList.layer.cornerRadius = 10;
        _calendarList.layer.shadowColor = [UIColor grayColor].CGColor;
        _calendarList.layer.shadowOffset = CGSizeMake(5, 5);
        _calendarList.layer.shadowRadius = 5;
        _calendarList.layer.shadowOpacity = 0.2;
        _calendarList.clipsToBounds = YES;
        _calendarList.delegate = self;
        _calendarList.dataSource = self;
        [_calendarList setScrollEnabled:NO];
    }
    return _calendarList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 5 Hper, 5 Hper)];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(1 Wper, 1 Wper, 5 Hper, 5 Hper)];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:@"cal.png"];
    
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(1 Hper, 1 Hper, 5 Hper, 5 Hper)];
//
//    UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.width/100 * 80, 0, cell.bounds.size.width/100 * 30, 7 Hper)];
    //cost text need to be changable
//    costLabel.textAlignment = NSTextAlignmentRight;
    [cell addSubview:img];
    [cell addSubview:descriptionLabel];
//    [cell addSubview:costLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    descriptionLabel.text = @"19";
//    costLabel.text = [NSString stringWithFormat:@"%.2f",((AccountType *)self.allAccountData[indexPath.row]).amount ];
//    cell.separatorInset = UIEdgeInsetsMake(0, 5 Wper + 5 Hper, 0, 0);
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.layer.cornerRadius = 5;
    cell.layer.shadowColor = [UIColor grayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(5, 5);
    cell.layer.shadowRadius = 5;
    cell.layer.shadowOpacity = 0.2;
    cell.clipsToBounds = YES;
    return cell;
}


#pragma mark UITableViewDelegate
////
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 20 Hper;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //  goToProfile: indexPath.row
    [self checkOutAt : indexPath.row];
}
- (void)checkOutAt : (NSInteger) n{
    //to  check  out at day n
}
#pragma mark end -

@end
