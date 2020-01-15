//
//  CamerImageFilterController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/1/16.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "CamerImageFilterController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CamerImageFilterController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *normalView;
@property (weak, nonatomic) IBOutlet UIImageView *fileterView;

@property (nonatomic, strong) UIImagePickerController *pickControlle;
@property (nonatomic, strong)  UIAlertController *alert;

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation CamerImageFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _testImageView.image = [UIImage imageNamed:@"ic_privacy_on"];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (sender.tag == 2000) {
        [self showCamer];
        return;
    }
    if (sender.tag == 2001) {
        [self flitterMtionBlurComplete];
        return;
    }
}


-(void)showCamer{
    if (!_alert) {
        _alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        _alert.popoverPresentationController.sourceView = self.view;
        _alert.popoverPresentationController.sourceRect = CGRectMake(0.5,1,1.0,1.0);
    }

    
    if (!_pickControlle) {
        _pickControlle = [[UIImagePickerController alloc] init];
        _pickControlle.editing = YES;
        _pickControlle.delegate = self;
        _pickControlle.allowsEditing = YES;
        
        //相机选项
        UIAlertAction *camerAction = [UIAlertAction actionWithTitle:@"照相" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _pickControlle.sourceType = UIImagePickerControllerSourceTypeCamera;
            _pickControlle.modalPresentationStyle = UIModalPresentationFullScreen;
            _pickControlle.mediaTypes = @[(NSString *)kUTTypeImage];
            _pickControlle.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [self presentViewController:_pickControlle animated:YES completion:nil];
        }];
        
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _pickControlle.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_pickControlle animated:YES completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:_pickControlle completion:nil];
        }];
        
        [_alert addAction:camerAction];
        [_alert addAction:photoAction];
        [_alert addAction:cancelAction];
    }
    [self presentViewController:_alert animated:YES completion:nil];
 
}


#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    _normalView.image = image;
    
}



//滤镜: 动态模糊
-(void)flitterMtionBlurComplete{
    //1. 将UIImage转换成功UIImage
    CIImage *ciImage = [[CIImage alloc]initWithImage:_normalView.image];
    //2. 创建滤镜
    CIFilter *fliter = [CIFilter filterWithName:@"CIMotionBlur" keysAndValues:kCIInputImageKey,ciImage, nil];
    
    //设置相关参数
    [fliter setValue:@(10.f) forKey:@"inputRadius"];
    
    //3. 渲染并输出CIImage
    CIImage *outTputImage = [fliter outputImage];
    
    //4. 获取上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //5. 创建并输出CGImage
    CGImageRef cgImage = [context createCGImage:outTputImage fromRect:[outTputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //6. 释放CGImage
    CGImageRelease(cgImage);
    
    _fileterView.image = image;
}


@end
