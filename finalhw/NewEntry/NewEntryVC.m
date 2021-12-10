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

@interface NewEntryVC ()

@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) UIButton * chooseone;
@property (nonatomic, strong) UICollectionView* collect;

@end

@implementation NewEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1];
    [self.view addSubview: self.collect];
    
}

- (NSMutableArray *)listArr {
    if (_listArr == nil) {
        _listArr = [DataManage getIconArray];
        NSLog(@"%ld",_listArr.count);
    }
    return _listArr;
}
-(UICollectionView*)collect{
    if(_collect==nil){
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collect = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collect.backgroundColor=[UIColor clearColor];
        _collect.delegate=self;
        _collect.dataSource=self;
        [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    }
    return _collect;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UIButton*button=[self seticonbutton:indexPath.item];
    [cell addSubview:button];
    return cell;
}

-(UIButton*)seticonbutton:(NSInteger)index{
    UIImage*img=((IconType*)[self.listArr objectAtIndex:index]).icon;
    NSString*name=((IconType*)[self.listArr objectAtIndex:index]).label;
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 100 Wper/3-5 ,100 Wper/3-5)];
    button.tag=index;
    button.backgroundColor=[UIColor whiteColor];
    button.layer.borderColor= [UIColor clearColor].CGColor;
    button.layer.borderWidth=1;
    button.layer.cornerRadius=20;
    button.titleLabel.font=[UIFont fontWithName:@"Hiragino Sans" size:4.5 Wper];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    [button setImage:img forState:UIControlStateNormal];

    [button setImageEdgeInsets:UIEdgeInsetsMake(4 Wper,7 Wper,10 Wper, 7 Wper)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+15,-button.imageView.frame.size.width,0,0)];
    [button addTarget:self action:@selector(inputdata:) forControlEvents:UIControlEventTouchDown];
    button.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    button.layer.shadowOffset = CGSizeMake(0, 0);
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowRadius = 0.0;
    return button;
}
- (void)inputdata:(id)sender {
    if(self.chooseone!=nil){
        self.chooseone.layer.shadowRadius = 0.0;
    }
    UIButton *button = (UIButton *) sender;
    self.chooseone=button;
    self.chooseone.layer.shadowRadius = 5.0;
    //self.collect.frame=CGRectMake(0,0,100 Wper, 50 Hper);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100 Wper/3-5 ,100 Wper/3-5);
}
 
 
// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
 
// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
@end
