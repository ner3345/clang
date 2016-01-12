//
//  MyAdManager.cpp
//  diamondios
//
//  Created by Ner on 16/1/11.
//
//
#import "MyAdManager.h"
#import "myoc.h"

@implementation MyAdManager

+ (void)showAddAtTop {
    
    if (view && size.width > 0) {
        [view setFrame:CGRectMake(0, -13, 320, 50)];
    }
}

+ (void)showAddAtBottom {
    if (view && size.width > 0) {
        [view setFrame:CGRectMake(0, size.height - 50, 320, 50)];
    }
}

@end

