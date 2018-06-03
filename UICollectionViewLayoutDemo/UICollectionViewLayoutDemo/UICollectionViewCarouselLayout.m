//
//  UICollectionViewCarouselLayout.m
//  UICollectionViewLayoutDemo
//
//  Created by 李浩 on 2018/6/3.
//  Copyright © 2018年 GodL. All rights reserved.
//

#import "UICollectionViewCarouselLayout.h"

@implementation UICollectionViewCarouselLayout {
    @package
    NSInteger _middleIndex;
}


- (void)prepareLayout {
    [super prepareLayout];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *attributes = [self _deepCopyAttributes:[super layoutAttributesForElementsInRect:rect]];
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    CGFloat viewCenterX = self.collectionView.bounds.size.width * 0.5;
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat scale = 1- (fabs(obj.center.x - contentOffsetX - viewCenterX) /self.itemSize.width * (1 - self.scale));
        obj.transform = CGAffineTransformMakeScale(scale, scale);
        if (scale >= 0.99) {
            NSInteger index = obj.indexPath.row;
            if (self->_middleIndex != index) {
                [self willChangeValueForKey:@"middleIndex"];
                self->_middleIndex = index;
                [self didChangeValueForKey:@"middleIndex"];
            }
        }
    }];
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? roundf(proposedContentOffset.x/(self.itemSize.width+self.minimumLineSpacing)) : roundf(proposedContentOffset.y/(self.itemSize.height+self.minimumLineSpacing));
    return self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? CGPointMake((self.itemSize.width+self.minimumLineSpacing)*index, proposedContentOffset.y) : CGPointMake(proposedContentOffset.x, (self.itemSize.height+self.minimumLineSpacing)*index);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)_deepCopyAttributes:(NSArray<UICollectionViewLayoutAttributes *> *)attributes {
    NSMutableArray *new = [NSMutableArray array];
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [new addObject:obj.copy];
    }];
    return new;
}

@end

@implementation UICollectionViewLayout (CarouseLayout)

- (NSInteger)middleIndex {
    NSAssert([self isKindOfClass:[UICollectionViewCarouselLayout class]], @"only UICollectionViewCarouselLayout has");
    if ([self isKindOfClass:UICollectionViewCarouselLayout.class]) {
        return ((UICollectionViewCarouselLayout *)self)->_middleIndex;
    }
    return 0;
}

@end
