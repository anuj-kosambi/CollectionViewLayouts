//
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionAlbumLayout.h"
#import "CollectionDataSource.h"

#define kCellWidth 100
#define kCellHeight 100
#define kLineSpacing 30
#define kLeftMargin 30
#define kRightMargin 30
#define kInterSpacing 10


@interface CollectionAlbumLayout () {
    NSInteger SectionCount;
    NSInteger minCellWidth;
    NSInteger kScreenWidth;
    NSInteger kScreenHeight;
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
    
    itemAttributes = [NSMutableArray array];
    upperSpaceAttributes = [NSMutableArray array];
    
    for (int i = 0; i < kScreenWidth / minCellWidth ;i++) {
        [upperSpaceAttributes addObject:[NSValue valueWithCGRect:CGRectZero]];
    }
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];
    for (int j = 0; j < SectionCount; j++) {
        for ( int i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++ ) {
            UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:j]];
            [attributes addObject:attrib];
            

        }
    }
    return attributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    attributes.frame = CGRectMake((kInterSpacing +  minCellWidth) * indexPath.row ,kInterSpacing, minCellWidth, kCellHeight);
    
    int cellPositionX = 0;
    int cellPositionY = [self gettingXCoordsFormAttributes:attributes];

    //Getting Y coords from upperSpaceAttributes
    if([upperSpaceAttributes count] == kScreenWidth / minCellWidth) {
        CGRect upperCell = [(NSValue *)[upperSpaceAttributes objectAtIndex: cellPositionX / minCellWidth ] CGRectValue];
        cellPositionY = upperCell.size.height + upperCell.origin.y;
    }
    
    //Updating attributes in the upperSpaceAttributes for nextAllignment
    attributes.frame = CGRectMake(cellPositionX, cellPositionY + kLineSpacing , attributes.frame.size.width, attributes.frame.size.height);
    [upperSpaceAttributes replaceObjectAtIndex:(cellPositionX / minCellWidth) withObject:[NSValue valueWithCGRect: attributes.frame]];
    

    return attributes;
}

#pragma mark - Getting X coords 

- (int)gettingXCoordsFormAttributes:(UICollectionViewLayoutAttributes *)attributes {

    CGRect bestCell =  CGRectInfinite;
  
    int leftPadding = 0;
    int cellPositionX = 0;
    
    for (int i = 0; i < kScreenWidth / minCellWidth ; i++ ) {
        
        if ( i == 0 ) {
            leftPadding =  kLeftMargin;
        }
        
        CGRect currentCell = [(NSValue *)[upperSpaceAttributes objectAtIndex:i ] CGRectValue];
        if( i * minCellWidth + leftPadding + kInterSpacing + (attributes).frame.size.width > kScreenWidth - kRightMargin )
            continue;
        
        if( bestCell.origin.y + bestCell.size.height > currentCell.size.height + currentCell.origin.y) {
            if ((attributes).frame.size.width == minCellWidth) {
                bestCell = CGRectMake( leftPadding +  i *  ( minCellWidth + kInterSpacing), currentCell.origin.y, currentCell.size.width, currentCell.size.height);
            }
        }
        
    }
    cellPositionX = bestCell.origin.x;
    NSLog(@"%ld",cellPositionX);
    return cellPositionX;
}

@end
