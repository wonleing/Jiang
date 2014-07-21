//
//  NPContentlayout.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPContentlayout.h"

@implementation NPContentlayout
- (void)prepareLayout{
    [super prepareLayout];
}
-(CGSize)collectionViewContentSize{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 130*[self.collectionView numberOfItemsInSection:0]) ;
//    return [self collectionView].frame.size;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    CGRect frame=CGRectMake(0, path.row*130, self.collectionView.frame.size.width, 130);
    attributes.frame=frame;
    return attributes;
}
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}
@end
