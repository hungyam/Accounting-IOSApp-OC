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
}

@property (nonatomic, strong) NSMutableArray *allAcountData;

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
    self.allAcountData = [DataManage getAllAccounts];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view.layer addSublayer:self.backLayer];

    [self.view addSubview:self.lastestArea];
    [self.view addSubview:self.listArea];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.entryList reloadData];
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
        _lastestArea = [[UIView alloc]initWithFrame:CGRectMake(5 Wper, 10 Hper, 90 Wper, 10 Hper)];
        _lastestArea.backgroundColor = [UIColor whiteColor];
        _lastestArea.layer.cornerRadius = 10;
        _lastestArea.layer.shadowColor = [UIColor grayColor].CGColor;
        _lastestArea.layer.shadowOffset = CGSizeMake(5, 5);
        _lastestArea.layer.shadowRadius = 5;
        _lastestArea.layer.shadowOpacity = 0.2;
        [_lastestArea addSubview:self.lastestLabel];
        [_lastestArea addSubview:self.lastestImage1];
        [_lastestArea addSubview:self.lastestImage2];
        [_lastestArea addSubview:self.lastestImage3];

    }
    return _lastestArea;
}

- (UIView *)listArea {
    if (_listArea == nil) {
        _listArea = [[UIView alloc] initWithFrame:CGRectMake(0, 25 Hper, 100 Wper, 70 Hper)];
        _listArea.backgroundColor = [UIColor whiteColor];
        [_listArea addSubview:self.entryList];

        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:_listArea.bounds];
        [shapeLayer setPosition:CGPointMake(60 ListSubWper, 65 ListSubHper)];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];
        [shapeLayer setStrokeColor:[UIColor colorWithRed:58/255.0 green:188/255.0 blue:175/255.0 alpha:1].CGColor];
        [shapeLayer setLineWidth:3];
        [shapeLayer setLineJoin:kCALineJoinRound];
        [shapeLayer setLineDashPattern:@[@3, @5]];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, 0, 100 ListSubHper);
        [shapeLayer setPath:path];
        CGPathRelease(path);
        shapeLayer.zPosition = -100;
        [_listArea.layer addSublayer:shapeLayer];

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

#pragma mark end -


- (UITableView *)entryList {
    if (_entryList == nil) {
        _entryList = [[UITableView alloc]initWithFrame:CGRectMake(0, 8 ListSubHper, 100 ListSubWper, 92 ListSubHper)];
        _entryList.backgroundColor = [UIColor clearColor];
        _entryList.delegate = self;
        _entryList.dataSource = self;
        _entryList.separatorInset = UIEdgeInsetsMake(0, 45 Wper, 0, 45 Wper);
        [_entryList setScrollEnabled:YES];
    }
    return _entryList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.allDate.count;// number of date
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSInteger num=0;
//    for (int i = 0 ; i < self.allEntry.count ; i++){
//        if(false){// should be changed to allEntry[i].date == allDate[section]
//            num++;
//        }
//    }
//    return num;// number of date
    return self.allAcountData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 100 ListSubWper, 10 ListSubHper)];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20 ListSubWper, 1 ListSubHper, 8 ListSubHper, 8 ListSubHper)];
    img.contentMode = UIViewContentModeScaleAspectFill;
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(35 ListSubWper, 0, 60 ListSubWper, 8 ListSubHper)];
    UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 ListSubWper, 0, 30 ListSubWper, 8 ListSubHper)];
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
    img.image = [DataManage getIconByLabel:((AccountType *)self.allAcountData[indexPath.row]).type];
    descriptionLabel.text = ((AccountType *)self.allAcountData[indexPath.row]).type;
    costLabel.text = [NSString stringWithFormat:@"%.2f",((AccountType *)self.allAcountData[indexPath.row]).amount ];
    cell.separatorInset = UIEdgeInsetsMake(0, 2 Wper + 7 Hper, 0, 0);
        
    return cell;
}


#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100 ListSubWper, 10 ListSubHper)];
    CALayer *c1 = [CALayer layer];
    c1.frame = CGRectMake(10 ListSubWper - 7, 5 ListSubHper - 7, 14, 14);
    c1.backgroundColor = [UIColor colorWithRed:58/255.0 green:188/255.0 blue:175/255.0 alpha:1].CGColor;
    c1.cornerRadius = 7;
    CALayer *c2 = [CALayer layer];
    c2.frame = CGRectMake(10 ListSubWper - 14, 5 ListSubHper - 14, 28, 28);
    c2.backgroundColor = [UIColor colorWithRed:210/255.0 green:239/255.0 blue:236/255.0 alpha:1].CGColor;
    c2.cornerRadius = 14;
    CALayer *c3 = [CALayer layer];
    c3.frame = CGRectMake(10 ListSubWper - 21, 5 ListSubHper - 21, 42, 42);
    c3.backgroundColor = [UIColor colorWithRed:240/255.0 green:250/255.0 blue:249/255.0 alpha:1].CGColor;
    c3.cornerRadius = 21;
    CALayer *c4 = [CALayer layer];
    c4.frame = CGRectMake(0, 0, 100 ListSubWper, 10 ListSubHper + 1);
    c4.backgroundColor = [UIColor whiteColor].CGColor;
    view.backgroundColor = [UIColor whiteColor];
    [view.layer addSublayer:c4];
    [view.layer addSublayer:c3];
    [view.layer addSublayer:c2];
    [view.layer addSublayer:c1];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10 ListSubHper;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10 ListSubHper;
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


#pragma mark end -

@end

