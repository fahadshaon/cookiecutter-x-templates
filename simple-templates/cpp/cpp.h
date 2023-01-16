#ifndef __{{ class_name | remove_extension | snake_case | upper }}_H__
#define __{{ class_name | remove_extension | snake_case | upper }}_H__

class {{class_name}} {

public:
    virtual void action();
};

#endif

