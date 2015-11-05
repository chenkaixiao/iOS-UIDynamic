//
//  ViewController.m
//  iOS-UIDynamic
//
//  Created by zero on 15/11/5.
//  Copyright © 2015年 zerorobot. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/**
 *  仿真模拟器
 */
@property(nonatomic,strong)UIDynamicAnimator *animator;

@property(nonatomic,strong)UIView *rectangleView ;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton  *startBtn = [[UIButton alloc]initWithFrame:(CGRect){50,50,100,50}];
    
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    // 创建一个矩形
    UIView *rectangleView = [[UIView alloc]initWithFrame:(CGRect){100,100,200,100}];
    rectangleView.backgroundColor = [UIColor orangeColor];
    rectangleView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [self.view addSubview:rectangleView];
    self.rectangleView = rectangleView;
    
    

    
}

/**
 *  演示捕捉行为
 *
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint loctionPoint = [touch locationInView:self.view];
    
    //捕捉行为
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.rectangleView snapToPoint:loctionPoint];
    
    snapBehavior.damping = 0.2; // 减震系数
    
    // 移除行为
    [self.animator removeAllBehaviors];
    // 添加行为
    [self.animator addBehavior:snapBehavior];
    
    
}
/**
 *  演示重力行为 碰撞行为
 *
 *  @param btn
 */

-(void)startBtnDidClick:(UIButton*)btn
{
    
    // 重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.rectangleView]];
//    gravityBehavior.magnitude = // 控制加速度
    // 测试属性
    gravityBehavior.gravityDirection = (CGVector){1.0,1.0};// 向量
    
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.rectangleView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    // 首先移除之前行为
    [self.animator removeAllBehaviors];
    // 添加行为进入仿真模拟器

    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    
    
}


#pragma mark - lazy
-(UIDynamicAnimator *)animator
{
    if(!_animator)
    {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        
    }
    return _animator;
}

@end
