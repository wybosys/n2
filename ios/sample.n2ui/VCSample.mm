
#include "core/N2Core.h"
#include "ui/N2Ui.h"
#include "VCSample.h"

N2SAMPLE_BEGIN

VSample::VSample()
{
    background(ui::Color::White);
    
    btn.title(@"BUTTON");
    btn.text(Color::Black);
    btn.background(Color::Gray);
    add(btn);
    
    btn.signals().connect(kSignalClicked, [](Slot&) {
        LOG("BUTTON CLICKED");
    });
}

void VSample::onLayout(Rect const& rc)
{
    VBox box(rc);
    box.flex(1);
    box.flex(1, [this](HBox& box){
        box.flex(1);
        box.flex(1, &btn);
        box.flex(1);
    });
    box.flex(1);
    box.apply();
}

VCSample::VCSample()
{
    title(@"sample");
}

void VCSample::onLoaded()
{

}

N2SAMPLE_END
