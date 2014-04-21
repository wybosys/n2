
#include "core/N2Core.h"
#include "ui/N2Ui.h"
#include "VCSample.h"

N2SAMPLE_BEGIN

VSample::VSample()
{
    background(ui::Color::White);
    
    weak("abc") = (void*)0x100000;
    void* p = weak("abc");
    p = NULL;
}

void VSample::onLayout(Rect const& rc)
{
    
}

VCSample::VCSample()
{
    title(@"sample");
}

void VCSample::onLoaded()
{
    
}

N2SAMPLE_END
