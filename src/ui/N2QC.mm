
#import "N2Ui.h"
#import "N2QC.h"

N2_BEGIN

PRIVATE_IMPL(N2QC)

void init()
{
    icon.image(ui::Image(@"AppIcon29x29"));
}

void fin()
{
    
}

ui::Picture icon;

PRIVATE_END

N2QC::N2QC()
{
    PRIVATE_CONSTRUCT;
}

N2QC::~N2QC()
{
    PRIVATE_DESTROY;
}

void N2QC::launch()
{

}

N2_END
