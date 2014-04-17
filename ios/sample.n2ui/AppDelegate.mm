
#include "core/N2Core.h"
#include "ui/N2Ui.h"
#include "ui/N2Application.h"
#include "AppDelegate.h"
#include "VCSample.h"

N2SAMPLE_BEGIN

void SampleApp::load()
{
    root->push(RefInstance<VCSample>());
}

N2SAMPLE_END
