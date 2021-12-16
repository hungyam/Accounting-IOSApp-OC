//
//  PersonalVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "PersonalVC.h"
#import "TabBarVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define LastestSubWper *_userArea.bounds.size.width/100
#define LastestSubHper *_userArea.bounds.size.height/100

@interface PersonalVC () {
    NSString *nickname;
    UIImage *userImg;
    NSString *username;
    NSInteger points;
}

@property (nonatomic, strong) CAGradientLayer *backLayer;
@property (nonatomic, strong) UIView *userArea;
    @property (nonatomic, strong) UIImageView *userImgView;
    @property (nonatomic, strong) UILabel *nicknameLabel;
    @property (nonatomic, strong) UILabel *usernameLabel;
    @property (nonatomic, strong) UILabel *pointsLabel;
    @property (nonatomic, strong) UILabel *pointsText;
@property (nonatomic, strong) UIView *dashBoard;
@property (nonatomic, strong) UITableView *funcList;
@property (nonatomic, strong) SettingVC *settingVC;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUserMes];
    [self.view.layer addSublayer:self.backLayer];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view addSubview:self.userArea];
    [self.view addSubview:self.dashBoard];
    [self.view addSubview:self.funcList];
}

- (void)loadUserMes {
    PersonalMes *mes = [DataManage getPersonalMes];
    nickname = mes.nickname;
    userImg = mes.userImg;
    username = mes.username;
    points = mes.points;
}

- (CAGradientLayer *)backLayer {
    if (_backLayer == nil) {
        _backLayer = [CAGradientLayer layer];
        _backLayer.frame = CGRectMake(0, 0, 100 Wper, 27 Hper);
        _backLayer.startPoint = CGPointMake(0, 0);
        _backLayer.endPoint = CGPointMake(1, 1);
        _backLayer.zPosition = -1;
        _backLayer.colors = @[
            (__bridge id)[UIColor colorWithRed:255/255.0 green:199/255.0 blue:153/255.0 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:95/255.0 alpha:1].CGColor
        ];
    }
    return _backLayer;
}

-(UIView *)userArea {
    if (_userArea == nil) {
        _userArea = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 10 Hper, 90 Wper, 25 Hper)];
        _userArea.backgroundColor = [UIColor whiteColor];
        _userArea.layer.cornerRadius = 10;
        _userArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _userArea.layer.shadowOffset = CGSizeMake(5, 5);
        _userArea.layer.shadowRadius = 5;
        _userArea.layer.shadowOpacity = 0.2;
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 17 Hper, _userArea.bounds.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
        [_userArea.layer addSublayer:layer];
        [_userArea addSubview:self.userImgView];
        [_userArea addSubview:self.nicknameLabel];
        [_userArea addSubview:self.usernameLabel];
        [_userArea addSubview:self.pointsLabel];
        [_userArea addSubview:self.pointsText];
    }
    return _userArea;
}

#pragma mark - UserAreaSubView

- (UIImageView *)userImgView {
    if (_userImgView == nil) {
        _userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(6 LastestSubWper, 6 LastestSubWper, 26 LastestSubWper, 26 LastestSubWper)];
        _userImgView.image = userImg;
        _userImgView.layer.cornerRadius = 13 LastestSubWper;
        _userImgView.layer.masksToBounds = YES;
    }
    return _userImgView;
}

- (UILabel *)nicknameLabel {
    if (_nicknameLabel == nil) {
        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 LastestSubWper, 17 LastestSubHper, 50 LastestSubWper, 16 LastestSubHper)];
        _nicknameLabel.text = nickname;
        _nicknameLabel.font = [UIFont systemFontOfSize:30];
    }
    return _nicknameLabel;
}

- (UILabel *)usernameLabel {
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 LastestSubWper, 32 LastestSubHper, 50 LastestSubWper, 15 LastestSubHper)];
        _usernameLabel.text = username;
        _usernameLabel.textColor = [UIColor grayColor];
        _usernameLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightThin];
    }
    return _usernameLabel;
}

-(UILabel *)pointsLabel {
    if (_pointsLabel == nil) {
        _pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(35 LastestSubWper, 71 LastestSubHper, 30 LastestSubWper, 12 LastestSubHper)];
        _pointsLabel.text = @"个人公益积分";
        _pointsLabel.textColor = [UIColor grayColor];
        _pointsLabel.font = [UIFont systemFontOfSize:14];
        _pointsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pointsLabel;
}

- (UILabel *)pointsText {
    if (_pointsText == nil) {
        _pointsText = [[UILabel alloc]initWithFrame:CGRectMake(35 LastestSubWper, 82 LastestSubHper, 30 LastestSubWper, 15 LastestSubHper)];
        _pointsText.font = [UIFont systemFontOfSize:26];
        _pointsText.text = [NSString stringWithFormat:@"%ld", (long)points];
        _pointsText.textAlignment = NSTextAlignmentCenter;
    }
    return _pointsText;
}

#pragma mark end -

- (UIView *)dashBoard {
    if (_dashBoard == nil) {
        _dashBoard = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 38 Hper, 90 Wper, 20 Hper)];
        _dashBoard.backgroundColor = [UIColor whiteColor];
        _dashBoard.layer.cornerRadius = 10;
        _dashBoard.layer.shadowColor = [UIColor grayColor].CGColor;
        _dashBoard.layer.shadowOffset = CGSizeMake(5, 5);
        _dashBoard.layer.shadowRadius = 5;
        _dashBoard.layer.shadowOpacity = 0.2;
    }
    return _dashBoard;
}

- (UITableView *)funcList {
    if (_funcList == nil) {
        _funcList = [[UITableView alloc]initWithFrame:CGRectMake(5 Wper, 65 Hper, 90 Wper, 21 Hper)];
        _funcList.backgroundColor = [UIColor whiteColor];
        _funcList.layer.cornerRadius = 10;
        _funcList.layer.shadowColor = [UIColor grayColor].CGColor;
        _funcList.layer.shadowOffset = CGSizeMake(5, 5);
        _funcList.layer.shadowRadius = 5;
        _funcList.layer.shadowOpacity = 0.2;
        _funcList.clipsToBounds = NO;
        _funcList.delegate = (id)self;
        _funcList.dataSource = (id)self;
        [_funcList setScrollEnabled:NO];
    }
    return _funcList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 90 Wper, 7 Hper)];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(2 Wper, 0, 7 Hper, 7 Hper)];
    img.contentMode = UIViewContentModeScaleAspectFill;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.size.width/100 * 25, 0, cell.bounds.size.width/100 * 60, 7 Hper)];
    [cell addSubview:img];
    [cell addSubview:label];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            img.image = [UIImage imageNamed:@"detailIcon.png"];
            label.text = @"个人资料";
            cell.separatorInset = UIEdgeInsetsMake(0, 2 Wper + 7 Hper, 0, 0);
            break;
        case 1:
            img.image = [UIImage imageNamed:@"settingIcon.png"];
            label.text = @"设置";
            cell.separatorInset = UIEdgeInsetsMake(0, 2 Wper + 7 Hper, 0, 0);
            break;
        default:
            label.text = @"退出登录";
            cell.separatorInset = UIEdgeInsetsMake(0, 45 Wper, 0, 45 Wper);
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 7 Hper;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            [self presentViewController:self.settingVC animated:YES completion:nil];
            break;
        default:
            [self signOut];
    }
}

- (void)signOut {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认退出" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [(TabBarVC *)self.parentViewController showStartNaviVC];
        }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:conform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark end -

- (SettingVC *)settingVC {
    if (_settingVC == nil) {
        _settingVC = [[SettingVC alloc]init];
        _settingVC.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.97];
    }
    return _settingVC;
}
@end
