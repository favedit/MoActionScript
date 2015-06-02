package mo.cm.lang
{    
   public class  SBigInt{
      // sign of SBigInt, negative or not 
      private  var _sign:Boolean;
      // length of SBigInt 
      private  var _len: int ;
      // digits of SBigInt 
      private  var _digits:Array;
      
      public  function SBigInt(arg:Object){
         var i: * , x: * , need_init:Boolean;
         if  (arg.length  ==   0 ) {
            _sign  =   true ;
            _len  =   1 ;
            _digits  =   new  Array( 1 );
            need_init  =   true ;            
         }else if(arg.length  ==   1 ){
            x  =  getSBigIntFromAny(arg[ 0 ]);
            if  (x  ==  arg[ 0 ]) x  =  x.clone();                
            _sign  =  x._sign;
            _len  =  x._len;
            _digits  =  x._digits;
            need_init  =   false ;            
         }else{
            _sign  =  (arg[ 1 ]  ?   true  :  false );
            _len  =  arg[ 0 ];
            _digits  =   new  Array(_len);
            need_init  =   true ;
         }
         if  (need_init) {
            for (i  =   0 ; i  <  _len; i ++ ){
               _digits[i]  =   0 ;
            }
         }
      }
      
      public  function toString():String
      {
         return   this .toStringBase( 10 );
      }
      
      public  function toStringBase( base : int ):String
      {
         var i: * , j: * , hbase: * ;
         var t: * ;
         var ds: * ;
         var c: * ;
         
         i  =   this ._len;
         if  (i  ==   0 )  return   " 0 " ;
         if  (i  ==   1   &&   ! this ._digits[ 0 ])  return   " 0 " ;
         
         switch ( base ) {
            default :
            case   10 :
               j  =  Math.floor(( 2 * 8 * i * 241 ) / 800 ) + 2 ;
               hbase  =   10000 ;
               break ;
            
            case   16 :
               j  =  Math.floor(( 2 * 8 * i) / 4 ) + 2 ;
               hbase  =   0x10000 ;
               break ;
            
            case   8 :
               j  =  ( 2 * 8 * i) + 2 ;
               hbase  =   010000 ;
               break ;
            
            case   2 :
               j  =  ( 2 * 8 * i) + 2 ;
               hbase  =   020 ;
               break ;
         }
         
         t  =   this .clone();
         ds  =  t._digits;
         var s:String  =   "" ;
         
         while  (i  &&  j) 
         {
            var k: *   =  i;
            var num: *   =   0 ;
            
            while  (k -- ) 
            {
               num  =  (num << 16 )  +  ds[k];
               if (num  <   0 ) num  +=   4294967296 ;
               ds[k]  =  Math.floor(num  /  hbase);
               num  %=  hbase;
            }
            
            if  (ds[i - 1 ]  ==   0 )
               i -- ;
            k  =   4 ;
            while  (k -- ) 
            {
               c  =  (num  %   base );
               s  =   " 0123456789abcdef " .charAt(c)  +  s;
               -- j;
               num  =  Math.floor(num  /   base );
               if  (i  ==   0   &&  num  ==   0 ) 
               {
                  break ;
               }
            }
         }
         
         i  =   0 ;
         while (i  <  s.length  &&  s.charAt(i)  ==   " 0 " )
            i ++ ;
         if (i)
            s  =  s.substring(i, s.length);
         if ( ! this ._sign)
            s  =   " - "   +  s;            
         return  s;
      }
      
      public  function clone():SBigInt
      {
         //         var x:SBigInt, i: int ;
         //         
         //         x  =   new  SBigInt( this ._len,  this ._sign);
         //         for  (i  =   0 ; i  <   this ._len; i ++ )
         //         {
         //            x._digits[i]  =   this ._digits[i]; 
         //         }            
         //         return  x;
         return null;
      }        
      
      /* *
      * become a negative SBigInt
      * @return
      */ 
      public  function negative():SBigInt
      {
         var n:SBigInt  =   this .clone();
         n._sign  =   ! n._sign;
         return  normalize(n);
      }        
      
      public  function toNumber():Number
      {
         var d: *   =   0.0 ;
         var i: *   =  _len;
         var ds: *   =  _digits;
         
         while  (i -- ) 
         {
            d  =  ds[i]  +   65536.0   *  d;
         }
         if  ( ! _sign) d  =   - d;
         return  d;
      }
      
      public  function  get  sign():Boolean 
      { 
         return  _sign; 
      }
      
      public  function  get  length(): int  
      { 
         return  _len; 
      }
      
      public  function  get  digits():Array 
      { 
         return  _digits; 
      }    
      
      
      /* ************  public static methods  ************* */ 
      
      
      public   static  function plus(x: * , y: * ):SBigInt
      {
         x  =  getSBigIntFromAny(x);
         y  =  getSBigIntFromAny(y);
         return  add(x, y,  1 );
      }
      
      public   static  function minus(x: * , y: * ):SBigInt
      {
         x  =  getSBigIntFromAny(x);
         y  =  getSBigIntFromAny(y);
         return  add(x, y,  0 );
      }        
      
      public   static  function multiply(x: * , y: * ):SBigInt
      {
         //         var i: * , j: * ;
         //         var n: *   =   0 ;
         //         var z: * ;
         //         var zds: * , xds: * , yds: * ;
         //         var dd: * , ee: * ;
         //         var ylen: * ;
         //         
         //         x  =  getSBigIntFromAny(x);
         //         y  =  getSBigIntFromAny(y);
         //         
         //         j  =  x._len  +  y._len  +   1 ;
         //         z  =   new  SBigInt(j, x._sign  ==  y._sign);
         //         
         //         xds  =  x._digits;
         //         yds  =  y._digits;
         //         zds  =  z._digits;
         //         ylen  =  y._len;
         //         
         //         while  (j -- ) zds[j]  =   0 ;
         //         for  (i  =   0 ; i  <  x._len; i ++ ) 
         //         {
         //            dd  =  xds[i]; 
         //            if  (dd  ==   0 )  continue ;
         //            n  =   0 ;
         //            for  (j  =   0 ; j  <  ylen; j ++ ) 
         //            {
         //               ee  =  n  +  dd  *  yds[j];
         //               n  =  zds[i  +  j]  +  ee;
         //               if  (ee) zds[i  +  j]  =  (n  &   0xffff );
         //               n  >>>=   16 ;
         //            }
         //            if  (n) 
         //            {
         //               zds[i  +  j]  =  n;
         //            }
         //         }
         //         return  normalize(z);
         return null;
      }        
      
      public   static  function divide(x: * , y: * ):SBigInt
      {
         x  =  getSBigIntFromAny(x);
         y  =  getSBigIntFromAny(y);
         return  divideAndMod(x, y,  0 );
      }
      
      public   static  function mod(x: * , y: * ):SBigInt
      {
         x  =  getSBigIntFromAny(x);
         y  =  getSBigIntFromAny(y);
         return  divideAndMod(x, y,  1 );
      }
      
      /* *
      * compare two SBigInts, if  x=y return 0, if x>y return 1, if x<y return -1.
      * @param    x
      * @param    y
      * @return
      */ 
      public   static  function compare(x: * , y: * ): int 
      {
         var xlen: * ;
         
         if  (x  ==  y)  return   0 ;
         
         x  =  getSBigIntFromAny(x);
         y  =  getSBigIntFromAny(y);
         xlen  =  x._len;
         
         if  (x._sign  !=  y._sign) 
         {
            if  (x._sign)  return   1 ;
            return   - 1 ;
         }
         
         if  (xlen  <  y._len)  return  (x._sign)  ?   - 1  :  1 ;
         if  (xlen  >  y._len)  return  (x._sign)  ?   1  :  - 1 ;
         
         //         while  (xlen --   &&  (x._digits[xlen]  ==  y._digits[xlen]));
         //         if  (  - 1   ==  xlen)  return   0 ;
         
         return  (x._digits[xlen]  >  y._digits[xlen])  ? 
            (x._sign  ?   1  :  - 1 ) :
            (x._sign  ?   - 1  :  1 );
      }
      
      
      /* ************  private static methods  ************* */ 
      
      
      private   static  function getSBigIntFromAny(x: * ):SBigInt
      {            
         //         if  ( typeof (x)  ==   " object " ) 
         //         {
         //            if  (x  is  SBigInt)  return  x;
         //            return   new  SBigInt( 1 ,  1 );
         //         }
         //         
         //         if  ( typeof (x)  ==   " string " ) 
         //         {
         //            
         //            return  getSBigIntFromString(x);
         //         }
         //         
         //         if  ( typeof (x)  ==   " number " ) 
         //         {                
         //            var i: * , x1: * , x2: * , fpt: * , np: * ;
         //            
         //            if  (  - 2147483647   <=  x  &&  x  <=   2147483647 ) 
         //            {
         //               return  getSBigIntFromInt(x);
         //            }
         //            x  =  x  +   "" ;
         //            i  =  x.indexOf( " e " ,  0 );
         //            if  (i  ==   - 1 )  return  getSBigIntFromString(x);
         //            x1  =  x.substr( 0 , i);
         //            x2  =  x.substr(i  +   2 , x.length  -  (i  +   2 ));
         //            
         //            fpt  =  x1.indexOf( " . " ,  0 );
         //            if  (fpt  !=   - 1 ) 
         //            {
         //               np  =  x1.length  -  (fpt  +   1 );
         //               x1  =  x1.substr( 0 , fpt)  +  x1.substr(fpt  +   1 , np);
         //               x2  =  parseInt(x2)  -  np;
         //            }  else  
         //            {
         //               x2  =  parseInt(x2);
         //            }
         //            while  (x2 --   >   0 ) 
         //            {
         //               x1  +=   " 0 " ;
         //            }
         //            return  getSBigIntFromString(x1);
         //         }
         //         return   new  SBigInt( 1 ,  1 );
         return null;
      }    
      
      private   static  function getSBigIntFromInt(n:Number):SBigInt
      {
         //         var sign: * , big:SBigInt, i: * ;
         //         
         //         if  (n  <   0 ) 
         //         {
         //            n  =   - n;
         //            sign  =   false ;
         //         }  else 
         //         {                
         //            sign  =   true ;                
         //         }
         //         n  &=   0x7FFFFFFF ;
         //         
         //         if  (n  <=   0xFFFF ) 
         //         {
         //            big  =   new  SBigInt( 1 ,  1 );
         //            big._digits[ 0 ]  =  n;
         //         }  else 
         //         {                
         //            big  =   new  SBigInt( 2 ,  1 );                
         //            big._digits[ 0 ]  =  (n  &   0xffff );
         //            big._digits[ 1 ]  =  ((n  >>   16 )  &   0xffff );
         //         }
         //         return  big;
         return null;
      }
      
      private   static  function getSBigIntFromString(str:String,  base : *   =   null ):SBigInt
      {
         var str_i: * ;
         var sign:Boolean  =   true ;
         var c: * ;
         var len: * ;
         var z: * ;
         var zds: * ;
         var num: * ;
         var i: * ;
         var blen: *   =   1 ;
         
         str  +=   " @ " ;
         str_i  =   0 ;
         
         if  (str.charAt(str_i)  ==   " + " ) 
         {
            str_i ++ ;
         } else   if  (str.charAt(str_i)  ==   " - " ) 
         {
            str_i ++ ;
            sign  =   false ;
         }
         
         if  (str.charAt(str_i)  ==   " @ " )
            return   null ;
         
         if  ( ! base ) 
         {
            if  (str.charAt(str_i)  ==   " 0 " )
            {
               c  =  str.charAt(str_i  +   1 );
               if  (c  ==   " x "   ||  c  ==   " X " ) 
               {
                  base   =   16 ;
               } else   if  (c  ==   " b "   ||  c  ==   " B " ) 
               {
                  base   =   2 ;
               } else  
               {
                  base   =   8 ;
               }
            } else  
            {
               base   =   10 ;
            }
         }
         
         if  ( base   ==   8 ) 
         {
            while  (str.charAt(str_i)  ==   " 0 " )
               str_i ++ ;
            len  =   3   *  (str.length  -  str_i);
         } else  
         {
            if  ( base   ==   16   &&  str.charAt(str_i)  ==   ' 0 '   &&  (str.charAt(str_i  +   1 )  ==   " x "   ||  str.charAt(str_i  +   1 )  ==   " X " )) 
            {
               str_i  +=   2 ;
            }
            if  ( base   ==   2   &&  str.charAt(str_i)  ==   ' 0 '   &&  (str.charAt(str_i  +   1 )  ==   " b "   ||  str.charAt(str_i  +   1 )  ==   " B " )) 
            {
               str_i  +=   2 ;
            }
            while  (str.charAt(str_i)  ==   " 0 " )
               str_i ++ ;
            if  (str.charAt(str_i)  ==   " @ " ) str_i -- ;
            len  =   4   *  (str.length  -  str_i);
         }
         
         len  =  (len  >>   4 )  +   1 ;
         //z  =   new  SBigInt(len, sign);
         zds  =  z._digits;
         
         while  ( true ) 
         {
            c  =  str.charAt(str_i ++ );
            if (c  ==   " @ " )
               break ;
            switch  (c) 
            {
               case   ' 0 ' : c  =   0 ;  break ;
               case   ' 1 ' : c  =   1 ;  break ;
               case   ' 2 ' : c  =   2 ;  break ;
               case   ' 3 ' : c  =   3 ;  break ;
               case   ' 4 ' : c  =   4 ;  break ;
               case   ' 5 ' : c  =   5 ;  break ;
               case   ' 6 ' : c  =   6 ;  break ;
               case   ' 7 ' : c  =   7 ;  break ;
               case   ' 8 ' : c  =   8 ;  break ;
               case   ' 9 ' : c  =   9 ;  break ;
               case   ' a ' :  case   ' A ' : c  =   10 ;  break ;
               case   ' b ' :  case   ' B ' : c  =   11 ;  break ;
               case   ' c ' :  case   ' C ' : c  =   12 ;  break ;
               case   ' d ' :  case   ' D ' : c  =   13 ;  break ;
               case   ' e ' :  case   ' E ' : c  =   14 ;  break ;
               case   ' f ' :  case   ' F ' : c  =   15 ;  break ;
               default :
                  c  =   base ;
                  break ;
            }
            if  (c  >=   base )  break ;
            
            i  =   0 ;
            num  =  c;
            while  ( true ) 
            {
               while  (i  <  blen) 
               {
                  num  +=  zds[i] * base ;
                  zds[i ++ ]  =  (num  &   0xffff );
                  num  >>>=   16 ;
               }
               if  (num) 
               {
                  blen ++ ;
                  continue ;
               }
               break ;
            }
         }
         return  normalize(z);
      }            
      
      private   static  function add(x:SBigInt, y:SBigInt, sign: * ):SBigInt
      {
         var z: * ;
         var num: * ;
         var i: * , len: * ;
         
         sign  =  (sign  ==  y._sign);
         if  (x._sign  !=  sign) 
         {
            if  (sign)  return  subtract(y, x);
            return  subtract(x, y);
         }
         
         if  (x._len  >  y._len) 
         {
            len  =  x._len  +   1 ;
            z  =  x; x  =  y; y  =  z;
         }  else  
         {
            len  =  y._len  +   1 ;
         }
         //z  =   new  SBigInt(len, sign);
         
         len  =  x._len;
         for  (i  =   0 , num  =   0 ; i  <  len; i ++ ) 
         {
            num  +=  x._digits[i]  +  y._digits[i];
            z._digits[i]  =  (num  &   0xffff );
            num  >>>=   16 ;
         }
         len  =  y._len;
         while  (num  &&  i  <  len) 
         {
            num  +=  y._digits[i];
            z._digits[i ++ ]  =  (num  &   0xffff );
            num  >>>=   16 ;
         }
         while  (i  <  len) 
         {
            z._digits[i]  =  y._digits[i];
            i ++ ;
         }
         z._digits[i]  =  (num  &   0xffff );
         return  normalize(z);
      }
      
      private   static  function subtract(x:SBigInt, y:SBigInt):SBigInt
      {
         var z: *   =   0 ;
         var zds: * ;
         var num: * ;
         var i: * ;
         
         i  =  x._len;
         if  (x._len  <  y._len) 
         {
            z  =  x; x  =  y; y  =  z;
         } else   if  (x._len  ==  y._len) 
         {
            while  (i  >   0 ) 
            {
               i -- ;
               if  (x._digits[i]  >  y._digits[i]) 
               {
                  break ;
               }
               if  (x._digits[i]  <  y._digits[i]) 
               {
                  z  =  x; x  =  y; y  =  z;
                  break ;
               }
            }
         }
         
         //z  =   new  SBigInt(x._len, (z  ==   0 )  ?   1  :  0 );
         zds  =  z._digits;
         
         for  (i  =   0 , num  =   0 ; i  <  y._len; i ++ ) 
         { 
            num  +=  x._digits[i]  -  y._digits[i];
            zds[i]  =  (num  &   0xffff );
            num  >>>=   16 ;
         } 
         while  (num  &&  i  <  x._len) 
         {
            num  +=  x._digits[i];
            zds[i ++ ]  =  (num  &   0xffff );
            num  >>>=   16 ;
         }
         while  (i  <  x._len) 
         {
            zds[i]  =  x._digits[i];
            i ++ ;
         }            
         return  normalize(z);
      }
      
      private   static  function divideAndMod(x:SBigInt, y:SBigInt, modulo: * ):SBigInt
      {
         var nx: *   =  x._len;
         var ny: *   =  y._len;
         var i: * , j: * ;
         var yy: * , z: * ;
         var xds: * , yds: * , zds: * , tds: * ;
         var t2: * ;
         var num: * ;
         var dd: * , q: * ;
         var ee: * ;
         var mod: * , div: * ;
         
         yds  =  y._digits;
         if  (ny  ==   0   &&  yds[ 0 ]  ==   0 )  return   null ;
         
         if  (nx  <  ny  ||  nx  ==  ny  &&  x._digits[nx  -   1 ]  <  y._digits[ny  -   1 ]) 
         {
            if  (modulo)  return  normalize(x);
            //return   new  SBigInt( 1 ,  1 );
            return null;
         }
         
         xds  =  x._digits;
         if  (ny  ==   1 ) 
         {
            dd  =  yds[ 0 ];
            z  =  x.clone();
            zds  =  z._digits;
            t2  =   0 ;
            i  =  nx;
            while  (i -- ) 
            {
               t2  =  t2  *   65536   +  zds[i];
               zds[i]  =  (t2  /  dd)  &   0xffff ;
               t2  %=  dd;
            }
            z._sign  =  (x._sign  ==  y._sign);
            if  (modulo)
            {
               if  ( ! x._sign) t2  =   - t2;
               if  (x._sign  !=  y._sign)
               {
                  t2  =  t2  +  yds[ 0 ]  *  (y._sign  ?   1  :  - 1 );
               }
               return  getSBigIntFromInt(t2);
            }
            return  normalize(z);
         }
         
         //z  =   new  SBigInt(nx  ==  ny  ?  nx  +   2  : nx  +   1 , x._sign  ==  y._sign);
         zds  =  z._digits;
         if  (nx  ==  ny) zds[nx  +   1 ]  =   0 ;
         while  ( ! yds[ny  -   1 ]) ny -- ;
         if  ((dd  =  (( 65536   /  (yds[ny  -   1 ]  +   1 ))  &   0xffff ))  !=   1 ) 
         {
            yy  =  y.clone();
            tds  =  yy._digits;
            j  =   0 ;
            num  =   0 ;
            while  (j  <  ny) 
            {
               num  +=  yds[j]  *  dd;
               tds[j ++ ]  =  num  &   0xffff ;
               num  >>=   16 ;
            }
            yds  =  tds;
            j  =   0 ;
            num  =   0 ;
            while  (j  <  nx) 
            {
               num  +=  xds[j]  *  dd;
               zds[j ++ ]  =  num  &   0xffff ;
               num  >>=   16 ;
            }
            zds[j]  =  num  &   0xffff ;
         } else  
         {
            zds[nx]  =   0 ;
            j  =  nx;
            while  (j -- ) zds[j]  =  xds[j];
         }
         j  =  nx  ==  ny  ?  nx  +   1  : nx;
         
         do  
         {
            if  (zds[j]  ==   yds[ny  -   1 ]) q  =   65535 ;
            else  q  =  ((zds[j]  *   65536   +  zds[j  -   1 ])  /  yds[ny  -   1 ])  &   0xffff ;
            if  (q) 
            {
               i  =   0 ; num  =   0 ; t2  =   0 ;
               do  
               {
                  t2  +=  yds[i]  *  q;
                  ee  =  num  -  (t2  &   0xffff );
                  num  =  zds[j  -  ny  +  i]  +  ee;
                  if  (ee) zds[j  -  ny  +  i]  =  num  &   0xffff ;
                  num  >>=   16 ;
                  t2  >>>=   16 ;
               }  while  ( ++ i  <  ny);
               
               num  +=  zds[j  -  ny  +  i]  -  t2;
               while  (num) 
               {
                  i  =   0 ; num  =   0 ; q -- ;
                  do  
                  {
                     ee  =  num  +  yds[i];
                     num  =  zds[j  -  ny  +  i]  +  ee;
                     if  (ee) zds[j  -  ny  +  i]  =  num  &   0xffff ;
                     num  >>=   16 ;
                  }  while  ( ++ i  <  ny);
                  num -- ;
               }
            }
            zds[j]  =  q;
         }  while  ( -- j  >=  ny);
         
         if  (modulo) 
         {
            mod  =  z.clone();
            if  (dd) 
            {
               zds  =  mod._digits;
               t2  =   0 ; i  =  ny;
               while  (i -- ) 
               {
                  t2  =  (t2 * 65536 )  +  zds[i];
                  zds[i]  =  (t2  /  dd)  &   0xffff ;
                  t2  %=  dd;
               }
            }
            mod._len  =  ny;
            mod._sign  =  x._sign;
            if  (x._sign  !=  y._sign) 
            {
               return  add(mod, y,  1 );
            }
            return  normalize(mod);
         }
         
         div  =  z.clone();
         zds  =  div._digits;
         j  =  (nx  ==  ny  ?  nx  +   2  : nx  +   1 )  -  ny;
         for  (i  =   0 ; i  <  j; i ++ ) zds[i]  =  zds[i  +  ny];
         div._len  =  i;
         return  normalize(div);
      }        
      
      private   static  function normalize(x:SBigInt):SBigInt
      {
         var len: *   =  x._len;
         var ds: *   =  x._digits;
         
         //         while  (len --   &&   ! ds[len]);
         //         x._len  =   ++ len;
         return  x;
      }
   }    
}