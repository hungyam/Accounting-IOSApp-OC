//
//  DetailVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "DetailVC.h"
#import "StartNaviVC.h"
#import "DetailNaviVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
#define LastestSubWper *_lastestArea.bounds.size.width/100
#define LastestSubHper *_lastestArea.bounds.size.height/100
#define ListSubWper *_listArea.bounds.size.width/100
#define ListSubHper *_listArea.bounds.size.height/100
#define BackColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]

@interface DetailVC () {
    NSInteger accountIndex;
    NSInteger selectDateYear;
    NSInteger selectDateMonth;
}

@property (nonatomic, strong) NSMutableArray *allAccountData;
@property (nonatomic, strong) NSMutableArray *allAccountDataTypeDate;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, strong) CAGradientLayer *backLayer;
@property (nonatomic, strong) UIView *lastestArea;
    @property (nonatomic, strong) UIImageView *lastestImage1;
    @property (nonatomic, strong) UIImageView *lastestImage2;
    @property (nonatomic, strong) UIImageView *lastestImage3;
    @property (nonatomic, strong) UILabel *lastestLabel;
@property (nonatomic, strong) UIView *dashBoard;

@property (nonatomic, strong) UIView *listArea;
@property (nonatomic, strong) UITableView *entryList;
@property (nonatomic, strong) NSMutableArray *allEntry;
@property (nonatomic, strong) NSMutableArray *allDate;
//@property (nonatomic, strong) profileVC *profileVC;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectDateYear = 2021;
    selectDateMonth = 1;
    self.allAccountDataTypeDate = [DataManage getAllAccountsTypeDate];
    [self loadListData];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];


    [self.view.layer addSublayer:self.backLayer];
    [self.view addSubview:self.lastestArea];
    [self.view addSubview:self.listArea];

}

- (void)viewWillAppear:(BOOL)animated {
    [self.entryList reloadData];
}

- (void)loadListData {
    self.listData = [[NSMutableArray alloc] init];
    for (int i =30; i > 0; i--) {
        if (((NSMutableArray *)self.allAccountDataTypeDate[selectDateYear-2020][selectDateMonth-1][i]).count > 0) {
            [self.listData addObject:self.allAccountDataTypeDate[selectDateYear-2020][selectDateMonth-1][i]];
        }
    }
}

- (CAGradientLayer *)backLayer {
    if (_backLayer == nil) {
        _backLayer = [CAGradientLayer layer];
        _backLayer.frame = CGRectMake(0, 0, 100 Wper, 100 Hper);
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
        _lastestArea = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 7 Hper, 90 Wper, 15 Hper)];
        _lastestArea.backgroundColor = [UIColor whiteColor];
        _lastestArea.layer.cornerRadius = 10;
        _lastestArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _lastestArea.layer.shadowOffset = CGSizeMake(5, 5);
        _lastestArea.layer.shadowRadius = 5;
        _lastestArea.layer.shadowOpacity = 0.2;
//        [_lastestArea addSubview:self.lastestLabel];
//        [_lastestArea addSubview:self.lastestImage1];
//        [_lastestArea addSubview:self.lastestImage2];
//        [_lastestArea addSubview:self.lastestImage3];

    }
    return _lastestArea;
}

- (UIView *)listArea {
    if (_listArea == nil) {
        _listArea = [[UIView alloc] initWithFrame:CGRectMake(0, 25 Hper, 100 Wper, 70 Hper)];
        _listArea.backgroundColor = [UIColor whiteColor];
        [_listArea addSubview:self.entryList];



    }
    return _listArea;
}

#pragma mark - lastestAreaSubView

- (UILabel *)lastestLabel {
    if (_lastestLabel == nil) {
        _lastestLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 LastestSubWper, 10 LastestSubHper, 50 LastestSubWper, 16 LastestSubHper)];
        _lastestLabel.text = @"Lastest";
        _lastestLabel.font = [UIFont systemFontOfSize:30];
    }
    return _lastestLabel;
}

- (UIImageView* )lastestImage1 {
    if (_lastestImage1 == nil) {
        _lastestImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(3 LastestSubWper, 35 LastestSubHper, 50 LastestSubWper, 50 LastestSubHper)];
        _lastestImage1.layer.cornerRadius = 10;
        _lastestImage1.clipsToBounds = YES;
        _lastestImage1.contentMode = UIViewContentModeScaleAspectFill;
        _lastestImage1.image = [UIImage imageNamed:@"userTest.png"];
    }
    return _lastestImage1;
}

- (UIImageView* )lastestImage2 {
    if (_lastestImage2 == nil) {
        _lastestImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(55 LastestSubWper, 28 LastestSubHper, 40 LastestSubWper, 30 LastestSubHper)];
        _lastestImage2.layer.cornerRadius = 10;
        _lastestImage2.clipsToBounds = YES;
        _lastestImage2.image = [UIImage imageNamed:@"userImg.png"];
    }
    return _lastestImage2;
}
- (UIImageView* )lastestImage3 {
    if (_lastestImage3 == nil) {
        _lastestImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(55 LastestSubWper, 62 LastestSubHper, 40 LastestSubWper, 30 LastestSubHper)];
        _lastestImage3.layer.cornerRadius = 10;
        _lastestImage3.clipsToBounds = YES;
        _lastestImage3.image = [UIImage imageNamed:@"userImg.png"];
    }
    return _lastestImage3;
}

- (UITableView *)entryList {
    if (_entryList == nil) {
        _entryList = [[UITableView alloc]initWithFrame:CGRectMake(0, 6 ListSubHper, 100 ListSubWper, 90 ListSubHper) style:UITableViewStyleGrouped];
        _entryList.backgroundColor = [UIColor clearColor];
        _entryList.delegate = self;
        _entryList.dataSource = self;
        _entryList.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_entryList setScrollEnabled:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:_listArea.bounds];
        [shapeLayer setPosition:CGPointMake(60 ListSubWper, 55 ListSubHper)];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];
        [shapeLayer setStrokeColor:[UIColor colorWithRed:58/255.0 green:188/255.0 blue:175/255.0 alpha:1].CGColor];
        [shapeLayer setLineWidth:3];
        [shapeLayer setLineJoin:kCALineJoinRound];
        [shapeLayer setLineDashPattern:@[@3, @5]];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, 0, 5000 ListSubHper);
        [shapeLayer setPath:path];
        CGPathRelease(path);
        shapeLayer.zPosition = -100;
        [_entryList.layer addSublayer:shapeLayer];
    }
    return _entryList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSMutableArray *)self.listData[section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 100 ListSubWper, 8 ListSubHper)];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(25 ListSubWper, 1 ListSubHper, 6 ListSubHper, 6 ListSubHper)];
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.image = [DataManage getIconByLabel:((AccountType *)self.listData[indexPath.section][indexPath.row]).type];

    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(38 ListSubWper, 1 ListSubHper, 60 ListSubWper, 4 ListSubHper)];
    descriptionLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
    descriptionLabel.text = ((AccountType *)self.listData[indexPath.section][indexPath.row]).type;

    UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(38 ListSubWper, 4.5 ListSubHper, 60 ListSubWper, 3 ListSubHper)];
    tipsLabel.font = [UIFont systemFontOfSize:12];
    tipsLabel.text = ((AccountType *)self.listData[indexPath.section][indexPath.row]).tips;
    tipsLabel.textColor = [UIColor colorWithWhite:155/255.0 alpha:1];

    UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(65 ListSubWper, 0 ListSubHper, 30 ListSubWper, 5 ListSubHper)];
    costLabel.textAlignment = NSTextAlignmentRight;
    if (((AccountType *)self.listData[indexPath.section][indexPath.row]).inOrOut) {
        costLabel.text = [NSString stringWithFormat:@"-¥%.2f",((AccountType *)self.listData[indexPath.section][indexPath.row]).amount ];
    }else {
        costLabel.text = [NSString stringWithFormat:@"+¥%.2f",((AccountType *)self.listData[indexPath.section][indexPath.row]).amount ];
        costLabel.textColor = [UIColor colorWithRed:243/255.0 green:179/255.0 blue:37/255.0 alpha:1];
    }
    costLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:20];

    UILabel *costTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(65 ListSubWper, 5 ListSubHper, 30 ListSubWper, 2 ListSubHper)];
    costTypeLabel.textAlignment = NSTextAlignmentRight;
    costTypeLabel.text = ((AccountType *)self.listData[indexPath.section][indexPath.row]).inOrOut ? @"支出" : @"收入";
    costTypeLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:13];

    CALayer *backLayer = [CALayer layer];
    backLayer.frame = CGRectMake(20 ListSubWper, 0, 80 ListSubWper, 8 ListSubHper);
    backLayer.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:0.9].CGColor;
    backLayer.zPosition = -101;
    if (indexPath.row+1 == [self tableView:tableView numberOfRowsInSection:indexPath.section]) {
        backLayer.cornerRadius = 15;
        CALayer *sub1 = [CALayer layer];
        sub1.frame = CGRectMake(0, 0, 30, 30);
        sub1.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:0.9].CGColor;
        sub1.zPosition = -101;
        [backLayer addSublayer:sub1];
        CALayer *sub2 = [CALayer layer];
        sub2.frame = CGRectMake(80 ListSubWper - 30, 0, 30, 8 ListSubHper);
        sub2.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:0.9].CGColor;
        sub2.zPosition = -101;
        [backLayer addSublayer:sub2];
    }

    [cell addSubview:img];
    [cell addSubview:descriptionLabel];
    [cell addSubview:costLabel];
    [cell addSubview:tipsLabel];
    [cell addSubview:costTypeLabel];
    [cell.layer addSublayer:backLayer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100 ListSubWper, 6 ListSubHper)];
    CALayer *c1 = [CALayer layer];
    c1.frame = CGRectMake(10 ListSubWper - 6, 3 ListSubHper - 6, 12, 12);
    c1.backgroundColor = [UIColor colorWithRed:58/255.0 green:188/255.0 blue:175/255.0 alpha:1].CGColor;
    c1.cornerRadius = 6;
    c1.zPosition = 102;
    CALayer *c2 = [CALayer layer];
    c2.frame = CGRectMake(10 ListSubWper - 12, 3 ListSubHper - 12, 24, 24);
    c2.backgroundColor = [UIColor colorWithRed:210/255.0 green:239/255.0 blue:236/255.0 alpha:1].CGColor;
    c2.cornerRadius = 12;
    c2.zPosition = 101;
    CALayer *c3 = [CALayer layer];
    c3.frame = CGRectMake(10 ListSubWper - 18, 3 ListSubHper - 18, 36, 36);
    c3.backgroundColor = [UIColor colorWithRed:240/255.0 green:250/255.0 blue:249/255.0 alpha:1].CGColor;
    c3.cornerRadius = 18;
    CAGradientLayer *c4 = [CAGradientLayer layer];
    c4.frame = CGRectMake(0, 0, 100 ListSubWper, 6 ListSubHper);
    c4.startPoint = CGPointMake(0, 0);
    c4.endPoint = CGPointMake(0, 1);
    c4.zPosition = -1;
    c4.colors = @[
            (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor,
            (__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor,
    ];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 ListSubWper, 0, 40 ListSubWper, 6 ListSubHper)];
    NSString *date = [NSString stringWithFormat:@"%d-%d-%d",((AccountType *)self.listData[section][0]).dateYear,((AccountType *)self.listData[section][0]).dateMonth,((AccountType *)self.listData[section][0]).dateDay];
    label.text = date;
    label.textColor = [UIColor colorWithRed:58/255.0 green:188/255.0 blue:175/255.0 alpha:1];
    view.backgroundColor = [UIColor clearColor];
    [view.layer addSublayer:c4];
    [view.layer addSublayer:c3];
    [view.layer addSublayer:c2];
    [view.layer addSublayer:c1];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6 ListSubHper;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 8 ListSubHper;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //  goToProfile: indexPath.row
    [(DetailNaviVC *)self.parentViewController pushAccountDetailPage:indexPath.row];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                  title:@"delete"
                                                                                handler:
    ^(UIContextualAction *_Nonnull action, __kindof UIView *_Nonnull sourceView, void (^_Nonnull completionHandler)(BOOL)) {
        NSLog(@"delete");
        [(NSMutableArray *)self.listData[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.entryList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        if ([(NSMutableArray *)self.listData[indexPath.section] count] == 0) {
            [self.listData removeObjectAtIndex:indexPath.section];
            [self.entryList deleteSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        completionHandler(YES);
    }];

    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
    transform = CATransform3DTranslate(transform, 0, 20, 0);//左边水平移动
//    transform = CATransform3DScale(transform, 0, 0, 0);//由小变大

    cell.layer.transform = transform;
    cell.layer.opacity = 0.0;

    [UIView animateWithDuration:0.3 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1;
    }];
}

@end

