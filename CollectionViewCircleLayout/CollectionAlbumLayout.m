//
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionAlbumLayout.h"
#import "CollectionDataSource.h"
#import "CollectionDecorationView.h"


#define kCellWidth 100
#define kCellHeight 100
#define kLineSpacing 0
#define kLeftMargin 0
#define kRightMargin 0
#define kInterSpacing 0
#define decorationViewKind @"ImageTitle"

@interface CollectionAlbumLayout () {
    NSInteger SectionCount;
    NSInteger minCellWidth;
    NSInteger kScreenWidth;
    NSInteger kScreenHeight;    
    NSInteger lastItemBottom;
    NSMutableArray *itemAttributes;
    NSMutableArray *decorationAttributes;
    NSMutableArray *upperSpaceAttributes;
    CGSize contentSize;
}

@end

@implementation CollectionAlbumLayout

@synthesize pinchScale, pinchedIndexPath;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerClass:[CollectionDecorationView class] forDecorationViewOfKind:decorationViewKind];
    }
    pinchScale = 1;
    return  self;
}

- (void)prepareLayout {
    [super prepareLayout];
    kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    kScreenHeight = [UIScreen mainScreen].bounds.size.height;
    minCellWidth = kCellWidth;//kScreenWidth / 4;

    SectionCount = [self.collectionView numberOfSections];
    contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    upperSpaceAttributes = [NSMutableArray array];
    for (int i = 0; i < kScreenWidth / minCellWidth ;i++) {
        [upperSpaceAttributes addObject:[NSValue valueWithCGRect:CGRectZero]];
    }
    itemAttributes = [self makeAllItemAttributes];
    decorationAttributes = [self makeAllDecorationAttributes];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    contentSize = CGSizeMake(contentSize.width, lastItemBottom);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *arrayOfAttributesInScreen = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attributes in itemAttributes) {
        if ( CGRectIntersectsRect(rect, attributes.frame) ) {
            [arrayOfAttributesInScreen addObject:attributes];
        }
    }
    for (UICollectionViewLayoutAttributes *attributes in decorationAttributes) {
        if ( CGRectIntersectsRect(rect, attributes.frame) ) {
            [arrayOfAttributesInScreen addObject:attributes];
        }
    }
    
    return arrayOfAttributesInScreen;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    int itemWidth = [self getWidthForItemAtIndexPath:indexPath];
    int itemHeight = [self getHeightForItemAtIndexPath:indexPath];
    
    attributes.frame = CGRectMake(0, 0, itemWidth, itemHeight);

    int cellPositionY = 0;
    int extraPaddingTop = 0;
    int cellPositionX = [self gettingXCoordsFormAttributes:attributes];
    
    //Getting Y coords from upperSpaceAttributes
    if([upperSpaceAttributes count] == kScreenWidth / minCellWidth) {
        CGRect upperCell = [(NSValue *)[upperSpaceAttributes objectAtIndex: cellPositionX / minCellWidth ] CGRectValue];
        cellPositionY = upperCell.size.height + upperCell.origin.y;
    }
    
    //Adding Extra Top Padding
    for (int i = cellPositionX; i < cellPositionX + attributes.size.width; i += minCellWidth  ) {
        CGRect upperCell = [(NSValue *)[upperSpaceAttributes objectAtIndex: i / minCellWidth ] CGRectValue];
        cellPositionY = MAX(upperCell.size.height + upperCell.origin.y, cellPositionY);
    }

    //Updating attributes in the upperSpaceAttributes for nextAllignment
    attributes.frame = CGRectMake(cellPositionX, cellPositionY + kLineSpacing + extraPaddingTop, attributes.frame.size.width, attributes.frame.size.height);
    [self updateAttributeForUpperSpaceAttributes:attributes];
    if ([attributes.indexPath isEqual: pinchedIndexPath]) {
        attributes.transform3D =  CATransform3DMakeScale(pinchScale, pinchScale, 1.0);
        attributes.zIndex = 1;
    }
    lastItemBottom = MAX(attributes.frame.origin.y + attributes.frame.size.height, lastItemBottom);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributesForItem  = [itemAttributes objectAtIndex:indexPath.item];
    UICollectionViewLayoutAttributes *decoAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
//    decoAttributes.frame = CGRectMake (attributesForItem.frame.origin.x, attributesForItem.frame.origin.y + CGRectGetHeight(attributesForItem.frame) * 0.8
//                                       ,CGRectGetWidth(attributesForItem.frame) ,  CGRectGetHeight(attributesForItem.frame));
    decoAttributes.frame = attributesForItem.frame;

    return decoAttributes;

}

#pragma mark - Pinch Scale Setter

- (void)setPinchScale:(CGFloat)scale {
    pinchScale = scale;
    [self invalidateLayout];
}

#pragma mark - Helper

- (NSMutableArray *)makeAllItemAttributes {
    NSMutableArray *attributes = [NSMutableArray array];
    for (int j = 0; j < SectionCount; j++) {
        for ( int i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++ ) {
            UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:j]];
            [attributes addObject:attrib];
        }
    }
    return  attributes;
}

- (NSMutableArray *)makeAllDecorationAttributes {
    NSMutableArray *decoAttributes = [NSMutableArray array];
    for (int j = 0; j < SectionCount; j++) {
        for ( int i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++ ) {
            UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForDecorationViewOfKind:decorationViewKind atIndexPath:[NSIndexPath indexPathForItem:i inSection:j]];
            [decoAttributes addObject:attrib];
            }
    }
    return  decoAttributes;
}

- (int)gettingXCoordsFormAttributes:(UICollectionViewLayoutAttributes *)attributes {//maxYCoords:(int *)cellBottomY {

    CGRect bestCell =  CGRectInfinite;
  
    int leftPadding = 0;
    int cellPositionX = 0;
    
    for (int i = 0; i < kScreenWidth / minCellWidth ; i++ ) {
        if ( i == 0 ) {
            leftPadding = kLeftMargin;
        }
        CGRect currentCell = [(NSValue *)[upperSpaceAttributes objectAtIndex:i ] CGRectValue];
        if( i * minCellWidth + leftPadding + kInterSpacing + attributes.frame.size.width > kScreenWidth - kRightMargin )
            continue;
        
        if( bestCell.origin.y + bestCell.size.height > currentCell.size.height + currentCell.origin.y) {
            if ( attributes.frame.size.width == minCellWidth ) {
                bestCell = CGRectMake( leftPadding +  i *  ( minCellWidth + kInterSpacing), currentCell.origin.y,
                                      currentCell.size.width, currentCell.size.height);
            } else {
                bestCell = CGRectMake( leftPadding +  i *  ( minCellWidth + kInterSpacing), currentCell.origin.y,
                                      currentCell.size.width, currentCell.size.height);
            }
        }
       
        
    }
    cellPositionX = bestCell.origin.x;
    return cellPositionX;
}

- (void)updateAttributeForUpperSpaceAttributes:(UICollectionViewLayoutAttributes *)attributes {

    for (int i = attributes.frame.origin.x; i < attributes.frame.origin.x + attributes.frame.size.width; i += minCellWidth) {
        [upperSpaceAttributes replaceObjectAtIndex:(i / minCellWidth) withObject:[NSValue valueWithCGRect: attributes.frame]];
    }
  
}

- (int)getWidthForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        return (int) minCellWidth * 2;
    } else {
        return (int) minCellWidth;
    }
}

- (int)getHeightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        return (int) minCellWidth * 2;
    } else {
        return (int) minCellWidth;
    }
}


@end
