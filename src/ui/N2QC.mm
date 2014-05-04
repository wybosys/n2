
#import "N2Ui.h"
#import "N2QC.h"

N2_BEGIN

PRIVATE_IMPL(N2QC)

void init()
{
    icon.image(ui::Image(@"AppIcon29x29"));
    icon.resizeToBest();
    
    // 需要根据屏幕方向调整测试UI
    ui::Application::shared().signals().connect(ui::kSignalApplicationOrientationChanging, slot(private_type::cbOrientationChanged), this);
}

void fin()
{
    
}

void cbOrientationChanged(Slot& s)
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
    ui::Application::shared().window.add(d_ptr->icon);
}

N2_END
