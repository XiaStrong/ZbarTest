//
//  ViewController.m
//  Z_tesk
//
//  Created by Xia_Q on 15/10/29.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "ViewController.h"
#import "ZBarSDK.h"
#import "BlockButton.h"
#import "CameraOverlayView.h"
#import "QRCodeGenerator.h"

@interface ViewController ()<ZBarReaderDelegate,UITextFieldDelegate>

{
    UITextField *_textField;
    UIImageView *_imageView;
    
    UILabel *codeLable;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton systemButtonWithFrame:CGRectMake(100, 100, 100, 30) title:@"扫描" action:^(UIButton *button) {
        
        //如何进行扫描??
        // ZBarReaderViewController 提供用于扫描的类
        ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
        //设置代理, 为了扫描后获取结果
        //  ZBarReaderDelegate
        //
        reader.readerDelegate = self;
        //设置扫描格式
        // 条形码: ZBAR_COMPOSITE   EAN/UPC
        // 二维码: ZBAR_QRCODE
        //  通用: ZBAR_I25 (支持二维码和条形码)
        ZBarImageScanner *scanner = reader.scanner;
        //参数1: 传入需要扫描的编码的格式
        [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
        
        //扫描界面添加图片或文本
        //  UIView * 任意视图添加到扫描界面
        //reader.cameraOverlayView
        CameraOverlayView *view  = [[CameraOverlayView alloc] initWithFrame:CGRectMake(0, 0, 320, 440)];
        reader.cameraOverlayView = view;
        
        
        [self presentViewController:reader animated:YES completion:nil];
    }];
    [self.view addSubview:button];
    
    
    //二维码生成
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 180, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    //显示二维码imageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:_imageView];
    
    UIButton *createButton = [UIButton systemButtonWithFrame:CGRectMake(200, 150, 100, 30) title:@"生成" action:^(UIButton *button) {
        //生成二维码: 把字符串转化为二维码图片
        //参数1: 需要转化的字符串
        //参数2: 图片的大小
        UIImage *image = [QRCodeGenerator qrImageForString:_textField.text imageSize:100];
        _imageView.image = image;
        
    }];
    [self.view addSubview:createButton];
    
    
    codeLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 300, 300, 50)];
    codeLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:codeLable];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//如何处理扫描结果
//实现这个代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //扫描结果存放在
    //id<NSFastEnumeration> symbols = info[ZBarReaderControllerResults];
    for (ZBarSymbol *symbol in info[ZBarReaderControllerResults]) {
        NSLog(@"二维码中数据 %@",symbol.data);
        
        codeLable.text=symbol.data;

        break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
