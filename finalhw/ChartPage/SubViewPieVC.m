//
// Created by hungyam on 2021/12/15.
//

#import "SubViewPieVC.h"

#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface SubViewPieVC ()

@property(nonatomic, assign) NSInteger pieNum;
@property(nonatomic, assign) float total;
@property(nonatomic, assign) float radius;
@property(nonatomic, assign) CGPoint midpoint;

@property(nonatomic, strong) NSMutableArray *dataByType;
@property(nonatomic, strong) NSMutableArray *nameOfType;
@property(nonatomic, strong) NSMutableArray *colorOfPie;

@property(nonatomic, strong) UIView *colorExp;
@property(nonatomic, strong) UILabel *midPieLabel;
@property(nonatomic, strong) UILabel *topPieLabel;
@property(nonatomic, strong) UILabel *bottomPieLabel;
@property(nonatomic, strong) UIView *pieViewInUse;
@property(nonatomic, strong) UIView *classifyPie;

@property(nonatomic, strong) CAShapeLayer *pieMaskLayer;

@end

@implementation SubViewPieVC

- (instancetype)init {
    self = [super init];
    [self.view addSubview:self.classifyPie];
    [self.view sendSubviewToBack:self.classifyPie];
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.view.userInteractionEnabled = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
}

#pragma mark - Base Data

- (void)refreshDataOfPie:(NSMutableArray *)dataArr andNameofPie:(NSMutableArray *)nameArr {
    self.dataByType = dataArr;
    self.nameOfType = nameArr;
    self.pieNum = self.dataByType.count;
}

- (NSMutableArray *)colorOfPie {
    if (_colorOfPie == nil) {
        _colorOfPie = [[NSMutableArray alloc] init];
        [_colorOfPie addObject:[UIColor colorWithRed:105 / 255.0 green:164 / 255.0 blue:245 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:247 / 255.0 green:191 / 255.0 blue:87 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:172 / 255.0 green:131 / 255.0 blue:225 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:110 / 255.0 green:202 / 255.0 blue:140 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:240 / 255.0 green:120 / 255.0 blue:100 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:94 / 255.0 green:208 / 255.0 blue:248 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:240 / 255.0 green:204 / 255.0 blue:81 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:180 / 255.0 green:90 / 255.0 blue:220 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:107 / 255.0 green:212 / 255.0 blue:177 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:242 / 255.0 green:155 / 255.0 blue:132 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:112 / 255.0 green:190 / 255.0 blue:244 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:244 / 255.0 green:174 / 255.0 blue:92 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:140 / 255.0 green:97 / 255.0 blue:242 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:150 / 255.0 green:213 / 255.0 blue:97 / 255.0 alpha:1]];
        [_colorOfPie addObject:[UIColor colorWithRed:242 / 255.0 green:148 / 255.0 blue:162 / 255.0 alpha:1]];
    }
    return _colorOfPie;
}

#pragma mark - Views

- (UIView *)classifyPie {
    if (_classifyPie == nil) {
        _classifyPie = [[UIView alloc] initWithFrame:CGRectMake(4 Wper, 25 Hper, 92 Wper, 50 Hper)];
        self.midpoint = CGPointMake(_classifyPie.frame.size.width / 2, _classifyPie.frame.size.height / 2);
        self.radius = (float) (self.midpoint.y < self.midpoint.x ? self.midpoint.y / 3 * 2 : self.midpoint.x / 3 * 2);
        _classifyPie.backgroundColor = [UIColor whiteColor];
        _classifyPie.layer.cornerRadius = 15;
        _classifyPie.layer.shadowColor = [UIColor grayColor].CGColor;
        _classifyPie.layer.shadowOffset = CGSizeMake(0, 0);
        _classifyPie.layer.shadowRadius = 10;
        _classifyPie.layer.shadowOpacity = 0.1;
    }
    return _classifyPie;
}

- (UILabel *)midPieLabel {
    if (_midPieLabel == nil) {
        CGFloat radius = self.radius / 2;
        _midPieLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.midpoint.x - radius, self.midpoint.y - 0.5 * radius, 2 * radius, radius)];
        _midPieLabel.backgroundColor = [UIColor clearColor];
        _midPieLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:35];
        _midPieLabel.textColor = [UIColor blackColor];
        _midPieLabel.textAlignment = NSTextAlignmentCenter;
        _midPieLabel.layer.borderWidth = 0;
        _midPieLabel.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _midPieLabel;
}

- (UIView *)colorExp {
    if (_colorExp == nil) {
        CGFloat radius = self.radius;
        _colorExp = [[UIView alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - radius / 2, self.classifyPie.frame.size.height / 6 - radius / 3, self.classifyPie.frame.size.height / 6 - radius / 3, self.classifyPie.frame.size.height / 6 - radius / 3)];
        _colorExp.layer.cornerRadius = 10;
        _colorExp.layer.shadowColor = [UIColor grayColor].CGColor;
        _colorExp.layer.shadowOffset = CGSizeMake(3, 3);
        _colorExp.layer.shadowRadius = 4;
        _colorExp.layer.shadowOpacity = 0.4;
    }
    return _colorExp;
}

- (UILabel *)topPieLabel {
    if (_topPieLabel == nil) {
        CGFloat radius = self.radius;
        _topPieLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - radius / 2 + self.classifyPie.frame.size.height / 3 - radius / 3 * 2, self.classifyPie.frame.size.height / 6 - radius / 3, radius, self.classifyPie.frame.size.height / 6 - radius / 3)];
        _topPieLabel.text = @"某个类名";
        _topPieLabel.backgroundColor = [UIColor clearColor];

        _topPieLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:30];
        _topPieLabel.textColor = [UIColor blackColor];
    }
    return _topPieLabel;
}

- (UILabel *)bottomPieLabel {
    if (_bottomPieLabel == nil) {
        _bottomPieLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.classifyPie.frame.size.width / 2 - self.radius / 2, self.classifyPie.frame.size.height * 5 / 8 + self.radius * 3 / 4, self.radius, self.classifyPie.frame.size.height / 4 - self.radius / 2)];
        _bottomPieLabel.backgroundColor = [UIColor clearColor];
        _bottomPieLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:30];
        _bottomPieLabel.textColor = [UIColor blackColor];
        _bottomPieLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomPieLabel;
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

- (UIView *)drawPie {
    UIView *picView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.classifyPie.frame.size.width, self.classifyPie.frame.size.height)];
    picView.backgroundColor = [UIColor clearColor];
    self.total = 0;
    for (int i = 0; i < self.pieNum; i++) {
        self.total += [self.dataByType[i] floatValue];
    }
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;

    for (int i = 0; i < self.pieNum; i++) {
        //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        end = [self.dataByType[i] floatValue] * M_PI * 2 / self.total + start;
        //图层
        UIColor *color = self.colorOfPie[i % self.colorOfPie.count];

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

#pragma mark - Action

- (void)beginDrawPie {
    UIView *picView = [self drawPie];
    if (self.pieViewInUse != nil) {
        [self.pieViewInUse removeFromSuperview];
        self.pieViewInUse = nil;
    }
    [self.classifyPie addSubview:picView];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1;
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [self.pieMaskLayer addAnimation:animation forKey:@"circleAnimation"];

    self.pieViewInUse = picView;
}

#pragma mark - Touch Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    //获取触摸点的集合
    NSSet *allTouches = [event allTouches];
    //获取触摸对象
    UITouch *touch = [allTouches anyObject];
    //返回触摸点所在视图中的坐标
    CGPoint point = [touch locationInView:self.classifyPie];
    NSInteger num = [self layerPos:point];
    if (num >= 0 && num < self.pieNum) {

        float ratio = [self.dataByType[num] floatValue] / self.total * 100;
        self.midPieLabel.text = [NSString stringWithFormat:@"%0.1f%%", ratio];
        [self.classifyPie addSubview:self.midPieLabel];
        [self.view bringSubviewToFront:self.midPieLabel];
        self.colorExp.backgroundColor = self.colorOfPie[num % self.colorOfPie.count];
        [self.classifyPie addSubview:self.colorExp];
        self.topPieLabel.text = self.nameOfType[num];
        [self.classifyPie addSubview:self.topPieLabel];
        self.bottomPieLabel.text = [NSString stringWithFormat:@"%0.2f元", [self.dataByType[num] floatValue]];
        self.bottomPieLabel.frame = CGRectMake(self.classifyPie.frame.size.width / 2 - self.radius * self.bottomPieLabel.text.length / 12, self.classifyPie.frame.size.height * 5 / 8 + self.radius * 3 / 4, self.radius * self.bottomPieLabel.text.length / 6, self.classifyPie.frame.size.height / 4 - self.radius / 2);
        [self.classifyPie addSubview:self.bottomPieLabel];

    } else if (num < 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self clearTheView];
        }];
    }
}
- (NSInteger)layerPos:(CGPoint)point {
    __block NSInteger i = -1;
    CGAffineTransform transform = CGAffineTransformIdentity;
    [self.pieViewInUse.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *) obj;
        CGPathRef path = [shapeLayer path];
        if (CGPathContainsPoint(path, &transform, point, 0)) {
            i = idx;
        }
    }];
    return i;
}
- (void)clearTheView {
    if (self.pieViewInUse != nil) {
        [self.pieViewInUse removeFromSuperview];
        self.pieViewInUse = nil;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.midPieLabel removeFromSuperview];
    [self.colorExp removeFromSuperview];
    [self.topPieLabel removeFromSuperview];
    [self.bottomPieLabel removeFromSuperview];
}
@end
