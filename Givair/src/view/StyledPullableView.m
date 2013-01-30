
#import "StyledPullableView.h"

/**
 @author Fabio Rodella fabio@crocodella.com.br
 */

@implementation StyledPullableView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        //UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        //imgView.frame = CGRectMake(0, 0, 320, 460);
        //[self addSubview:imgView];
        //[imgView release];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]CGColor], (id)[[UIColor blackColor]CGColor], [[UIColor blackColor]CGColor], nil];
        [self.layer addSublayer:gradient];
    }
    return self;
}

@end
