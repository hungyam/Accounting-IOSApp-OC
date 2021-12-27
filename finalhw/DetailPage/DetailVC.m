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
#define ToolAreaSubWper *_toolArea.bounds.size.width/100
#define ToolAreaSubHper *_toolArea.bounds.size.height/100
#define ListSubWper *_listArea.bounds.size.width/100
#define ListSubHper *_listArea.bounds.size.height/100
#define BackColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]

@interface DetailVC () {
    NSInteger selectDateYear;
    NSInteger selectDateMonth;
}

@property (nonatomic, strong) NSMutableArray *allAccountDataTypeDate;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, strong) CAGradientLayer *backLayer;
@property (nonatomic, strong) UIView *toolArea;
@property (nonatomic, strong) UIButton *dateBtn;
@property (nonatomic, strong) UIView *listArea;
@property (nonatomic, strong) UITableView *entryList;


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
//    [self.view addSubview:self.lastestArea];
    [self.view addSubview:self.listArea];
    [self.view addSubview:self.toolArea];
    [self.navigationController setNavigationBarHidden:YES animated:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.allAccountDataTypeDate = [DataManage getAllAccountsTypeDate];
    [self loadListData];
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

#pragma mark - Views

- (UIView *)toolArea {
    if (_toolArea == nil) {
        _toolArea = [[UIView alloc] initWithFrame:CGRectMake(15 Wper, 7 Hper, 70 Wper, 15 Hper)];
        _toolArea.layer.borderWidth = 1;
        _toolArea.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.6].CGColor;
        _toolArea.layer.cornerRadius = 15;
        _toolArea.layer.masksToBounds = YES;
        _toolArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _toolArea.layer.shadowOffset = CGSizeMake(5, 5);
        _toolArea.layer.shadowRadius = 5;
        _toolArea.layer.shadowOpacity = 0.3;
        _toolArea.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        [_toolArea addSubview:self.dateBtn];
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 ToolAreaSubWper, 10 ToolAreaSubHper, 10 ToolAreaSubWper, 30 ToolAreaSubHper)];
        [leftBtn setImage:[UIImage systemImageNamed:@"chevron.left.2"] forState:UIControlStateNormal];
        [leftBtn setTintColor:[UIColor grayColor]];
        leftBtn.tag = 0;
        [leftBtn addTarget:self action:@selector(LRButtonAction:) forControlEvents:UIControlEventTouchDown];

        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(70 ToolAreaSubWper, 10 ToolAreaSubHper, 10 ToolAreaSubWper, 30 ToolAreaSubHper)];
        [rightBtn setImage:[UIImage systemImageNamed:@"chevron.right.2"] forState:UIControlStateNormal];
        [rightBtn setTintColor:[UIColor grayColor]];
        rightBtn.tag = 1;
        [rightBtn addTarget:self action:@selector(LRButtonAction:) forControlEvents:UIControlEventTouchDown];
        [_toolArea addSubview:leftBtn];
        [_toolArea addSubview:rightBtn];
    }
    return _toolArea;
}
- (void)LRButtonAction:(UIButton *)button {
    if (button.tag == 1) {
        selectDateMonth++;
        if (selectDateMonth == 13) {
            selectDateMonth = 1;
            selectDateYear++;
            if (selectDateYear == 2022) {
                selectDateYear = 2021;
                selectDateMonth = 12;
                return;
            }
        }
    }else {
        selectDateMonth--;
        if (selectDateMonth == 0) {
            selectDateMonth = 12;
            selectDateYear--;
            if (selectDateYear == 2019) {
                selectDateYear = 2020;
                selectDateMonth = 1;
                return;
            }
        }
    }
    NSArray *month = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    [self.dateBtn setTitle:month[selectDateMonth-1] forState:UIControlStateNormal];
    [self loadListData];
    [self.entryList reloadData];
}

- (UIButton *)dateBtn {
    if (_dateBtn == nil) {
        _dateBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 ToolAreaSubWper, 10 ToolAreaSubHper, 40 ToolAreaSubWper, 30 ToolAreaSubHper)];
        NSArray *month = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
        [_dateBtn setTitle:month[selectDateMonth-1] forState:UIControlStateNormal];
        [_dateBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _dateBtn.titleLabel.font = [UIFont systemFontOfSize:27 weight:UIFontWeightBold];
    }
    return _dateBtn;
}

- (UIView *)listArea {
    if (_listArea == nil) {
        _listArea = [[UIView alloc] initWithFrame:CGRectMake(0, 25 Hper, 100 Wper, 75 Hper)];
        _listArea.backgroundColor = [UIColor whiteColor];
        _listArea.layer.cornerRadius = 50;
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0 , 50, 50);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_listArea.layer addSublayer:layer];
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(5 ListSubWper, 1 ListSubHper, 40 ListSubWper, 5 ListSubHper)];
        text.text = @"本月账单";
        text.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        [_listArea addSubview:text];
        [_listArea addSubview:self.entryList];
    }
    return _listArea;
}

- (UITableView *)entryList {
    if (_entryList == nil) {
        _entryList = [[UITableView alloc]initWithFrame:CGRectMake(0, 6 ListSubHper, 100 ListSubWper, 94 ListSubHper) style:UITableViewStylePlain];
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
    img.layer.shadowColor = [UIColor grayColor].CGColor;
    img.layer.shadowOffset = CGSizeMake(3, 3);
    img.layer.shadowRadius = 4;
    img.layer.shadowOpacity = 0.3;

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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 8 ListSubHper;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                  title:nil
                                                                                handler:
    ^(UIContextualAction *_Nonnull action, __kindof UIView *_Nonnull sourceView, void (^_Nonnull completionHandler)(BOOL)) {
        [(NSMutableArray *)self.listData[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.entryList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        if ([(NSMutableArray *)self.listData[indexPath.section] count] == 0) {
            [self.listData removeObjectAtIndex:indexPath.section];
            [self.entryList deleteSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        completionHandler(YES);
    }];
    deleteRowAction.image = [UIImage systemImageNamed:@"trash"];
    deleteRowAction.backgroundColor = [UIColor systemRedColor];

    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
    transform = CATransform3DTranslate(transform, 10, 0, 0);//左边水平移动
//    transform = CATransform3DScale(transform, 0, 0, 0);//由小变大

    cell.layer.transform = transform;
    cell.layer.opacity = 0.5;

    [UIView animateWithDuration:0.3 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1;
    }];
}

@end

