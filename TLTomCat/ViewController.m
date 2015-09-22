//
//  ViewController.m
//  TLTomCat
//
//  Created by lichuanjun on 15/9/21.
//  Copyright © 2015年 lichuanjun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btnCymbal;
- (IBAction)btnDrink;
- (IBAction)btnEat;
- (IBAction)btnKnockout;

@property (weak, nonatomic) IBOutlet UIImageView *tomCatView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) playAnimationwithName:(NSString *)imageFileName imageCount:(int)imageCount {
    if (self.tomCatView.isAnimating) {
        return;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<imageCount; i++) {
        NSString *imageFile = [NSString stringWithFormat:@"%@_%02d.jpg",imageFileName,i];
//        UIImage *image = [UIImage imageNamed:imageFile];//如果使用这种方法加载bundle中的图片，系统会自动缓存这些图片
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageFile ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];//系统不会自动缓存这些图片
        [arr addObject:image];
    }
    //1、把要播放的图片加载到UIImageView中
    self.tomCatView.animationImages = arr;
    //2、设置播放的时间
    self.tomCatView.animationDuration = arr.count*0.1;
    //3、设置播放的次数
    self.tomCatView.animationRepeatCount = 1;
    //4、开始播放
    [self.tomCatView startAnimating];
    
    CGFloat time = self.tomCatView.animationDuration * self.tomCatView.animationRepeatCount;
    // 延迟执行某个方法一：
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tomCatView.animationImages = nil;// 清除动画图片
    });
    // 延迟执行某个方法二：
//    [self.tomCatView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:time];
}

- (IBAction)btnCymbal {
    [self playAnimationwithName:@"cymbal" imageCount:13];
}

- (IBAction)btnDrink {
    [self playAnimationwithName:@"drink" imageCount:81];
}

- (IBAction)btnEat {
    [self playAnimationwithName:@"eat" imageCount:40];
}

- (IBAction)btnKnockout {
    [self playAnimationwithName:@"knockout" imageCount:81];
}
@end
