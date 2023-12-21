//
//  HTEffectManager.m
//  APIExample
//
//  Created by Eddie on 2023/6/7.
//  Copyright © 2023 Agora Corp. All rights reserved.
//

#import "HTEffectManager.h"
#import "HTAppId.h"
#import "BundleUtil.h"
#if __has_include(<HTEffect/HTEffect.h>)
//todo --- HTEffect start0 ---
#import <HTEffect/HTEffect.h>
//todo --- HTEffect end ---
#endif

static HTEffectManager *shareManager = NULL;

#if __has_include(<HTEffect/HTEffect.h>)
@interface HTEffectManager ()<HTEffectDelegate>
#else
@interface HTEffectManager ()
#endif

@property (nonatomic, assign) BOOL isRenderInit;

@end

@implementation HTEffectManager

- (void)onInitFailure {
    
}

- (void)onInitSuccess {
#if __has_include(<HTEffect/HTEffect.h>)
    
    /* ========== 《 美颜 》======== */
    //美白
    [[HTEffect shareInstance] setBeauty:0 value:40];
    //磨皮
    [[HTEffect shareInstance] setBeauty:1 value:60];
    //红润
    [[HTEffect shareInstance] setBeauty:2 value:30];
    //清晰
    [[HTEffect shareInstance] setBeauty:3 value:20];
    //亮度
    [[HTEffect shareInstance] setBeauty:4 value:0];
    //去黑眼圈
    [[HTEffect shareInstance] setBeauty:5 value:0];
    //去法令纹
    [[HTEffect shareInstance] setBeauty:6 value:0];

    /* ========== 《 美型 》======== */
    //大眼
    [[HTEffect shareInstance] setReshape:10 value:45];
    //V脸
    [[HTEffect shareInstance] setReshape:21 value:50];
    //瘦鼻
    [[HTEffect shareInstance] setReshape:31 value:50];
     
    /* ========== 《 滤镜 》======== */
//    [[HTEffect shareInstance] setFilter:HTFilterBeauty name:@"自然3"];
    
    [self setSticker:@"ht_sticker_effect_rabbit_bowknot"];
#endif
    
}

+ (HTEffectManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[HTEffectManager alloc] init];
    });

    return shareManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
#if __has_include(<HTEffect/HTEffect.h>)
        //todo --- HTEffect start1 ---
        [[HTEffect shareInstance] initHTEffect:appId withDelegate:self];
        //todo --- HTEffect end ---
#endif
    }
    return self;
}


- (void)setSticker: (NSString *)stickerName {
//    @"ht_sticker_effect_rabbit_bowknot"
#if __has_include(<HTEffect/HTEffect.h>)
    [[HTEffect shareInstance] setARItem:0 name:stickerName];
#endif
}

- (void)setRelease {
#if __has_include(<HTEffect/HTEffect.h>)
    //todo --- HTEffect start3 ---
    [[HTEffect shareInstance] releaseBufferRenderer];
    //todo --- HTEffect end ---
#endif
}

#pragma mark - VideoFilterDelegate

- (CVPixelBufferRef)processFrame:(CVPixelBufferRef)frame {
#if __has_include(<HTEffect/HTEffect.h>)
    //todo --- HTEffect start2 ---
    CVPixelBufferLockBaseAddress(frame, 0);
    HTFormatEnum format;
    switch (CVPixelBufferGetPixelFormatType(frame)) {
        case kCVPixelFormatType_32BGRA:
            format = HTFormatBGRA;
            break;
        case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
            format = HTFormatNV12;
            break;
        case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:
            format = HTFormatNV12;
            break;
        default:
            NSLog(@"错误的视频帧格式！");
            format = HTFormatBGRA;
            break;
    }
    int imageWidth = 0;
    int imageHeight = 0;
    if (format == HTFormatBGRA) {
        imageWidth = (int)CVPixelBufferGetBytesPerRow(frame) / 4;
        imageHeight = (int)CVPixelBufferGetHeight(frame);
    } else {
//        imageWidth = (int)CVPixelBufferGetWidthOfPlane(inputPixelBuffer , 0);
        //如果出现花屏，修改imageWidth的获取方式
        imageWidth = (int)CVPixelBufferGetBytesPerRowOfPlane(frame , 0);
        imageHeight = (int)CVPixelBufferGetHeightOfPlane(frame , 0);
    }
    unsigned char *baseAddress = (unsigned char *)CVPixelBufferGetBaseAddressOfPlane(frame, 0);
    
    CVPixelBufferUnlockBaseAddress(frame, 0);
    
    if (!_isRenderInit) {
        [[HTEffect shareInstance] releaseBufferRenderer];
        _isRenderInit = [[HTEffect shareInstance] initBufferRenderer:format width:imageWidth height:imageHeight rotation:HTRotationClockwise0 isMirror:YES maxFaces:5];
    }
    [[HTEffect shareInstance] processBuffer:baseAddress];
    //todo --- HTEffect end ---
#endif
    return frame;
}

 

@end
