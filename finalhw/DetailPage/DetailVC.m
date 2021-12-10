//
//  DetailVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "DetailVC.h"
#import "StartNaviVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define SubWper *_lastestArea.bounds.size.width/100
#define SubHper *_lastestArea.bounds.size.height/100
@interface DetailVC ()

@property (nonatomic, strong) CAGradientLayer *backLayer;
@property (nonatomic, strong) UIView *lastestArea;
@property (nonatomic, strong) UIImageView *lastestImage1;
@property (nonatomic, strong) UIImageView *lastestImage2;
@property (nonatomic, strong) UIImageView *lastestImage3;
@property (nonatomic, strong) UILabel *lastestLabel;
@property (nonatomic, strong) UIView *dashBoard;
@property (nonatomic, strong) UITableView *entryList;
@property (nonatomic, strong) NSMutableArray *allEntry;
@property (nonatomic, strong) NSMutableArray *allDate;
//@property (nonatomic, strong) profileVC *profileVC;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view.layer addSublayer:self.backLayer];
    [self.view addSubview:self.lastestArea];
//    [self.view addSubview:self.dashBoard];
    [self.view addSubview:self.entryList];
}

- (CAGradientLayer *)backLayer {
    if (_backLayer == nil) {
        _backLayer = [CAGradientLayer layer];
        _backLayer.frame = CGRectMake(0, 0, 100 Wper, 40 Hper);
        _backLayer.startPoint = CGPointMake(0, 0);
        _backLayer.endPoint = CGPointMake(1, 1);
        _backLayer.zPosition = -1;
        _backLayer.colors = @[
            (__bridge id)[UIColor colorWithRed:120/255.0 green:190/255.0 blue:200/255.0 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithRed:160/255.0 green:215/255.0 blue:215/255.0 alpha:0.5].CGColor,
            (__bridge id)[UIColor colorWithRed:160/255.0 green:215/255.0 blue:215/255.0 alpha:0.2].CGColor,
            (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor
            
        ];
    }
    return _backLayer;
}

-(UIView *)lastestArea {
    if (_lastestArea == nil) {
        _lastestArea = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 10 Hper, 90 Wper, 33 Hper)];
        _lastestArea.backgroundColor = [UIColor whiteColor];
        _lastestArea.layer.cornerRadius = 10;
        _lastestArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _lastestArea.layer.shadowOffset = CGSizeMake(5, 5);
        _lastestArea.layer.shadowRadius = 5;
        _lastestArea.layer.shadowOpacity = 0.2;
//        CALayer *layer = [CALayer layer];
//        layer.frame = CGRectMake(0, 50 Hper, _lastestArea.bounds.size.width, 1);
//        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
//        [_lastestArea.layer addSublayer:layer];
//        [_lastestArea addSubview:self.userImgView];
        [_lastestArea addSubview:self.lastestLabel];
        [_lastestArea addSubview:self.lastestImage1];
        [_lastestArea addSubview:self.lastestImage2];
        [_lastestArea addSubview:self.lastestImage3];
//        [_lastestArea addSubview:self.usernameLabel];
//        [_lastestArea addSubview:self.pointsLabel];
//        [_lastestArea addSubview:self.pointsText];
    }
    return _lastestArea;
}

#pragma mark - lastestAreaSubView
//
//- (UIImageView *)userImgView {
//    if (_userImgView == nil) {
//        _userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(6 SubWper, 6 SubWper, 26 SubWper, 26 SubWper)];
//        _userImgView.image = userImg;
//        _userImgView.layer.cornerRadius = 13 SubWper;
//        _userImgView.layer.masksToBounds = YES;
//    }
//    return _userImgView;
//}

- (UILabel *)lastestLabel {
    if (_lastestLabel == nil) {
        _lastestLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 SubWper, 10 SubHper, 50 SubWper, 16 SubHper)];
        _lastestLabel.text = @"Lastest";
        _lastestLabel.font = [UIFont systemFontOfSize:30];
    }
    return _lastestLabel;
}

- (UIImageView* )lastestImage1 {
    if (_lastestImage1 == nil) {
        _lastestImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(3 SubWper, 35 SubHper, 50 SubWper, 50 SubHper)];
        _lastestImage1.layer.cornerRadius = 10;
        _lastestImage1.clipsToBounds = YES;
        _lastestImage1.contentMode = UIViewContentModeScaleAspectFill;
        _lastestImage1.image = [UIImage imageNamed:@"userTest.png"];
        //_lastestImage1.image = [UIImage imageNamed:@"userImg.png"];
    }
    return _lastestImage1;
}

- (UIImageView* )lastestImage2 {
    if (_lastestImage2 == nil) {
        _lastestImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(55 SubWper, 28 SubHper, 40 SubWper, 30 SubHper)];
//        _lastestImage2.contentMode = UIViewContentModeScaleAspectFill;
//        _lastestImage2.image = [UIImage imageNamed:@"userTest.png"];
        _lastestImage2.layer.cornerRadius = 10;
        _lastestImage2.clipsToBounds = YES;
        _lastestImage2.image = [UIImage imageNamed:@"userImg.png"];
    }
    return _lastestImage2;
}
- (UIImageView* )lastestImage3 {
    if (_lastestImage3 == nil) {
        _lastestImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(55 SubWper, 62 SubHper, 40 SubWper, 30 SubHper)];
//        _lastestImage3.contentMode = UIViewContentModeScaleAspectFill;
//        _lastestImage3.image = [UIImage imageNamed:@"userTest.png"];
        _lastestImage3.layer.cornerRadius = 10;
        _lastestImage3.clipsToBounds = YES;
        _lastestImage3.image = [UIImage imageNamed:@"userImg.png"];
    }
    return _lastestImage3;
}
//
//- (UILabel *)usernameLabel {
//    if (_usernameLabel == nil) {
//        _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 SubWper, 32 SubHper, 50 SubWper, 15 SubHper)];
//        _usernameLabel.text = username;
//        _usernameLabel.textColor = [UIColor grayColor];
//        _usernameLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightThin];
//    }
//    return _usernameLabel;
//}
//
//-(UILabel *)pointsLabel {
//    if (_pointsLabel == nil) {
//        _pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(35 SubWper, 71 SubHper, 30 SubWper, 12 SubHper)];
//        _pointsLabel.text = @"个人公益积分";
//        _pointsLabel.textColor = [UIColor grayColor];
//        _pointsLabel.font = [UIFont systemFontOfSize:14];
//        _pointsLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _pointsLabel;
//}
//
//- (UILabel *)pointsText {
//    if (_pointsText == nil) {
//        _pointsText = [[UILabel alloc]initWithFrame:CGRectMake(35 SubWper, 82 SubHper, 30 SubWper, 15 SubHper)];
//        _pointsText.font = [UIFont systemFontOfSize:26];
//        _pointsText.text = [NSString stringWithFormat:@"%ld", (long)points];
//        _pointsText.textAlignment = NSTextAlignmentCenter;
//    }
//    return _pointsText;
//}

#pragma mark end -

//- (UIView *)dashBoard {
//    if (_dashBoard == nil) {
//        _dashBoard = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 38 Hper, 90 Wper, 50 Hper)];
//        _dashBoard.backgroundColor = [UIColor whiteColor];
//        _dashBoard.layer.cornerRadius = 10;
//        _dashBoard.layer.shadowColor = [UIColor grayColor].CGColor;
//        _dashBoard.layer.shadowOffset = CGSizeMake(5, 5);
//        _dashBoard.layer.shadowRadius = 5;
//        _dashBoard.layer.shadowOpacity = 0.2;
//    }
//    return _dashBoard;
//}

- (UITableView *)entryList {
    if (_entryList == nil) {
        _entryList = [[UITableView alloc]initWithFrame:CGRectMake(5 Wper, 45 Hper, 90 Wper, 45 Hper)];
        _entryList.backgroundColor = [UIColor whiteColor];
        _entryList.layer.cornerRadius = 10;
        _entryList.layer.shadowColor = [UIColor grayColor].CGColor;
        _entryList.layer.shadowOffset = CGSizeMake(5, 5);
        _entryList.layer.shadowRadius = 5;
        _entryList.layer.shadowOpacity = 0.2;
        _entryList.clipsToBounds = YES;
        _entryList.delegate = (id)self;
        _entryList.dataSource = (id)self;
        [_entryList setScrollEnabled:YES];
    }
    return _entryList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.allDate.count;// number of date
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSInteger num=0;
//    for (int i = 0 ; i < self.allEntry.count ; i++){
//        if(false){// should be changed to allEntry[i].date == allDate[section]
//            num++;
//        }
//    }
//    return num;// number of date
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 90 Wper, 7 Hper)];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(2 Wper, 3 Wper, 5 Hper, 5 Hper)];
    img.contentMode = UIViewContentModeScaleAspectFill;
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.width/100 * 25, 0, cell.bounds.size.width/100 * 60, 7 Hper)];
    UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.width/100 * 90, 0, cell.bounds.size.width/100 * 20, 7 Hper)];
    //cost text need to be changable
    costLabel.textAlignment = NSTextAlignmentRight;
    [cell addSubview:img];
    [cell addSubview:descriptionLabel];
    [cell addSubview:costLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UILabel *iconNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.height/100 * 83,cell.bounds.size.height/100 * 83, cell.bounds.size.height/100 * 10, cell.bounds.size.height/100 * 10)];
//    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.width/100 * 25, 0, cell.bounds.size.width/100 * 60, 7 Hper)];
//    [iconNameLabel adjustsFontSizeToFitWidth];
//    img.image = [UIImage imageNamed:@"jiaotong.png"];
//    iconNameLabel.text = @"交通";
//    descriptionLabel.text = @"坐地铁";
    switch (indexPath.row) {
        case 0:
            img.image = [UIImage imageNamed:@"jiaotong.png"];
            descriptionLabel.text = @"地铁";
            costLabel.text = @"4";
            cell.separatorInset = UIEdgeInsetsMake(0, 2 Wper + 7 Hper, 0, 0);
            break;
        case 1:
            img.image = [UIImage imageNamed:@"yvle.png"];
            descriptionLabel.text = @"KTV";
            costLabel.text = @"66";
            cell.separatorInset = UIEdgeInsetsMake(0, 2 Wper + 7 Hper, 0, 0);
            break;
        default:
            descriptionLabel.text = @"NULL";
            cell.separatorInset = UIEdgeInsetsMake(0, 45 Wper, 0, 45 Wper);
    }
    return cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 7 Hper;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //  goToProfile: indexPath.row
}

- (void)deleteEntry {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认删除" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // remove this entry
        }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:conform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark end -

//- (ProfileVC *)profileVC {
//    if (_profileVC == nil) {
//        _profileVC = [[profileVC alloc]init];
//        _profileVC.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.97];
//    }
//    return _profileVC;
//}
@end

