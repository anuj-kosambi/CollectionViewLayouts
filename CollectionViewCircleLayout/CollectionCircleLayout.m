//
//  CollectionCircleLayout.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionCircleLayout.h"
#define kCircleRadius 50

@implementation CollectionCircleLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(2 * kCircleRadius, 2 * kCircleRadius);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

@end
