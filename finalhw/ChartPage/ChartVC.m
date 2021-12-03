//
//  ChartVC.m
//  finalhw
//
//  Created by hungyam on 2021/11/23.
//

#import "ChartVC.h"
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ChartVC ()

@property (nonatomic, strong) UIScrollView*chartView;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@property (nonatomic,assign)int lineoffset;//横线偏移量
@property (nonatomic,assign)float ySpace;//y轴间隔
@property (nonatomic,assign)int yNum;//y轴一个间隔的数值
@property (nonatomic,assign)int xCount;//x轴的点数
@property (nonatomic,assign)float xSpace;//x轴间隔

@property (nonatomic, strong) UIView*picViewinUse;

@property (nonatomic,strong)UILabel*labelinUse;
@property (nonatomic,strong)UIButton*buttoninUse;
@property (nonatomic, strong) CAShapeLayer *labelline;

@end

@implementation ChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.chartView];
    self.lineoffset=30;
    self.ySpace=(self.chartView.frame.size.height)/10;
    [self setbuttonline];
}
-(NSMutableArray*)data{
    if(_data==nil){
        _data=[[NSMutableArray alloc]init];
        [_data addObject:[NSNumber numberWithFloat:123.00]];
        
        [_data addObject:[NSNumber numberWithFloat:13.00]];
        [_data addObject:[NSNumber numberWithFloat:23.00]];
        [_data addObject:[NSNumber numberWithFloat:223.00]];
        [_data addObject:[NSNumber numberWithFloat:333.00]];
        [_data addObject:[NSNumber numberWithFloat:313.00]];
        
        [_data addObject:[NSNumber numberWithFloat:222.00]];
        [_data addObject:[NSNumber numberWithFloat:23.00]];
        [_data addObject:[NSNumber numberWithFloat:653.00]];
        [_data addObject:[NSNumber numberWithFloat:363.00]];
        [_data addObject:[NSNumber numberWithFloat:563.00]];
        
        [_data addObject:[NSNumber numberWithFloat:202.00]];
        [_data addObject:[NSNumber numberWithFloat:123.00]];
        [_data addObject:[NSNumber numberWithFloat:13.00]];
        [_data addObject:[NSNumber numberWithFloat:23.00]];
        [_data addObject:[NSNumber numberWithFloat:223.00]];
         
        [_data addObject:[NSNumber numberWithFloat:23.00]];
        [_data addObject:[NSNumber numberWithFloat:653.00]];
        
        [_data addObject:[NSNumber numberWithFloat:363.00]];
        [_data addObject:[NSNumber numberWithFloat:202.00]];
        [_data addObject:[NSNumber numberWithFloat:123.00]];
        [_data addObject:[NSNumber numberWithFloat:13.00]];
        
        [_data addObject:[NSNumber numberWithFloat:23.00]];
        [_data addObject:[NSNumber numberWithFloat:223.00]];
        [_data addObject:[NSNumber numberWithFloat:333.00]];
        [_data addObject:[NSNumber numberWithFloat:313.00]];
        [_data addObject:[NSNumber numberWithFloat:222.00]];
        
        [_data addObject:[NSNumber numberWithFloat:23.00]];
        [_data addObject:[NSNumber numberWithFloat:653.00]];
        [_data addObject:[NSNumber numberWithFloat:363.00]];
        [_data addObject:[NSNumber numberWithFloat:563.00]];
        [_data addObject:[NSNumber numberWithFloat:202.00]];
    }
    return _data;
}
-(int)setyNumwithmax:(float)max{
    int tmp=(int)max/6;
    if(tmp*6<max){
        return tmp+1;
    }
    return tmp;
}
-(float)getoffset{
    CGRect rectNav = self.navigationController.navigationBar.frame;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height+rectNav.size.height;
}
- (UIScrollView *)chartView {
    if (_chartView == nil) {
        float offset=[self getoffset];

        _chartView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, offset, 100 Wper, 40 Hper-offset)];
        _chartView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, offset, self.view.frame.size.width, self.view.frame.size.height/2-offset-50)];
        _chartView.backgroundColor=[UIColor blueColor];
        _chartView.bounces=NO;
        _chartView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_chartView setShowsHorizontalScrollIndicator:NO];
    }
    return _chartView;
}

-(void)setbuttonline{
    float offset=[self getoffset];
    UIButton*b1=[[UIButton alloc] initWithFrame:CGRectMake(0, offset,100 Wper/3, self.ySpace*2-26)];
    UIButton*b2=[[UIButton alloc] initWithFrame:CGRectMake(100 Wper/3, offset, 100 Wper/3, self.ySpace*2-26)];
    UIButton*b3=[[UIButton alloc] initWithFrame:CGRectMake(100 Wper*2/3, offset, 100 Wper/3, self.ySpace*2-26)];
    b1.backgroundColor=[UIColor grayColor];
    b1.layer.borderColor=[[UIColor blackColor] CGColor];
    b1.layer.borderWidth=1;
    b1.tag=1;
    [b1 setTitle:@"周" forState:UIControlStateNormal] ;
    b2.backgroundColor=[UIColor grayColor];
    b2.layer.borderColor=[[UIColor blackColor] CGColor];
    b2.layer.borderWidth=1;
    b2.tag=2;
    [b2 setTitle:@"月" forState:UIControlStateNormal] ;
    b3.backgroundColor=[UIColor grayColor];
    b3.layer.borderColor=[[UIColor blackColor] CGColor];
    b3.layer.borderWidth=1;
    b3.tag=3;
    [b3 setTitle:@"年" forState:UIControlStateNormal] ;
    [self.view addSubview:b1];
    [self.view addSubview:b2];
    [self.view addSubview:b3];
    [b1 addTarget: self action: @selector(buttonfunction:) forControlEvents: UIControlEventTouchDown] ;
    [b2 addTarget: self action: @selector(buttonfunction:) forControlEvents: UIControlEventTouchDown] ;
    [b3 addTarget: self action: @selector(buttonfunction:) forControlEvents: UIControlEventTouchDown] ;
    [self buttonfunction:b1];
}

-(void)refreshdata:(NSInteger) mode{
    self.yNum=[self setyNumwithmax:653.00];
}
-(void)buttonfunction:(UIButton*)btn{
    if(btn==self.buttoninUse){
        return;
    }
    if(self.buttoninUse!=nil){
        self.buttoninUse.backgroundColor=[UIColor grayColor];
    }
    self.buttoninUse=btn;
    self.buttoninUse.backgroundColor=[UIColor blackColor];
    [self refreshdata:btn.tag];
    [self beginDraw:btn.tag];
}

-(UIView*)drawbaseline:(NSInteger)mode{
    UIView*picView;
    if(mode==2){
        picView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.chartView.frame.size.width*2, self.chartView.frame.size.height)];
    }
    else{
        picView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.chartView.frame.size.width*1, self.chartView.frame.size.height)];
    }
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapevent:)];
    [picView addGestureRecognizer:tapGesture];
    tapGesture.view.tag=-1;
    
    picView.backgroundColor=[UIColor whiteColor];
    
    UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(self.lineoffset-10, 8*self.ySpace, picView.frame.size.width-(self.lineoffset-10)*2, 0.5)];
    
    bottomLineView.backgroundColor = [UIColor blackColor];
    [picView addSubview:bottomLineView];
    
    for (NSInteger i = 0; i < 6; i ++) {
        CGPoint startPoint = CGPointMake(self.lineoffset, self.ySpace*2+self.ySpace*i);
        CGPoint endPoint = CGPointMake(picView.frame.size.width-self.lineoffset,self.ySpace*2+self.ySpace*i);

        UIBezierPath *linePath = [[UIBezierPath alloc] init];
        [linePath moveToPoint:startPoint];
        [linePath addLineToPoint:endPoint];

        CAShapeLayer *contentLineLayer = [[CAShapeLayer alloc] init];
        contentLineLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
        contentLineLayer.lineWidth = 0.5f;
        contentLineLayer.fillColor = [UIColor clearColor].CGColor;

        contentLineLayer.path = linePath.CGPath;
        [picView.layer addSublayer:contentLineLayer];
    }
    if(mode==1){
        self.xCount=7;
    }
    else if(mode==2){
        self.xCount=[self getdaysin:2020 and:2];
    }
    else{
        self.xCount=12;
    }
    self.xSpace=(picView.frame.size.width-60-40)/(self.xCount-1);
    for(NSInteger i=0;i<self.xCount;i++){
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(30+self.xSpace*i, 8*self.ySpace+10, 40, 20)];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
        if(mode==1){
            switch (i) {
                case 0:
                    label.text=@"星期天";
                    break;
                case 1:
                    label.text=@"星期一";
                    break;
                case 2:
                    label.text=@"星期二";
                    break;
                case 3:
                    label.text=@"星期三";
                    break;
                case 4:
                    label.text=@"星期四";
                    break;
                case 5:
                    label.text=@"星期五";
                    break;
                case 6:
                    label.text=@"星期六";
                    break;
                default:
                    NSLog(@"error");
                    break;
            }
        }
        else{
            label.text=[NSString stringWithFormat:@"%ld",i+1];
        }
        
        label.textAlignment = NSTextAlignmentCenter;
        [picView addSubview:label];
    }
    return  picView;
}

-(int)getdaysin:(NSInteger)year and:(NSInteger)month{
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
        return 31;
    }
    else if(month==2){
        if((year%4==0&&year%100!=0)||year%400==0){
            return 29;
        }
        return 28;
    }
    return 30;
}


-(void)drawline:(UIView*)picView{
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    for(int i=0;i<self.xCount;i++){
        float y=[[self.data objectAtIndex:i] floatValue];
        CGPoint point =CGPointMake(self.lineoffset+self.xSpace*i+20, 8*self.ySpace-y*self.ySpace/self.yNum-3);
        if(i==0){
            [path moveToPoint:point];
        }
        else{
            [path addLineToPoint:point];
        }
        
        UIView*pointview=[[UIView alloc] initWithFrame:CGRectMake(point.x-3,point.y-3, 6, 6)];
        pointview.layer.masksToBounds=YES;
        pointview.layer.cornerRadius=3;
        pointview.backgroundColor=[UIColor whiteColor];
        pointview.layer.borderColor=[[UIColor blackColor]CGColor];
        pointview.layer.borderWidth=1;
        
        UIView*taparea=[[UIView alloc] initWithFrame:CGRectMake(point.x-6,point.y-6, 12, 12)];
        taparea.layer.masksToBounds=YES;
        taparea.layer.cornerRadius=6;
        taparea.backgroundColor=[UIColor clearColor];
        taparea.layer.borderWidth=0;

        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapevent:)];
        [taparea addGestureRecognizer:tapGesture];
        
        [picView addSubview:pointview];
        [picView addSubview:taparea];
        tapGesture.view.tag=i;
    }
   
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor grayColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    [picView.layer addSublayer:self.lineChartLayer];
}

- (void)tapevent:(UITapGestureRecognizer *)gesture {
    NSInteger pos=gesture.view.tag;
    if(self.labelinUse!=nil){
        if(pos==self.labelinUse.tag){
            return;
        }
        [self.labelinUse removeFromSuperview];
    }
    if(self.labelline!=nil){
        [self.labelline removeFromSuperlayer];
    }
    if(pos==-1){
        return;
    }
    CGPoint startPoint = CGPointMake(self.lineoffset+self.xSpace*pos+20, self.ySpace*2);
    CGPoint endPoint = CGPointMake(self.lineoffset+self.xSpace*pos+20,8*self.ySpace);
    
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:endPoint];

    CAShapeLayer *labelLineLayer = [[CAShapeLayer alloc] init];
    labelLineLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
    labelLineLayer.lineWidth = 1;
    labelLineLayer.fillColor = [UIColor clearColor].CGColor;
    labelLineLayer.lineDashPattern = @[@10, @4];
    
    labelLineLayer.path = linePath.CGPath;
    self.labelline=labelLineLayer;
    [self.picViewinUse.layer addSublayer:labelLineLayer];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = (id)self;
    [labelLineLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
    float num=[[self.data objectAtIndex:gesture.view.tag]floatValue];
    NSString* str=[NSString stringWithFormat:@"%0.2f",num];
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(startPoint.x-str.length*4,startPoint.y-20-4, str.length*8, 20)];
    label.text=str;
    label.backgroundColor=[UIColor grayColor];
    label.layer.cornerRadius=5;
    label.layer.masksToBounds = YES;
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor whiteColor];
    label.tag=pos;
    self.labelinUse=label;
    label.textAlignment = NSTextAlignmentCenter;
    [self.picViewinUse addSubview:label];
 }
-(void)beginDraw:(NSInteger)mode
{
    UIView*picView=[self drawbaseline:mode];
    _chartView.contentSize = CGSizeMake(picView.frame.size.width, self.chartView.frame.size.height);
    if(self.lineChartLayer!=nil){
        [self.lineChartLayer removeFromSuperlayer];
    }
    [self drawline:picView];
    if(self.picViewinUse!=nil){
        [self.picViewinUse removeFromSuperview];
    }
    [self.chartView addSubview:picView];
    self.picViewinUse=picView;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = (id)self;
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}
@end
