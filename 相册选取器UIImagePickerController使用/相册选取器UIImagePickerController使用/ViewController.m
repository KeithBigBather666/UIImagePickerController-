//
//  ViewController.m
//  相册选取器UIImagePickerController使用
//
//  Created by NIAN on 2017/4/26.
//  Copyright © 2017年 NIAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.创建相册选取器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //2.设置代理  UIImagePickerController有两个协议：UINavigationControllerDelegate  UIImagePickerControllerDelegate
    picker.delegate = self;
    //3.设置来源
    /**
     UIImagePickerControllerSourceTypePhotoLibrary,相册  (手机相簿)
     UIImagePickerControllerSourceTypeCamera,相机（模拟器不支持）
     UIImagePickerControllerSourceTypeSavedPhotosAlbum，相册（手机照片）
     */
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //4.允许编辑
    picker.allowsEditing = YES;
    //5.弹出相册选取器
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark -UIImagePickerControllerDelegate


/**完成选取的两个方法为递进关系
 */

//2.完成选取  该方法与下面方法1唯一的区别就是将编辑之后的图片image作为参数暴露在外部,而方法二则需要从字典中获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",editingInfo);
    NSLog(@"%@",image);
}


//1.完成选取
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    info中包括选取的照⽚片,视频的主要信息
    //    NSString *const UIImagePickerControllerMediaType; 选取的类型 public.image public.movie
    //    NSString *const UIImagePickerControllerOriginalImage; 修改前 的UIImage object.
    //    NSString *const UIImagePickerControllerEditedImage; 修改后 的UIImage object.
    //    NSString *const UIImagePickerControllerCropRect; 原始图 ⽚片的尺⼨寸NSValue object containing a CGRect data type
    //    NSString *const UIImagePickerControllerMediaURL; 视频在⽂文件系统中 的 NSURL地址
    //    保存视 频主要时通过获取其NSURL 然后转换成NSData
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image = image;
    NSLog(@"%@",info);
}

//取消选取
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
