
#include "core/N2Core.h"
#include "ui/N2Ui.h"
#include "VCSample.h"

N2SAMPLE_BEGIN

VSample::VSample()
{
    background(ui::Color::White);
    
    btn.title(@"BUTTON");
    btn.text(Color::Black);
    add(btn);
}

void VSample::onLayout(Rect const& rc)
{
    btn.frame(rc);
}

VCSample::VCSample()
{
    title(@"sample");
}

void VCSample::onLoaded()
{
    
}

N2SAMPLE_END
