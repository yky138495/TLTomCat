//
//  ViewController.m
//  TLTomCat
//
//  Created by lichuanjun on 15/9/21.
//  Copyright © 2015年 lichuanjun. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import <AudioToolbox/AudioServices.h>

@interface ViewController ()
- (IBAction)btnCymbal;
- (IBAction)btnDrink;
- (IBAction)btnEat;
- (IBAction)btnKnockout;
- (IBAction)btnFart;
- (IBAction)btnScratch;
- (IBAction)btnPie;

- (IBAction)btnFootLeft;
- (IBAction)btnFootRight;
- (IBAction)btnStomach;
- (IBAction)btnAngryTail;

@property (nonatomic, strong) AVAudioPlayer *player;

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

-(void) playAnimationwithName:(NSString *)imageFileName andImageCount:(int)imageCount andDuration:(float)duration {
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
    self.tomCatView.animationDuration = arr.count*duration;
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

// 播放音乐文件
-(void)playSoundWithFile:(NSString*)filename
{
    NSString *outputSound = [[NSBundle mainBundle] pathForResource:filename ofType:@"wav"];
    NSURL *outUrlB = [NSURL fileURLWithPath:outputSound];
    
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:outUrlB error:&error];
    if (error)
        NSLog(@"AVAudioPlayer error %@, %@", error, [error userInfo]);
    
    [self.player play];
}


-(int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + arc4random() % (to-from+1));
}

- (IBAction)btnCymbal {
    [self playAnimationwithName:@"cymbal" andImageCount:13 andDuration:0.1];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"cymbal" afterDelay:0.8];
}

- (IBAction)btnDrink {
    [self playAnimationwithName:@"drink" andImageCount:81 andDuration:0.07];
    
    [self performSelector:@selector(playSoundWithFile:) withObject:@"pour_milk" afterDelay:1.3];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"p_drink_milk" afterDelay:2.7];
}

- (IBAction)btnEat {
    [self playAnimationwithName:@"eat" andImageCount:40 andDuration:0.07];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"p_eat" afterDelay:0.9];
}

- (IBAction)btnKnockout {
    [self playAnimationwithName:@"knockout" andImageCount:81 andDuration:0.09];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"fall" afterDelay:1.6];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"p_stars2s" afterDelay:2.2];
}

- (IBAction)btnFart {
    int number = [self getRandomNumber:1 to:3];
    NSString *strFileName = [NSString stringWithFormat:@"fart00%d_11025",number];
    [self playAnimationwithName:@"fart" andImageCount:28 andDuration:0.08];
    [self performSelector:@selector(playSoundWithFile:) withObject:strFileName afterDelay:0.7];
}

- (IBAction)btnScratch {
    [self playAnimationwithName:@"scratch" andImageCount:56 andDuration:0.06];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"scratch_kratzen" afterDelay:1.3];
}

- (IBAction)btnPie {
    [self playAnimationwithName:@"pie" andImageCount:24 andDuration:0.1];
}

- (IBAction)btnFootLeft {
    int number = [self getRandomNumber:1 to:2];
    [self playAnimationwithName:@"footLeft" andImageCount:30 andDuration:0.1];
    [self playSoundWithFile:number == 1 ? @"p_foot3" : @"p_foot4"];
}

- (IBAction)btnFootRight {
    int number = [self getRandomNumber:1 to:2];
    [self playAnimationwithName:@"footRight" andImageCount:30 andDuration:0.1];
    [self playSoundWithFile:number == 1 ? @"p_foot3" : @"p_foot4"];
}

- (IBAction)btnStomach {
    int number = [self getRandomNumber:1 to:2];
    [self playAnimationwithName:@"stomach" andImageCount:34 andDuration:0.1];
    [self playSoundWithFile:number == 1 ? @"p_belly1" : @"p_belly2"];
}

- (IBAction)btnAngryTail {
    NSString *file = [NSString stringWithFormat:@"slap%d",[self getRandomNumber:1 to:6]];
    
    [self playAnimationwithName:@"angry" andImageCount:26 andDuration:0.1];
    [self playSoundWithFile:file];
    [self performSelector:@selector(playSoundWithFile:) withObject:@"angry" afterDelay:1.8];
}

@end
