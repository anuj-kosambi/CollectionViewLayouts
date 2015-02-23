//
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionAlbumLayout.h"
#import "CollectionDataSource.h"

#define kCellWidth 100
#define kCellHeight 100
#define kLineSpacing 0
#define kLeftMargin 0
#define kRightMargin 0
#define kInterSpacing 0


@interface CollectionAlbumLayout () {
    NSInteger SectionCount;
    NSInteger minCellWidth;
    NSInteger kScreenWidth;
    NSInteger kScreenHeight;
    NSInteger lastItemBottom;
    NSMutableArray *itemAttributes;
    NSMutableArray *upperSpaceAttributes;
    CGSize contentSize;
}

@end

@implementation CollectionAlbumLayout

- (void)prepareLayout {
    [super prepareLayout];

    kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    kScreenHeight = [UIScreen mainScreen].bounds.size.height;
    minCellWidth = kScreenWidth / 4;
    SectionCount = [self.collectionView numberOfSections];
    contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    
    upperSpaceAttributes = [NSMutableArray array];
    
    for (int i = 0; i < kScreenWidth / minCellWidth ;i++) {
        [upperSpaceAttributes addObject:[NSValue valueWithCGRect:CGRectZero]];
    }
    
    itemAttributes = [self makeAllAttributes];
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
    
    lastItemBottom = MAX(attributes.frame.origin.y + attributes.frame.size.height, lastItemBottom);
    return attributes;
}

#pragma mark - Helper

- (NSMutableArray *)makeAllAttributes {
    NSMutableArray *attributes = [NSMutableArray array];
    for (int j = 0; j < SectionCount; j++) {
        for ( int i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++ ) {
            UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:j]];
            [attributes addObject:attrib];
            
            
        }
    }
    return  attributes;
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
    if (indexPath.row % 4 == 0) {
        return (int) minCellWidth * 2;
    } else {
        return (int) minCellWidth;
    }
}

- (int)getHeightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        return (int) minCellWidth * 2;
    } else {
        return (int) minCellWidth;
    }
}


@end
