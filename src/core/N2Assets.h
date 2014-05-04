
#ifndef __N2ASSETS_4958F91B7519414F9DB20F1E121843FE_H_INCLUDED
#define __N2ASSETS_4958F91B7519414F9DB20F1E121843FE_H_INCLUDED

N2CORE_BEGIN

class Assets
: public Singleton<Assets>
{
public:
    
    // 根据名字查找文件的路径
    String file(String const&) const;
    
    // 查找图片的路径
    String image(String const&) const;
    
protected:
    
    Assets();
    ~Assets();
    
    friend class Singleton<Assets>;
    
    PRIVATE(Assets);
};

N2CORE_END

#endif
