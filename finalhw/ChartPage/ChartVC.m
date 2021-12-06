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

@property (nonatomic,strong)NSMutableArray *databytime;
@property (nonatomic,strong)NSMutableArray *databytype;

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
@property (nonatomic, strong) CAShapeLayer *pieMaskLayer;

@property (nonatomic,assign)int lineoffset;//横线偏移量
@property (nonatomic,assign)float ySpace;//y轴间隔
@property (nonatomic,assign)int yNum;//y轴一个间隔的数值
@property (nonatomic,assign)int xCount;//x轴的点数
@property (nonatomic,assign)float xSpace;//x轴间隔


@property (nonatomic,assign)NSInteger mode;
@property (nonatomic,assign)NSInteger inOrOut;

@property (nonatomic, strong) UIView*lineViewinUse;
@property (nonatomic, strong) UIView*pieViewinUse;

@property (nonatomic,strong)UILabel*labelinUse;
@property (nonatomic, strong) CAShapeLayer *labelline;

@property (nonatomic,strong)UIButton*buttoninUse;

@property (nonatomic, strong)UIView* dateChooseArea;

@property (nonatomic, strong) UIView*classifyPie;
@property (nonatomic,strong)NSMutableArray *colorofpie;
@property (nonatomic,assign)NSInteger pieNum;
@property (nonatomic, strong)UIView*colorexp;
@property (nonatomic, strong)UILabel*midpielabel;
@property (nonatomic, strong)UILabel*toppielabel;
@property (nonatomic, strong)UILabel*bottompielabel;
@property (nonatomic,assign) float total;
@property (nonatomic,assign) float radius;
@property (nonatomic,assign) CGPoint midpoint;
@property (nonatomic,assign) bool drawdelay;

@property (nonatomic, strong) UIView*classifylist;

@property (nonatomic, strong)UISegmentedControl*segment;

@end

@implementation ChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view addSubview: self.chartView];
    [self.view addSubview:self.dateChooseArea];
    [self.view addSubview:self.classifylist];
    [self.view addSubview:self.segment];
    [self setbuttonline];
}
-(void)refresh{
    if(self.labelinUse!=nil){
        [self.labelinUse removeFromSuperview];
        self.labelinUse=nil;
    }
    if(self.labelline!=nil){
        [self.labelline removeFromSuperlayer];
        self.labelline=nil;
    }
    [self refreshdataoftime];
    [self refreshdataoftype];
    [self beginDrawline];
    [self setlist];
    if(self.segment.selectedSegmentIndex==0){
        self.drawdelay=1;
    }
    else{
        [self beginDrawpie];
    }
}
-(NSMutableArray*)databytime{
    if(_databytime==nil){
        _databytime=[[NSMutableArray alloc]init];
        [_databytime addObject:[NSNumber numberWithFloat:123.00]];
        [_databytime addObject:[NSNumber numberWithFloat:513.00]];
        [_databytime addObject:[NSNumber numberWithFloat:423.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:633.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:139.00]];
        [_databytime addObject:[NSNumber numberWithFloat:253.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:233.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:193.00]];
        [_databytime addObject:[NSNumber numberWithFloat:263.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:13.00]];
        [_databytime addObject:[NSNumber numberWithFloat:263.00]];
        [_databytime addObject:[NSNumber numberWithFloat:273.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:13.00]];
        [_databytime addObject:[NSNumber numberWithFloat:23.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
        [_databytime addObject:[NSNumber numberWithFloat:13.00]];
        [_databytime addObject:[NSNumber numberWithFloat:23.00]];
        [_databytime addObject:[NSNumber numberWithFloat:223.00]];
        [_databytime addObject:[NSNumber numberWithFloat:333.00]];
        [_databytime addObject:[NSNumber numberWithFloat:313.00]];
    }
    return _databytime;
}
-(float)getoffset{
    CGRect rectNav = self.navigationController.navigationBar.frame;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float offset=rectStatus.size.height+rectNav.size.height;
    return  offset;
}

#pragma mark - main part
- (UIScrollView *)chartView {
    if (_chartView == nil) {
        float offset=[self getoffset];
        _chartView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, offset, 100 Wper, 45 Hper-offset)];
        _chartView.backgroundColor=[UIColor clearColor];
        _chartView.bounces=NO;
        _chartView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_chartView setShowsHorizontalScrollIndicator:NO];
        self.lineoffset=30;
        self.ySpace=(self.chartView.frame.size.height)/10;
    }
    return _chartView;
}
-(UIView*)dateChooseArea{
    if(_dateChooseArea==nil){
        
        _dateChooseArea = [[UIView alloc]initWithFrame:CGRectMake(0, 45 Hper, 100 Wper, 5 Hper)];
        _dateChooseArea.backgroundColor=[UIColor blackColor];
    }
    return _dateChooseArea;
}
-(UIView*)classifylist{
    if(_classifylist==nil){
        _classifylist=[[UIView alloc]initWithFrame:CGRectMake(0, 50 Hper, 100 Wper, 50 Hper-83)];
        _classifylist.backgroundColor=[UIColor purpleColor];
    }
    return  _classifylist;
}
-(UIView*)classifyPie{
    if(_classifyPie==nil){
        _classifyPie=[[UIView alloc]initWithFrame:CGRectMake(0, 50 Hper, 100 Wper, 50 Hper-83)];
        self.midpoint=CGPointMake(_classifyPie.frame.size.width/2, _classifyPie.frame.size.height/2);
        self.radius = self.midpoint.y<self.midpoint.x?self.midpoint.y/3*2:self.midpoint.x/3*2;
        _classifyPie.backgroundColor=[UIColor clearColor];
    }
    return _classifyPie;
}

-(UISegmentedControl*)segment{
    if(_segment==nil){
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"排行榜",@"扇形图"]];
        _segment.frame =CGRectMake(100 Wper-120,50 Hper+15,120, 30);
        _segment.selectedSegmentIndex = 1;
        _segment.tintColor = [UIColor whiteColor];
        _segment.apportionsSegmentWidthsByContent = YES;
        [_segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex=0;
    }
    return _segment;
}
-(void)segmentSelected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    if(control.selectedSegmentIndex==0){
        [self.classifyPie removeFromSuperview];
        [self.view addSubview:self.classifylist];
        [self.view sendSubviewToBack:self.classifylist];
    }
    else{
        [self.classifylist removeFromSuperview];
        if(self.drawdelay==1){
            self.drawdelay=0;
            [self beginDrawpie];
        }
        [self.view addSubview:self.classifyPie];
        [self.view sendSubviewToBack:self.classifyPie];
    }
}
#pragma mark - part of pie

-(NSMutableArray*)colorofpie{
    if(_colorofpie==nil){
        _colorofpie=[[NSMutableArray alloc]init];
        [_colorofpie addObject:[UIColor redColor]];
        [_colorofpie addObject:[UIColor orangeColor]];
        [_colorofpie addObject:[UIColor yellowColor]];
        [_colorofpie addObject:[UIColor greenColor]];
        [_colorofpie addObject:[UIColor cyanColor]];
        [_colorofpie addObject:[UIColor blueColor]];
        [_colorofpie addObject:[UIColor purpleColor]];
        [_colorofpie addObject:[UIColor grayColor]];
        [_colorofpie addObject:[UIColor brownColor]];
        [_colorofpie addObject:[UIColor magentaColor]];
    }
    return _colorofpie;
}
-(UILabel*)midpielabel{
    if(_midpielabel==nil){
        CGFloat radius =self.radius/2;
        _midpielabel=[[UILabel alloc]initWithFrame:CGRectMake(self.midpoint.x-0.86*radius, self.midpoint.y-0.5*radius,1.72*radius,radius)];
        _midpielabel.backgroundColor=[UIColor clearColor];
        _midpielabel.text=@"99.9%";
        
        _midpielabel.font=[UIFont systemFontOfSize:35];
        _midpielabel.textColor=[UIColor blackColor];
        _midpielabel.textAlignment = NSTextAlignmentCenter;
        _midpielabel.layer.borderWidth=0;
        _midpielabel.layer.borderColor=[UIColor clearColor].CGColor;
    }
    return  _midpielabel;
}
-(UIView*)colorexp{
    if(_colorexp==nil){
        CGFloat radius = self.radius;
        _colorexp=[[UIView alloc]initWithFrame:CGRectMake(self.classifyPie.frame.size.width/2-radius/2 , self.classifyPie.frame.size.height/6-radius/3 , self.classifyPie.frame.size.height/6-radius/3 , self.classifyPie.frame.size.height/6-radius/3)];
        _colorexp.layer.borderColor=[UIColor blackColor].CGColor;
        _colorexp.layer.borderWidth=1;
    }
    return  _colorexp;
}
-(UILabel*)toppielabel{
    if(_toppielabel==nil){
        CGFloat radius = self.radius;
        _toppielabel=[[UILabel alloc]initWithFrame:CGRectMake(self.classifyPie.frame.size.width/2-radius/2+self.classifyPie.frame.size.height/3-radius/3*2 , self.classifyPie.frame.size.height/6-radius/3, radius, self.classifyPie.frame.size.height/6-radius/3)];
        _toppielabel.text=@"某个类名";
        _toppielabel.backgroundColor=[UIColor clearColor];
        
        _toppielabel.font=[UIFont systemFontOfSize:20];
        _toppielabel.textColor=[UIColor blackColor];
    }
    return _toppielabel;
}

-(UILabel*)bottompielabel{
    if(_bottompielabel==nil){
        _bottompielabel=[[UILabel alloc]initWithFrame:CGRectMake(self.classifyPie.frame.size.width/2-self.radius/2,self.classifyPie.frame.size.height*5/8+self.radius*3/4,self.radius,self.classifyPie.frame.size.height/4-self.radius/2)];
        _bottompielabel.backgroundColor=[UIColor clearColor];
        _bottompielabel.font=[UIFont systemFontOfSize:25];
        _bottompielabel.textColor=[UIColor blackColor];
        _bottompielabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _bottompielabel;
}

-(CAShapeLayer*)pieMaskLayer{
    if(_pieMaskLayer==nil){
        CGPoint midpoint=CGPointMake(self.classifyPie.frame.size.width/2, self.classifyPie.frame.size.height/2);
        CGFloat bgRadius = midpoint.y<midpoint.x?midpoint.y*2/3:midpoint.x*2/3;
        UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:midpoint
                                                              radius:bgRadius/2
                                                          startAngle:-M_PI_2
                                                            endAngle:M_PI_2 * 3
                                                           clockwise:YES];
        self.pieMaskLayer = [CAShapeLayer layer];
        self.pieMaskLayer.fillColor   = [UIColor clearColor].CGColor;
        self.pieMaskLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        self.pieMaskLayer.strokeStart = 0.0f;
        self.pieMaskLayer.strokeEnd   = 1.0f;
        self.pieMaskLayer.zPosition   = 1;
        self.pieMaskLayer.lineWidth   = bgRadius;
        self.pieMaskLayer.path        = bgPath.CGPath;
    }
    return _pieMaskLayer;
}

#pragma mark - setting button of week,month,year

-(void)setbuttonline{
    float offset=[self getoffset];
    NSLog(@"%f",offset);
    UIButton*b1=[[UIButton alloc] initWithFrame:CGRectMake(0, offset,100 Wper/3, 2*self.ySpace-25)];
    UIButton*b2=[[UIButton alloc] initWithFrame:CGRectMake(100 Wper/3, offset, 100 Wper/3, 2*self.ySpace-25)];
    UIButton*b3=[[UIButton alloc] initWithFrame:CGRectMake(100 Wper*2/3, offset, 100 Wper/3, 2*self.ySpace-25)];
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
    [b1 addTarget: self action: @selector(timebuttonfunction:) forControlEvents: UIControlEventTouchDown] ;
    [b2 addTarget: self action: @selector(timebuttonfunction:) forControlEvents: UIControlEventTouchDown] ;
    [b3 addTarget: self action: @selector(timebuttonfunction:) forControlEvents: UIControlEventTouchDown] ;
    [self timebuttonfunction:b1];
}
-(void)timebuttonfunction:(UIButton*)btn{
    if(btn==self.buttoninUse){
        return;
    }
    if(self.buttoninUse!=nil){
        self.buttoninUse.backgroundColor=[UIColor grayColor];
    }
    self.buttoninUse=btn;
    self.buttoninUse.backgroundColor=[UIColor blackColor];
    self.mode=btn.tag;
    [self refresh];
    
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

-(int)setyNumwithmax:(float)max{
    int tmp=(int)max/6;
    if(tmp*6<max){
        return tmp+1;
    }
    return tmp;
}
#pragma mark - base data of pic and list

-(void)refreshdataoftime{
    self.yNum=[self setyNumwithmax:633.00];
}
-(void)refreshdataoftype{
    self.pieNum=15;
}

#pragma mark - linepic

-(UIView*)drawbaseline{
    UIView*picView;
    if(self.mode==2){
        picView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.chartView.frame.size.width*2, self.chartView.frame.size.height)];
    }
    else{
        picView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.chartView.frame.size.width*1, self.chartView.frame.size.height)];
    }
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapoflinechart:)];
    [picView addGestureRecognizer:tapGesture];
    tapGesture.view.tag=-1;
    
    picView.backgroundColor=[UIColor clearColor];
    
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
    if(self.mode==1){
        self.xCount=7;
    }
    else if(self.mode==2){
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
        label.textAlignment = NSTextAlignmentCenter;
        if(self.mode==1){
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
        [picView addSubview:label];
    }
    return  picView;
}

-(void)drawline:(UIView*)picView{
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    for(int i=0;i<self.xCount;i++){
        float y=[[self.databytime objectAtIndex:i] floatValue];
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

        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapoflinechart:)];
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

- (void)tapoflinechart:(UITapGestureRecognizer *)gesture {
    NSInteger pos=gesture.view.tag;
    if(self.labelinUse!=nil){
        if(pos==self.labelinUse.tag){
            return;
        }
        [self.labelinUse removeFromSuperview];
        self.labelinUse=nil;
    }
    if(self.labelline!=nil){
        [self.labelline removeFromSuperlayer];
        self.labelline=nil;
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
    [self.lineViewinUse.layer addSublayer:labelLineLayer];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = (id)self;
    [labelLineLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
    float num=[[self.databytime objectAtIndex:gesture.view.tag]floatValue];
    NSString* str=[NSString stringWithFormat:@"%0.2f",num];
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(startPoint.x-str.length*4,startPoint.y-22, str.length*8, 18)];
    label.text=str;
    label.backgroundColor=[UIColor grayColor];
    label.layer.cornerRadius=5;
    label.layer.masksToBounds = YES;
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor whiteColor];
    label.tag=pos;
    self.labelinUse=label;
    label.textAlignment = NSTextAlignmentCenter;
    [self.lineViewinUse addSubview:label];
 }
-(void)beginDrawline
{
    UIView*picView=[self drawbaseline];
    _chartView.contentSize = CGSizeMake(picView.frame.size.width, self.chartView.frame.size.height);
    if(self.lineChartLayer!=nil){
        [self.lineChartLayer removeFromSuperlayer];
    }
    [self drawline:picView];
    if(self.lineViewinUse!=nil){
        [self.lineViewinUse removeFromSuperview];
    }
    [self.chartView addSubview:picView];
    self.lineViewinUse=picView;
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


#pragma mark - piepic

-(void)beginDrawpie
{
    UIView*picView=[self drawpie];
    if(self.pieViewinUse!=nil){
        [self.pieViewinUse removeFromSuperview];
    }
    [self.classifyPie addSubview:picView];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = 2;
    animation.fromValue = @0.0f;
    animation.toValue   = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [self.pieMaskLayer addAnimation:animation forKey:@"circleAnimation"];

    self.pieViewinUse=picView;
}
-(UIView*)drawpie{
    UIView*picView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.classifyPie.frame.size.width, self.classifyPie.frame.size.height)];
    picView.backgroundColor=[UIColor clearColor];
    self.total=0;
    for(int i=0;i<self.pieNum;i++){
        self.total+=[[self.databytime objectAtIndex:i]floatValue];
    }
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;
    
    for (int i = 0; i < self.pieNum; i++) {
                //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        end = [[self.databytime objectAtIndex:i]floatValue]* M_PI * 2 / self.total + start;
                //图层
        
        UIColor*color;
        if(i<self.colorofpie.count){
            color=[self.colorofpie objectAtIndex:i];
        }
        else{
            CGFloat red = arc4random_uniform(256)/ 255.0;
            CGFloat green = arc4random_uniform(256)/ 255.0;
            CGFloat blue = arc4random_uniform(256)/ 255.0;
            color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            [self.colorofpie addObject:color];
        }
        
        UIBezierPath *partPath = [UIBezierPath bezierPathWithArcCenter:self.midpoint
                                                                  radius:self.radius
                                                              startAngle:start-M_PI_2
                                                                endAngle:end-M_PI_2
                                                               clockwise:YES];
        [partPath addLineToPoint:self.midpoint];
        CAShapeLayer *pie = [CAShapeLayer layer];
        pie.fillColor   = color.CGColor;
        pie.strokeColor = [UIColor whiteColor].CGColor;
        pie.lineWidth=0;
        pie.zPosition   = 2;
        pie.path        = partPath.CGPath;
        
        [picView.layer addSublayer:pie];
                //计算下一个start位置 = 当前end位置
        start = end;
    }
    picView.layer.mask = self.pieMaskLayer;
    picView.hidden = NO;
  
    UIBezierPath *partPath = [UIBezierPath bezierPathWithArcCenter:self.midpoint
                                                          radius:self.radius/2
                                                      startAngle:-M_PI_2
                                                        endAngle:3*M_PI_2
                                                       clockwise:YES];
    CAShapeLayer *midview = [CAShapeLayer layer];
    midview.fillColor   = [UIColor whiteColor].CGColor;
    midview.strokeColor = [UIColor whiteColor].CGColor;
    midview.zPosition   = 3;
    midview.path        = partPath.CGPath;
    [picView.layer addSublayer:midview];
    
    return  picView;
}


-(NSInteger)layerpos:(CGPoint)point{
    __block NSInteger i=-1;
    CGAffineTransform transform = CGAffineTransformIdentity;
    [self.pieViewinUse.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
        CGPathRef path = [shapeLayer path];
        if (CGPathContainsPoint(path, &transform, point, 0)) {
            i=idx;
        }
    }];
    return i;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
        
        //获取触摸点的集合
        NSSet * allTouches = [event allTouches];
        //获取触摸对象
        UITouch * touch = [allTouches anyObject];
        //返回触摸点所在视图中的坐标
        CGPoint point = [touch locationInView:[touch view]];
    NSInteger num=[self layerpos:point];
    if(num>=0&&num<self.pieNum){
        
        float ratio=[[self.databytime objectAtIndex:num] floatValue]/self.total*100;
        self.midpielabel.text=[NSString stringWithFormat:@"%0.1f%%",ratio];
        [self.classifyPie addSubview:self.midpielabel];
        self.colorexp.backgroundColor=[self.colorofpie objectAtIndex:num];
        [self.classifyPie addSubview:self.colorexp];
        [self.classifyPie addSubview:self.toppielabel];
        self.bottompielabel.text=[NSString stringWithFormat:@"%0.2f元",[[self.databytime objectAtIndex:num] floatValue] ];
        [self.classifyPie addSubview:self.bottompielabel];
        
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.midpielabel removeFromSuperview];
    [self.colorexp removeFromSuperview];
    [self.toppielabel removeFromSuperview];
    [self.bottompielabel removeFromSuperview];
}
#pragma mark -  set the list,add in classfylist
-(void)setlist{
    
}
@end
