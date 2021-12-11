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
#define BackColor [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:105/255.0 blue:123/255.0 alpha:1]


@interface NewEntryVC ()

@property(nonatomic, strong) NSMutableArray *listArr;
@property(nonatomic, strong) UIButton *chooseone;
@property(nonatomic, strong) UICollectionView *collect;
@property(nonatomic, strong) UIView *subArea;

@end

@implementation NewEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.collect];
    self.title = @"添加新纪录";
}

- (NSMutableArray *)listArr {
    if (_listArr == nil) {
        _listArr = [DataManage getIconArray];
    }
    return _listArr;
}

- (UICollectionView *)collect {
    if (_collect == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(3 Wper, 0, 94 Wper, 100 Hper) collectionViewLayout:layout];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = (id)self;
        _collect.dataSource = (id)self;
        [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    }
    return _collect;
}

- (UIView *)subArea {
    if (_subArea == nil) {
        _subArea = [[UIView alloc]initWithFrame:CGRectMake(0, 60 Hper, 100 Wper, 40 Hper)];
        _subArea.backgroundColor = [UIColor purpleColor];
    }
    return _subArea;
}

#pragma mark - UICollectionVC DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UIButton *button = [self seticonbutton:indexPath.item];
    [cell addSubview:button];
    return cell;
}

- (UIButton *)seticonbutton:(NSInteger)index {
    UIImage *img = ((IconType *) self.listArr[index]).icon;
    NSString *name = ((IconType *) self.listArr[index]).label;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 94 Wper / 4 - 5, 94 Wper / 4 - 5)];
    button.tag = index;
    button.backgroundColor = BackColor;
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 20;
    button.titleLabel.font = [UIFont fontWithName:@"Hiragino Sans" size:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(3 Wper, 6 Wper, 9 Wper, 6 Wper)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height + 15, -button.imageView.frame.size.width, 0, 0)];
    [button addTarget:self action:@selector(inputdata:) forControlEvents:UIControlEventTouchDown];
    button.layer.shadowColor = [UIColor whiteColor].CGColor;//阴影颜色
    button.layer.shadowOffset = CGSizeMake(0, 0);
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowRadius = 0.0;
    return button;
}

- (void)inputdata:(id)sender {
    if (self.chooseone != nil) {
        self.chooseone.layer.shadowRadius = 0;
        self.chooseone.backgroundColor = BackColor;
        self.chooseone.layer.shadowOpacity = 0;
    }
    UIButton *button = (UIButton *)sender;
    self.chooseone = button;
    [UIView animateWithDuration:0.5
                           delay:0
                         options:UIViewAnimationOptionBeginFromCurrentState
                      animations:^{
        self.chooseone.layer.shadowColor = [UIColor grayColor].CGColor;
        self.chooseone.layer.shadowOffset = CGSizeMake(1, 1);
        self.chooseone.layer.shadowOpacity = 0.2;
        self.chooseone.layer.shadowRadius = 6;
        self.chooseone.backgroundColor = [UIColor whiteColor];
        self.collect.frame = CGRectMake(3 Wper, 0, 94 Wper, 60 Hper);
        [self.view addSubview:self.subArea];
     }
                      completion:nil];
}

#pragma mark - UICollectionVC Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(94 Wper / 4 - 5, 94 Wper / 4 - 5);
}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
@end
