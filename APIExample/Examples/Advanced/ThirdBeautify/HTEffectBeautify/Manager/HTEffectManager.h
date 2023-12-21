//
//  HTEffectManager.h
//  APIExample
//
//  Created by Eddie on 2023/6/7.
//  Copyright © 2023 Agora Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VideoFilterDelegate <NSObject>

- (CVPixelBufferRef)processFrame:(CVPixelBufferRef)frame;

@end


@interface HTEffectManager : NSObject<VideoFilterDelegate>

+ (HTEffectManager *)shareManager;

/// 设置贴纸
- (void)setSticker: (NSString *)stickerName;

/// 资源销毁
- (void)setRelease;

@end

NS_ASSUME_NONNULL_END
