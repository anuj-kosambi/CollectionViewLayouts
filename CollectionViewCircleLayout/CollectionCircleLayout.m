//
//  CollectionCircleLayout.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionCircleLayout.h"
#define kCircleRadius 35

@interface CollectionCircleLayout () {
    NSUInteger cellCount;
    CGPoint centerPoint;
    NSUInteger radius;
}

@end

@implementation CollectionCircleLayout

- (void)prepareLayout {
[super prepareLayout];
    CGSize size = self.collectionView.frame.size;
    cellCount = [self.collectionView numberOfItemsInSection:0];
    centerPoint = CGPointMake(size.width / 2.0, size.height / 2.0);
    radius = MIN(size.width, size.height) * 0.5  * 0.75;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(2 * kCircleRadius, 2 * kCircleRadius);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attributes = [[NSMutableArray alloc] init];
    for (int i = 0; i < cellCount; i++) {
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.center = CGPointMake(centerPoint.x + radius * cosf(2 * indexPath.item * M_PI / cellCount),
                                    centerPoint.y + radius * sinf(2 * indexPath.item * M_PI / cellCount));
    attributes.size = CGSizeMake(2 * kCircleRadius, 2 * kCircleRadius);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    if (itemIndexPath.item == cellCount - 1) {
        attributes.center = centerPoint;
        attributes.alpha = 0;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath  {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];                         
    return attributes;
}
@end
