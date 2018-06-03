//
//  UICollectionViewCarouselLayout.h
//  UICollectionViewLayoutDemo
//
//  Created by 李浩 on 2018/6/3.
//  Copyright © 2018年 GodL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCarouselLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat scale;

@end

@interface UICollectionViewLayout (CarouseLayout)

@property (nonatomic,assign,readonly) NSInteger middleIndex;// This property is KVO-compliant

@end
