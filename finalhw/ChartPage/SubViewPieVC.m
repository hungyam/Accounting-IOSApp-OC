//
// Created by hungyam on 2021/12/15.
//

#import "SubViewPieVC.h"

#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100
@interface SubViewPieVC ()

@property(nonatomic, strong) NSMutableArray *databytype;
@property(nonatomic, strong) NSMutableArray *nameoftype;

@property(nonatomic, strong) CAShapeLayer *pieMaskLayer;

@property(nonatomic, strong) NSMutableArray *colorofpie;
@property(nonatomic, assign) NSInteger pieNum;
@property(nonatomic, strong) UIView *colorexp;
@property(nonatomic, strong) UILabel *midpielabel;
@property(nonatomic, strong) UILabel *toppielabel;
@property(nonatomic, strong) UILabel *bottompielabel;
@property(nonatomic, assign) float total;
@property(nonatomic, assign) float radius;
@property(nonatomic, assign) CGPoint midpoint;
@property(nonatomic, strong) UIView *pieViewinUse;


@property(nonatomic, strong) UIView *classifyPie;

@end

@implementation SubViewPieVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init{
    self = [super init];

    [self.view addSubview:self.classifyPie];
    [self.view sendSubviewToBack:self.classifyPie];
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.view.userInteractionEnabled = YES;
    return self;
}

-(void)clearTheView{
    if (self.pieViewinUse != nil) {
        [self.pieViewinUse removeFromSuperview];
        self.pieViewinUse=nil;
    }
}

-(void)refreshdataofPie:(NSMutableArray *)dataArr andNameofPie:(NSMutableArray *)nameArr{
    self.databytype=dataArr;
    self.nameoftype=nameArr;
    self.pieNum = self.databytype.count;
}
- (UIView *)classifyPie {
    if (_classifyPie == nil) {
        _classifyPie = [[UIView alloc] initWithFrame:CGRectMake(4 Wper, 25 Hper, 92 Wper, 50 Hper)];
        self.midpoint = CGPointMake(_classifyPie.frame.size.width / 2, _classifyPie.frame.size.height / 2);
        self.radius = self.midpoint.y < self.midpoint.x ? self.midpoint.y / 3 * 2 : self.midpoint.x / 3 * 2;
        _classifyPie.backgroundColor = [UIColor whiteColor];
        _classifyPie.layer.cornerRadius = 15;
        _classifyPie.layer.shadowColor = [UIColor grayColor].CGColor;
        _classifyPie.layer.shadowOffset = CGSizeMake(0, 0);
        _classifyPie.layer.shadowRadius = 10;
        _classifyPie.layer.shadowOpacity = 0.1;

    }
    return _classifyPie;
}

- (NSMutableArray *)colorofpie {
    if (_colorofpie == nil) {
        _colorofpie = [[NSMutableArray alloc] init];
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

- (UILabel *)midpielabel {
    if (_midpielabel == nil) {
        CGFloat radius = self.radius / 2;
        _midpielabel = [[UILabel alloc] initWithFrame:CGRectMake(self.midpoint.x - 0.86 * radius, self.midpoint.y - 0.5 * radius, 1.72 * radius, radius)];
        _midpielabel.backgroundColor = [UIColor clearColor];
        _midpielabel.font = [UIFont systemFontOfSize:35];
        _midpielabel.textColor = [UIColor blackColor];
        _midpielabel.textAlignment = NSTextAlignmentCenter;
        _midpielabel.layer.borderWidth = 0;
        _midpielabel.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _midpielabel;
}

- (UIView *)colorexp {
    if (_colorexp == nil) {
        CGFloat radius = self.radius;
        _colorexp = [[UIView alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - radius / 2, self.classifyPie.frame.size.height / 6 - radius / 3, self.classifyPie.frame.size.height / 6 - radius / 3, self.classifyPie.frame.size.height / 6 - radius / 3)];
        _colorexp.layer.borderColor = [UIColor blackColor].CGColor;
        _colorexp.layer.borderWidth = 1;
    }
    return _colorexp;
}

- (UILabel *)toppielabel {
    if (_toppielabel == nil) {
        CGFloat radius = self.radius;
        _toppielabel = [[UILabel alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - radius / 2 + self.classifyPie.frame.size.height / 3 - radius / 3 * 2, self.classifyPie.frame.size.height / 6 - radius / 3, radius, self.classifyPie.frame.size.height / 6 - radius / 3)];
        _toppielabel.text = @"某个类名";
        _toppielabel.backgroundColor = [UIColor clearColor];

        _toppielabel.font = [UIFont systemFontOfSize:20];
        _toppielabel.textColor = [UIColor blackColor];
    }
    return _toppielabel;
}

- (UILabel *)bottompielabel {
    if (_bottompielabel == nil) {
        _bottompielabel = [[UILabel alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - self.radius / 2, self.classifyPie.frame.size.height * 5 / 8 + self.radius * 3 / 4, self.radius, self.classifyPie.frame.size.height / 4 - self.radius / 2)];
        _bottompielabel.backgroundColor = [UIColor clearColor];
        _bottompielabel.font = [UIFont systemFontOfSize:25];
        _bottompielabel.textColor = [UIColor blackColor];
        _bottompielabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottompielabel;
}

- (CAShapeLayer *)pieMaskLayer {
    if (_pieMaskLayer == nil) {
        CGPoint midpoint = CGPointMake(self.classifyPie.frame.size.width / 2, self.classifyPie.frame.size.height / 2);
        CGFloat bgRadius = midpoint.y < midpoint.x ? midpoint.y * 2 / 3 : midpoint.x * 2 / 3;
        UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:midpoint
                                                              radius:bgRadius / 2
                                                          startAngle:-M_PI_2
                                                            endAngle:M_PI_2 * 3
                                                           clockwise:YES];
        self.pieMaskLayer = [CAShapeLayer layer];
        self.pieMaskLayer.fillColor = [UIColor clearColor].CGColor;
        self.pieMaskLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        self.pieMaskLayer.strokeStart = 0.0f;
        self.pieMaskLayer.strokeEnd = 1.0f;
        self.pieMaskLayer.zPosition = 1;
        self.pieMaskLayer.lineWidth = bgRadius;
        self.pieMaskLayer.path = bgPath.CGPath;
    }
    return _pieMaskLayer;
}


- (void)beginDrawpie {
    UIView *picView = [self drawpie];
    if (self.pieViewinUse != nil) {
        [self.pieViewinUse removeFromSuperview];
        self.pieViewinUse=nil;
    }
    [self.classifyPie addSubview:picView];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [self.pieMaskLayer addAnimation:animation forKey:@"circleAnimation"];

    self.pieViewinUse = picView;
}

- (UIView *)drawpie {
    UIView *picView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.classifyPie.frame.size.width, self.classifyPie.frame.size.height)];
    picView.backgroundColor = [UIColor clearColor];
    self.total = 0;
    for (int i = 0; i < self.pieNum; i++) {
        self.total += [[self.databytype objectAtIndex:i] floatValue];
    }
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;

    for (int i = 0; i < self.pieNum; i++) {
        //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        end = [[self.databytype objectAtIndex:i] floatValue] * M_PI * 2 / self.total + start;
        //图层

        UIColor *color;
        if (i < self.colorofpie.count) {
            color = [self.colorofpie objectAtIndex:i];
        } else {
            CGFloat red = arc4random_uniform(256) / 255.0;
            CGFloat green = arc4random_uniform(256) / 255.0;
            CGFloat blue = arc4random_uniform(256) / 255.0;
            color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            [self.colorofpie addObject:color];
        }

        UIBezierPath *partPath = [UIBezierPath bezierPathWithArcCenter:self.midpoint
                                                                radius:self.radius
                                                            startAngle:start - M_PI_2
                                                              endAngle:end - M_PI_2
                                                             clockwise:YES];
        [partPath addLineToPoint:self.midpoint];
        CAShapeLayer *pie = [CAShapeLayer layer];
        pie.fillColor = color.CGColor;
        pie.strokeColor = [UIColor whiteColor].CGColor;
        pie.lineWidth = 0;
        pie.zPosition = 2;
        pie.path = partPath.CGPath;

        [picView.layer addSublayer:pie];
        //计算下一个start位置 = 当前end位置
        start = end;
    }
    picView.layer.mask = self.pieMaskLayer;
    picView.hidden = NO;
    UIBezierPath *partPath = [UIBezierPath bezierPathWithArcCenter:self.midpoint
                                                            radius:self.radius / 2
                                                        startAngle:-M_PI_2
                                                          endAngle:3 * M_PI_2
                                                         clockwise:YES];
    CAShapeLayer *midview = [CAShapeLayer layer];
    midview.fillColor = [UIColor whiteColor].CGColor;
    midview.strokeColor = [UIColor whiteColor].CGColor;
    midview.zPosition = 3;
    midview.path = partPath.CGPath;
    [picView.layer addSublayer:midview];

    return picView;
}




- (NSInteger)layerpos:(CGPoint)point {
    __block NSInteger i = -1;
    CGAffineTransform transform = CGAffineTransformIdentity;
    [self.pieViewinUse.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *) obj;
        CGPathRef path = [shapeLayer path];
        if (CGPathContainsPoint(path, &transform, point, 0)) {
            i = idx;
        }
    }];
    return i;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    //获取触摸点的集合
    NSSet *allTouches = [event allTouches];
    //获取触摸对象
    UITouch *touch = [allTouches anyObject];
    //返回触摸点所在视图中的坐标
    CGPoint point = [touch locationInView:[touch view]];
    NSInteger num = [self layerpos:point];
    NSLog(@"%ld",num);
    if (num >= 0 && num < self.pieNum) {

        float ratio = [[self.databytype objectAtIndex:num] floatValue] / self.total * 100;
        self.midpielabel.text = [NSString stringWithFormat:@"%0.1f%%", ratio];
        [self.classifyPie addSubview:self.midpielabel];
        [self.view bringSubviewToFront:self.midpielabel];
        self.colorexp.backgroundColor = [self.colorofpie objectAtIndex:num];
        [self.classifyPie addSubview:self.colorexp];
        self.toppielabel.text = [self.nameoftype objectAtIndex:num];
        [self.classifyPie addSubview:self.toppielabel];
        self.bottompielabel.text = [NSString stringWithFormat:@"%0.2f元", [[self.databytype objectAtIndex:num] floatValue]];
        [self.classifyPie addSubview:self.bottompielabel];

    }
    else if(num<0){
        [self dismissViewControllerAnimated:YES completion:^{
            [self clearTheView];
        }];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.midpielabel removeFromSuperview];
    [self.colorexp removeFromSuperview];
    [self.toppielabel removeFromSuperview];
    [self.bottompielabel removeFromSuperview];
}
@end