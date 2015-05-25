@CLS

@SET HOME=%cd%
@SET HOME_SOURCE=%HOME%\library

COPY /Y %HOME%\mo-1-common\bin\mo-1-common.swc %HOME_SOURCE%\
COPY /Y %HOME%\mo-2-core\bin\mo-2-core.swc     %HOME_SOURCE%\
COPY /Y %HOME%\mo-3-logic\bin\mo-3-logic.swc   %HOME_SOURCE%\

COPY /Y %HOME%\mo-1-common\bin\mo-1-common.swc D:\Work-IS\library\
COPY /Y %HOME%\mo-2-core\bin\mo-2-core.swc     D:\Work-IS\library\
COPY /Y %HOME%\mo-3-logic\bin\mo-3-logic.swc   D:\Work-IS\library\
