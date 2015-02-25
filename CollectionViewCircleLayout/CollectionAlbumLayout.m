//
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionAlbumLayout.h"
#import "CollectionDataSource.h"

#define kCellWidth 100
#define kCellHeight 100
#define kLineSpacing 5
#define kLeftMargin 10
#define kRightMargin 10
#define kInterSpacing 5
#define kHeaderHeight 50
#define kFooterHeight 0

@interface CollectionAlbumLayout () {
    NSInteger SectionCount;
    NSInteger minCellWidth;
    NSInteger kScreenWidth;
    NSInteger kScreenHeight;
    NSInteger lastItemBottom;
    NSMutableArray *itemAttributes;
    NSMutableArray *headerAttributes;
    NSMutableDictionary *upperSpaceAttributesForSection;
    CGSize contentSize;
}

@end

@implementation CollectionAlbumLayout

#pragma mark - CellSize

- (int)getWidthForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item  % 3 == 0) {
        return (int) minCellWidth * 2;
    } else {
        return (int) minCellWidth;
    }
}

- (int)getHeightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item  % 3 == 0) {
        return (int) minCellWidth * 2;
    } else {
        return (int) minCellWidth;
    }
}

#pragma mark - Override

- (void)prepareLayout {
    [super prepareLayout];
    lastItemBottom = 0;
    kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    kScreenHeight = [UIScreen mainScreen].bounds.size.height;
    minCellWidth = (kScreenWidth -kLeftMargin -kRightMargin - 3 * kInterSpacing) / 4;
    SectionCount = [self.collectionView numberOfSections];
    contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    
    upperSpaceAttributesForSection = [[NSMutableDictionary alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < kScreenWidth / minCellWidth ;i++) {
        CGRect sectionHeaderRect = CGRectMake(0, lastItemBottom + kHeaderHeight + kLineSpacing, 0, 0);
        [array addObject:[NSValue valueWithCGRect:sectionHeaderRect]];
    }
    [upperSpaceAttributesForSection setObject:array forKey:[NSNumber numberWithLong:0]];
    itemAttributes = [self makeAllItemAttributes];
    headerAttributes = [self makeAllHeaderAttributes];
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
    
    for (UICollectionViewLayoutAttributes *attributes in headerAttributes)
    {
        if (CGRectIntersectsRect(rect,attributes.frame) ) {
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
    int cellPositionX = [self gettingXCoordsFormAttributes:attributes];
    
    //Getting Y coords from upperSpaceAttributes
    NSArray *array = [self getUpperAttributesArrayForSection:attributes.indexPath.section];
    CGRect upperCell = [(NSValue *)[array objectAtIndex: cellPositionX / minCellWidth ] CGRectValue];
    cellPositionY = upperCell.size.height + upperCell.origin.y;
    
    //Adding Extra Top Padding
    for (int i = cellPositionX; i < cellPositionX + attributes.size.width; i += minCellWidth  ) {
        NSArray *array = [self getUpperAttributesArrayForSection:attributes.indexPath.section];
        CGRect upperCell = [(NSValue *)[array objectAtIndex: i / minCellWidth ] CGRectValue];
        cellPositionY = MAX(upperCell.size.height + upperCell.origin.y, cellPositionY);
    }

    //Updating attributes in the upperSpaceAttributes for nextAllignment
    attributes.frame = CGRectMake(cellPositionX, cellPositionY + kLineSpacing, attributes.frame.size.width, attributes.frame.size.height);
    [self updateAttributeForUpperSpaceAttributes:attributes];
    
    lastItemBottom = MAX(attributes.frame.origin.y + attributes.frame.size.height, lastItemBottom);
    [self updateUpperRectForNewSection:indexPath];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    int originY = 0;
    if (indexPath.section != 0 ) {
        NSNumber *sectionKey = [NSNumber numberWithLong:indexPath.section];
        NSUInteger partiitonCount = [((NSArray *)[upperSpaceAttributesForSection objectForKey:sectionKey]) count];
        for (int i = 0; i < partiitonCount;i++ ) {
            NSArray *array = [self getUpperAttributesArrayForSection:attributes.indexPath.section - 1];
            CGRect upperCell = [(NSValue *)[array objectAtIndex: i ] CGRectValue];
            originY = MAX(upperCell.size.height + upperCell.origin.y, originY);
        }
    }
    attributes.frame = CGRectMake(0, originY + kLineSpacing, CGRectGetWidth(self.collectionView.frame), kHeaderHeight);
    return attributes;
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

- (NSMutableArray *)makeAllHeaderAttributes {
    NSMutableArray *attributes = [NSMutableArray array];
    for (int j = 0; j < SectionCount; j++) {
        UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForSupplementaryViewOfKind:AlbumHeaderSupplyKind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:j]];
            [attributes addObject:attrib];
    }
    return  attributes;
}

- (int)gettingXCoordsFormAttributes:(UICollectionViewLayoutAttributes *)attributes {

    CGRect bestCell =  CGRectInfinite;
  
    int leftPadding = 0;
    int cellPositionX = 0;
    
    for (int i = 0; i < kScreenWidth / minCellWidth ; i++ ) {
        if ( i == 0 ) {
            leftPadding = kLeftMargin;
        }
        NSArray *array = [self getUpperAttributesArrayForSection:attributes.indexPath.section];
        CGRect currentCell = [(NSValue *)[array objectAtIndex:i ] CGRectValue];
        if( i * minCellWidth + leftPadding + kInterSpacing + attributes.frame.size.width > kScreenWidth - kRightMargin )
            continue;
        
        if( bestCell.origin.y + bestCell.size.height > currentCell.size.height + currentCell.origin.y) {
            if ( attributes.frame.size.width == minCellWidth ) {
                bestCell = CGRectMake( leftPadding +  i *  ( minCellWidth + kInterSpacing) , currentCell.origin.y,
                                      currentCell.size.width, currentCell.size.height);
            } else {
                bestCell = CGRectMake( leftPadding +  i *  ( minCellWidth + kInterSpacing ) , currentCell.origin.y,
                                      currentCell.size.width, currentCell.size.height);
            }
        }
    }
    cellPositionX = bestCell.origin.x;
    return cellPositionX;
}

- (void)updateAttributeForUpperSpaceAttributes:(UICollectionViewLayoutAttributes *)attributes {
    for (int i = attributes.frame.origin.x; i < attributes.frame.origin.x + attributes.frame.size.width; i += minCellWidth) {
        NSMutableArray *array = [self getUpperAttributesArrayForSection:attributes.indexPath.section];
        [array replaceObjectAtIndex:(i / minCellWidth) withObject:[NSValue valueWithCGRect: attributes.frame]];
    }
  
}

- (NSMutableArray *)getUpperAttributesArrayForSection:(long)_section {
    NSNumber *section = [NSNumber numberWithLong:_section];
    return [upperSpaceAttributesForSection objectForKey:section];
}

- (void)updateUpperRectForNewSection:(NSIndexPath *)indexPath {
    NSNumber *nextSection = [NSNumber numberWithLong:(indexPath.section+1)];
    if (indexPath.item + 1 == [self.collectionView numberOfItemsInSection:indexPath.section]
        && indexPath.section + 1 < SectionCount )
    {
        if ([upperSpaceAttributesForSection objectForKey:nextSection] == nil) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < kScreenWidth / minCellWidth ;i++) {
                CGRect upperSectionRect = CGRectMake(0, lastItemBottom + 2 * kLineSpacing + kHeaderHeight + kFooterHeight, 0, 0);
                [array addObject:[NSValue valueWithCGRect:upperSectionRect]];
            }
            [upperSpaceAttributesForSection setObject:array forKey:nextSection];
        }
    }
}

@end
