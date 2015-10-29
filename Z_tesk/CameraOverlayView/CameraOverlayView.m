//
//  CameraOverlayView.m
//  QRCodeDemo
//
//  Created by mac on 14-10-17.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "CameraOverlayView.h"

@implementation CameraOverlayView
{
    UIImageView *_line;
    int num;
    BOOL upOrdown;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 40)];
    label.text = @"请将扫描的二维码至于下面的框内\n谢谢！";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.lineBreakMode = 0;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    image.frame = CGRectMake(20, 80, 280, 280);
    [self addSubview:image];
    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [image addSubview:_line];
    //定时器，设定时间过1.5秒，
    [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    

    
}

-(void)animation1
{
    num ++;
    _line.frame = CGRectMake(30, 10+2*num, 220, 2);
    if (2*num == 260) {
        //upOrdown = YES;
        num=0;
        _line.frame = CGRectMake(30, 10, 220, 2);
    }
    
}




@end
