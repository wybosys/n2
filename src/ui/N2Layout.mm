
#import "N2Ui.h"
#import "N2Layout.h"

N2LAYOUT_BEGIN

Linear::Linear()
: minFlexValue(-99999999), _changed(false), _iter(-1)
{
    
}

Linear::Linear(VBox const& box)
: Linear()
{
    _priority = false;
    _full = box._rc_origin.size.h;
    _relv = box._rc_origin.size.w;
}

Linear::Linear(HBox const& box)
: Linear()
{
    _priority = true;
    _full = box._rc_origin.size.w;
    _relv = box._rc_origin.size.h;
}

Linear& Linear::flex(real f)
{
    _changed = true;
    
    Segment seg;
    seg.type = Segment::Flex;
    seg.value.flex = f;
    _segments.push_back(seg);
    return *this;
}

Linear& Linear::pixel(real p)
{
    _changed = true;
    
    Segment seg;
    seg.type = Segment::Pixel;
    seg.value.pixel = p;
    _segments.push_back(seg);
    return *this;
}

Linear& Linear::aspect(real w, real h)
{
    _changed = true;
    
    Segment seg;
    seg.type = Segment::Aspect;
    seg.aspect[0] = w;
    seg.aspect[1] = h;
    _segments.push_back(seg);
    return *this;
}

bool Linear::started() const
{
    return _iter != -1;
}

real Linear::start()
{
    recalc();
    
    _iter = 0;
    Segment& seg = _segments[_iter];
    return seg.result;
}

real Linear::next()
{
    Segment& seg = _segments[++_iter];
    return seg.result;
}

real Linear::prev()
{
    Segment& seg = _segments[--_iter];
    return seg.result;
}

void Linear::stop()
{
    _iter = 0;
}

void Linear::recalc()
{
    if (_changed == false)
        return;
    _changed = false;
    
    real sum_pix = 0;
    real sum_flex = 0;
    
    for (auto i = _segments.begin(); i != _segments.end(); ++i)
    {
        Segment& seg = *i;
        switch (seg.type)
        {
            case Segment::Pixel:
            {
                sum_pix += seg.value.pixel;
            } break;
            case Segment::Flex:
            {
                sum_flex += seg.value.flex;
            } break;
            case Segment::Aspect:
            {
                if (_priority)
                    seg.value.pixel = _relv * (seg.aspect[0] / seg.aspect[1]);
                else
                    seg.value.pixel = _relv * (seg.aspect[1] / seg.aspect[0]);
                sum_pix += seg.value.pixel;
                
            } break;
        }
    }
    
    sum_flex = sum_flex ? sum_flex : 1;
    
    real full_flex = _full - sum_pix;
    real each_flex = full_flex / sum_flex;
    if (flexValue == 0)
        flexValue = each_flex;
    else
        each_flex = flexValue;
    
    if (each_flex < minFlexValue)
        each_flex = minFlexValue;
    
    for (auto i = _segments.begin(); i != _segments.end(); ++i)
    {
        Segment& seg = *i;
        switch (seg.type)
        {
            case Segment::Pixel:
            case Segment::Aspect:
            {
                seg.result = seg.value.pixel;
            } break;
            case Segment::Flex:
            {
                seg.result = seg.value.flex * each_flex;
            } break;
        }
    }
}

Layout::Layout(ui::Rect const& rc)
: _offset_x(0), _offset_y(0)
{
    _rc_work = _rc_origin = rc;
}

Layout::~Layout()
{
    
}

void Layout::reset()
{
    _offset_x = _offset_y = 0;
    _rc_work = _rc_origin;
}

ui::Rect Layout::add(Linear& lnr)
{
    real pix = lnr.started() ? lnr.next() : lnr.start();
    return stride(pix);
}

ui::Rect Layout::stride(real val)
{
    return ui::Rect::Zero;
}

VBox::VBox(ui::Rect const& rc)
: Layout(rc)
{
    
}

ui::Rect VBox::stride(real val)
{
    ui::Rect ret;
    int height = val;
    _offset_y += height;
    ret.origin.x = _rc_work.origin.x;
    ret.origin.y = _rc_work.origin.y;
    _rc_work.origin.y += height;
    ret.size.w = _rc_work.size.w;
    ret.size.w = height;
    return ret;
}

HBox::HBox(ui::Rect const& rc)
: Layout(rc)
{
    
}

ui::Rect HBox::stride(real val)
{
    ui::Rect ret;
    int width = val;
    _offset_x += width;
    ret.origin.x = _rc_work.origin.x;
    ret.origin.y = _rc_work.origin.y;
    _rc_work.origin.x += width;
    ret.size.w = width;
    ret.size.h = _rc_work.size.h;
    return ret;
}

N2LAYOUT_END

N2UI_BEGIN

Box::Box()
: _applyed(false)
{
    
}

Box::~Box()
{
    if (!_applyed)
        apply();
}

void Box::reset()
{
    _applyed = false;
    subs.clear();
    layout->reset();
    linear->stop();
}

void Box::apply()
{
    _applyed = true;
}

Box& Box::flex(real f, View* v, void (*cb)(Rect const&, View*))
{
    LayoutBlock lb;
    lb.view = v;
    lb.cb_set = cb;
    subs.push_back(lb);
    
    linear->flex(f);
    return *this;
}

VBox::VBox(Rect const& rc)
{
    this->layout = new layout::VBox(rc);
    this->linear = new layout::Linear((layout::VBox&)this->layout);
}

HBox::HBox(Rect const& rc)
{
    this->layout = new layout::HBox(rc);
    this->linear = new layout::Linear((layout::HBox&)this->layout);
}

N2UI_END
