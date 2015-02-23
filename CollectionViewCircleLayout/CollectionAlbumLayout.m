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
    NSMutableArray *itemAttributes;
    CGSize contentSize;
}

@end

@implementation CollectionAlbumLayout

- (void)prepareLayout {
    [super prepareLayout];
    SectionCount = [self.collectionView numberOfSections];
    contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
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
    attributes.frame = CGRectMake((kInterSpacing + kCellWidth) * indexPath.row , kInterSpacing, kCellWidth, kCellHeight);
    return attributes;
}
@end
