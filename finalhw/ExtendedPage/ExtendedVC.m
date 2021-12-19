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

//@property (nonatomic, strong) NSMutableArray *allAcountData;
//
@property (nonatomic, strong) CAGradientLayer *backLayer;
@property (nonatomic, strong) UIView *calendarArea;
//@property (nonatomic, strong) UIImageView *lastestImage1;
//@property (nonatomic, strong) UIImageView *lastestImage2;
//@property (nonatomic, strong) UIImageView *lastestImage3;
@property (nonatomic, strong) UILabel *lastestLabel;
//@property (nonatomic, strong) UIView *dashBoard;
@property (nonatomic, strong) UITableView *calendarList;
//@property (nonatomic, strong) NSMutableArray *allEntry;
//@property (nonatomic, strong) NSMutableArray *allDate;
@end

@implementation ExtendedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    [self.view.layer addSublayer:self.backLayer];
    [self.view addSubview:self.calendarArea];
    [self.view addSubview:self.calendarList];
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(3 Wper, 60 Hper, 10 Hper, 10 Hper)];
//    img.contentMode = UIViewContentModeScaleAspectFill;
//    img.image = [UIImage imageNamed:@"cal.png"];
//    [self.view addSubview:img];
}

- (CAGradientLayer *)backLayer {
    if (_backLayer == nil) {
        _backLayer = [CAGradientLayer layer];
        _backLayer.frame = CGRectMake(0, 0, 100 Wper, 20 Hper);
        _backLayer.startPoint = CGPointMake(0, 0);
        _backLayer.endPoint = CGPointMake(1, 1);
        _backLayer.zPosition = -1;
        _backLayer.colors = @[
            (__bridge id)[UIColor colorWithRed:120/255.0 green:200/255.0 blue:120/255.0 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithRed:120/255.0 green:190/255.0 blue:120/255.0 alpha:0.5].CGColor,
            (__bridge id)[UIColor colorWithRed:160/255.0 green:190/255.0 blue:120/255.0 alpha:0.2].CGColor,
            (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor
            
        ];
    }
    return _backLayer;
}

-(UIView *)calendarArea {
    if (_calendarArea == nil) {
        _calendarArea = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 10 Hper, 90 Wper, 20 Hper)];
        _calendarArea.backgroundColor = [UIColor whiteColor];
        _calendarArea.layer.cornerRadius = 10;
        _calendarArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _calendarArea.layer.shadowOffset = CGSizeMake(5, 5);
        _calendarArea.layer.shadowRadius = 5;
        _calendarArea.layer.shadowOpacity = 0.2;
        [_calendarArea addSubview:self.lastestLabel];
//        [_calendarArea addSubview:self.lastestImage1];
//        [_calendarArea addSubview:self.lastestImage2];
//        [_calendarArea addSubview:self.lastestImage3];

    }
    return _calendarArea;
}

#pragma mark - calendarAreaSubView

- (UILabel *)lastestLabel {
    if (_lastestLabel == nil) {
        _lastestLabel = [[UILabel alloc]initWithFrame: CGRectMake(35 SubWper, 10 SubHper, 50 SubWper, 16 SubHper) ];
        _lastestLabel.text = @"每日签到";
        _lastestLabel.font = [UIFont systemFontOfSize:20];
    }
    return _lastestLabel;
}

//
//- (UIImageView* )lastestImage1 {
//    if (_lastestImage1 == nil) {
//        _lastestImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(3 SubWper, 35 SubHper, 50 SubWper, 50 SubHper)];
//        _lastestImage1.layer.cornerRadius = 10;
//        _lastestImage1.clipsToBounds = YES;
//        _lastestImage1.contentMode = UIViewContentModeScaleAspectFill;
//        _lastestImage1.image = [UIImage imageNamed:@"userTest.png"];
//    }
//    return _lastestImage1;
//}
//
//- (UIImageView* )lastestImage2 {
//    if (_lastestImage2 == nil) {
//        _lastestImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(55 SubWper, 28 SubHper, 40 SubWper, 30 SubHper)];
//        _lastestImage2.layer.cornerRadius = 10;
//        _lastestImage2.clipsToBounds = YES;
//        _lastestImage2.image = [UIImage imageNamed:@"userImg.png"];
//    }
//    return _lastestImage2;
//}
//- (UIImageView* )lastestImage3 {
//    if (_lastestImage3 == nil) {
//        _lastestImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(55 SubWper, 62 SubHper, 40 SubWper, 30 SubHper)];
//        _lastestImage3.layer.cornerRadius = 10;
//        _lastestImage3.clipsToBounds = YES;
//        _lastestImage3.image = [UIImage imageNamed:@"userImg.png"];
//    }
//    return _lastestImage3;
//}
//
//
#pragma mark end -


- (UITableView *)calendarList {
    if (_calendarList == nil) {
        _calendarList = [[UITableView alloc]initWithFrame:CGRectMake(95 Wper, -20 Hper, 50 Wper, 100 Hper)];
        _calendarList.backgroundColor = [UIColor blueColor];
        _calendarList.transform = CGAffineTransformMakeRotation(M_PI/-2);


        _calendarList.layer.cornerRadius = 10;
        _calendarList.layer.shadowColor = [UIColor grayColor].CGColor;
        _calendarList.layer.shadowOffset = CGSizeMake(5, 5);
        _calendarList.layer.shadowRadius = 5;
        _calendarList.layer.shadowOpacity = 0.2;
        _calendarList.clipsToBounds = YES;
        _calendarList.delegate = (id)self;
        _calendarList.dataSource = (id)self;
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
    cell.backgroundColor = [UIColor redColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(1 Wper, 1 Wper, 5 Hper, 5 Hper)];
//    img.contentMode = UIViewContentModeScaleAspectFill;
    img.image = [UIImage imageNamed:@"cal.png"];
    
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 Hper, 5 Hper, 5 Hper)];
//
//    UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.width/100 * 80, 0, cell.bounds.size.width/100 * 30, 7 Hper)];
    //cost text need to be changable
//    costLabel.textAlignment = NSTextAlignmentRight;
    [cell addSubview:img];
    [cell addSubview:descriptionLabel];
//    [cell addSubview:costLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    descriptionLabel.text = @"12.19";
//    costLabel.text = [NSString stringWithFormat:@"%.2f",((AccountType *)self.allAcountData[indexPath.row]).amount ];
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
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 5 Hper;
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
