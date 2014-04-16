
# import "N2Ui.h"
# import "N2View.h"

N2UI_BEGIN

View::View()
{
    
}

View::~View()
{
    
}

void View::hidden(bool b)
{
    [getMeta() setHidden:b];
}

bool View::ishidden() const
{
    return [getMeta() isHidden];
}

void View::visible(bool b)
{
    hidden(!b);
}

bool View::isvisible() const
{
    return !ishidden();
}

N2UI_END
