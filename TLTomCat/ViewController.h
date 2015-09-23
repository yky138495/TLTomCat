//
//  ViewController.h
//  TLTomCat
//
//  Created by lichuanjun on 15/9/21.
//  Copyright © 2015年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

typedef enum
{
    kTomCatFart = 0, // 放屁
    kTomCatCymbal, // 打叉
    kTomcatDrink, // 喝牛奶
    kTomCatEat, // 吃鸟
    kTomCatPie, // 拍饼
    kTomCatScratch, // 玻璃
    kTomCatKnockout, // 打脸
    kTomCatStomach, // 肚皮
    kTomCatFootRight, // 右脚
    kTomCatFootLeft, // 左脚
    kTomCatAngryTail, // 尾巴
} kTomCatAnimationType;

@end

