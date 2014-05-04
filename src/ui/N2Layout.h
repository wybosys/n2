
#ifndef __N2LAYOUT_FD37247370AF4F7A9A5383520E5F8FBA_H_INCLUDED
#define __N2LAYOUT_FD37247370AF4F7A9A5383520E5F8FBA_H_INCLUDED

#include "N2Graphics.h"

#define N2LAYOUT_BEGIN N2_BEGIN_NS(layout)
#define N2LAYOUT_END N2_END_NS

N2LAYOUT_BEGIN

class Linear;
class Layout;
class VBox;
class HBox;

class Segment
{
public:
    
    Segment()
    : type(Pixel), value({0}), result(0), ctx(NULL)
    {
        aspect[0] = aspect[1] = 0;
    }
    
    enum {
        Pixel,
        Flex,
        Aspect,
    } type;
    
    union {
        real pixel;
        real flex;
    } value;
    real aspect[2];
    
    real result;
    void* ctx;
};

class Linear
{
public:
    
    Linear(VBox const&);
    Linear(HBox const&);
    
    // 占比的默认大小以及最小大小，不输入则是自动的
    real flexValue, minFlexValue;
    
    // 增加占比以及数值
    Linear& flex(real);
    Linear& pixel(real);
    Linear& aspect(real w = 1, real h = 1);
    
    bool started() const;
    real start();
    real next();
    real prev();
    void stop();
    
    // 重新计算各个段的相对长度
    void recalc();
    
    // 使用layout重新初始化linear基础数据
    void reset(Layout const&);
    
protected:
    
    Linear();
    
    ::std::vector<Segment> _segments;
    int _full, _relv, _iter;
    bool _changed, _priority;
    
    friend class Layout;
};

class Layout
{
public:
    
    Layout(ui::Rect const& rc);
    virtual ~Layout();
    
    //重置
    void reset();
    
    // 添加
    ui::Rect add(Linear&);
    
    ui::Edge margin;
    
    ui::Rect const& rect() const {
        return _rc_origin;
    }
    
    void rect(ui::Rect const&);
    
protected:
    
    virtual ui::Rect stride(real);
    
    ui::Rect _rc_origin, _rc_work;
    real _offset_x, _offset_y;
    
    friend class Linear;
};

class VBox
: public Layout
{
public:
    
    VBox(ui::Rect const&);
    
protected:
    
    virtual ui::Rect stride(real);
    
};

class HBox
: public Layout
{
public:
    
    HBox(ui::Rect const&);
    
protected:
    
    virtual ui::Rect stride(real);
    
};

N2LAYOUT_END

N2UI_BEGIN

class View;
class VBox;
class HBox;

class Box
{
public:
    
    Box();
    ~Box();
    
    void reset();
    void apply();
    
    Box& flex(real, View* = NULL, void (*)(Rect const&, View*) = NULL);
    Box& pixel(real, View* = NULL, void (*)(Rect const&, View*) = NULL);
    Box& aspect(real, real, View* = NULL, void (*)(Rect const&, View*) = NULL);
    
    // 子布局
    Box& flex(real, ::std::function<void(HBox&)>, void (*)(Rect const&) = NULL);
    Box& flex(real, ::std::function<void(VBox&)>, void (*)(Rect const&) = NULL);
    Box& pixel(real, ::std::function<void(HBox&)>, void (*)(Rect const&) = NULL);
    Box& pixel(real, ::std::function<void(VBox&)>, void (*)(Rect const&) = NULL);
    
    Rect const& rect() const;
    
protected:
    
    void rect(Rect const&);
    
    class LayoutBlock
    {
    public:
        RefPtr<View> view;
        void (*cb_set)(Rect const&, View*);
        LazyInstance<Box> box;
    };
    
    LazyInstance<layout::Linear> linear;
    LazyInstance<layout::Layout> layout;
    ::std::vector<LayoutBlock*> subs;
    
    void (*cb_set)(Rect const&);
    
private:
    bool _applyed;
};

class VBox
: public Box
{
public:
    
    VBox(Rect const&);
    
};

class HBox
: public Box
{
public:
    
    HBox(Rect const&);
    
};

N2UI_END

#endif
