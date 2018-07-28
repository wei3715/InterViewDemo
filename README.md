
“最怕的情况就是，心中充满了欲望，不甘于平庸，却又不愿意努力的人，这样的人，如果做了程序员，真的是一种悲哀！！！”

本demo主要以代码形式整理面试经常问的问题，理论看完之后总感觉不够透彻，所以以demo代码形式验证，会定时更新~~

一：oc是否有多继承：
多继承概念：多继承即一个子类可以有多个父类，它继承了多个父类的特性。class C : public A, public B，派生类C的成员包含了基类A、B中成员以及该类本身的成员。

假设C类要同时继承A类和B类，则称之为多继承。而Objective-C不支持多继承，由于消息机制名字查找发生在运行时而非编译时，很难解决多个基类可能导致的二义性问题。不过其实 Objective-C 也无需支持多继承，我们可以找到如下几种间接实现多继承目的的方法：
1.通过组合实现“多继承”

2.通过协议实现“多继承”
通过协议实现“多继承”：
虽然OC在语法上禁止类使用多继承，但是却可以用协议来实现多继承。协议只能提供接口，而没有提供实现方式，如果只是想多继承基类的接口，那么遵守多协议无疑是最好的方法。
此方法缺点比较明显：需要修改两个父类，同时并不能调用两个父类的原生方法，需要在子类中实现方法。

协议主要是用来提出类应遵守的标准，但其特性也可用来实现多继承。一个类可以遵守多个协议，也即实现多个协议的方法，以此来达到多继承的效果。
概念上的单继承和多继承应该是继承父类的属性和方法，并且不经重写即可使用，但通过协议实现多继承有如下不同:
子类需要实现协议方法
由于协议无法定义属性，所以该方法只能实现方法的多继承

3.通过category实现“单继承”（大部分网上文章将此方法误解成“多继承”）
相对于协议，它的Runtime特性造就了其一定优势:
可以为类添加方法
可以为类添加实例(通过Runtime)，这是协议做不到的
分类方便管理

4.通过消息转发实现多继承
也是Runtime的黑魔法，其中一个用处就是可以实现多继承，当发送消息后找不到对应的方法实现时，会经过如下过程:

通过类别实现“单继承”
首先摘录一段网上对类的描述：
✓ 使用类别就是为了能够为现有类添加新的方法，不用继承该现有类，就可使用现有类的对象调用添加的方法了。
✓ 类别可以使类的实现分散在多个文件中.
✓ 类别中不能有变量，类别中没有放变量的位置.
✓ 如果类中的方法和类别中的方法名称相同，这将造成冲突，类别的方法将完全取代类的方法。
✓ 同一个类的不同类别声明了相同的方法，这将导致不稳定，哪个方法会被调用是不确定的.
网上很多介绍这种方法的文章，都给出了一个通过类别实现“单继承”的例子，而非“多继承”的例子，但却得出实现了“多继承”的结论，往往使初学者一知半解云里雾里。通过类别可以简单实现类似“单继承”功能，要实现“多继承”则相对复杂一些，可以通过一个新类包含多个类别的方法来实现“多继承”，并不推荐使用。这里也仅给出一个通过类别实现“单继承”的例子，同时在继承的“子类”中增加了两个函数。


二：深浅拷贝：
对于string用copy还是strong：
对不可变NSString，那么strong和copy都是对原来对象的浅拷贝，指向的是同一块内存，而且NSString本身不可改变，所以不存在原值改变影响属性值
对可变NSMutableString：strong仍是浅拷贝，strong修饰的属性变量会和被赋值对象指向同一块内存，被赋值对象值改变，属性变量值也会改变。copy此时则是深拷贝，是拷贝完全一份新的对象，所以赋值对象值改变不会影响copy修饰的属性变量
所以：把一个对象赋值给一个属性变量，当这个对象变化了，如果希望属性变量变化就使用strong属性，如果希望属性变量不跟着变化，就是用copy属性。

//打印
ARC下打印retainCount， CFGetRetainCount((__bridge CFTypeRef)self  ： 打印retainCount
打印指针的地址（不是指针指向对象的地址）：NSLog(@"aStr指针内存地址：%x",&aStr);
打印指针所指向对象的地址使用这个 ：NSLog(@"aStr指针所指向对象的地址：%p",aStr);

/********************************************************************/
三：property常用修饰词weak，strong等区别：

强指针strong：strong修饰的属性一般不会自动释放；
在OC中，对象默认是强指针，在实际开放中一般属性对象一般用strong来修饰（NSArray，NSDictionary），在使用懒加载定义控件的时候，一般也用strong
弱指针Weak:

弱指针weak:在使用 sb 或者 xib 给控件拖线的时候,为什么拖出来的先属性都是用 weak 修饰呢?
原因是由于在向 xib 或者 sb 里面添加控件的时候,添加的子视图是添加到了跟视图 View 上面, 而 控制器 Controller 对其根视图 View 默认是强引用的,当我们的子控件添加到 view 上面的时候, self.view addSubView: 这个方法会对添加的控件进行强引用,如果在用 strong 对添加的子控件进行修饰的话,相当于有两条强指针对子控件进行强引用, 为了避免这种情况,所以用 weak 修饰.

注意: 
1. addSubView 默认对其 subView 进行了强引用
2.在纯手码实现界面布局时，如果通过懒加载处理界面控件，需要使用strong强指针

（weak和strong）不同的是 当一个对象不再有strong类型的指针指向它的时候 它会被释放  ，即使还有weak型指针指向它。
一旦最后一个strong型指针离去 ，这个对象将被释放，所有剩余的weak型指针都将被清除。
可能有个例子形容是妥当的:




//下面内容在demo 中验证
首先strong和weak这两个关键字是用来修饰变量，表示这个变量是强(strong)引用和弱(weak)引用

我们在程序中经常会用到“[[class alloc]init]” 这样的代码，我想你对它已经很熟。这是在开辟一块内存，并初始化。那么系统开辟了这块内存，我们怎么去拿到它呢？

显然是将刚分配好的内存赋值到一个变量，以后我们就可以利用这个变量直接操作这块内存了。那么把刚分配的内存赋值给一个strong变量和weak变量是有区别的：

赋值给weak变量后这块内存会马上被释放。而分配给strong变量的会等到这个变量的生命周期结束后，这块内存才被释放(不用关键字weak修饰的变量默认为strong变量)。

我们可以这样理解，分配出来的内存像一头牛，得用一条结实、强壮（strong）的绳子才能把它牵住，用纤细、弱小（weak）的绳子的话，这头牛随时会把绳子挣断逃脱。
而绳子的另一端是被固定到我们能够看得见够得着的物体（就是我们的变量）上面，我们顺着这个物体上面的绳子摸索过去，你的那头牛还在不在就看你用的上面绳子了。

对代码中打印retaincount个数+1的状况不是很理解，勉强用这句话解释过去吧：
引用计数的问题不必纠结，不光你自己alloc或者copy会导致引用计数增加，系统自己也会将之增减，只不过系统增加了多少，它自己会减少多少，你不要用打印引用计数的方法来查看操作是否正确，举个简单的例子  a = [aclass alloc] init]  这时候a的计数是1  [b addsubview a] 这时候a的计数应该是2或者更多 你relese之后 只会减1，至于此时a的计数到底是多少 是不确定的，可以肯定的是，再你操作对a从初始化到最后操作完毕之后，dealloc 之前，a的计数应该是1，否则不能释放 

关于执行重写的dealloc时，reataincount = 1 而不是 = 0 ，个人感觉这个链接讲的很好：

https://blog.csdn.net/wangjiangang_/article/details/46352559

/********************************************************************/

四：weak和assign
一、区别

1.修饰变量类型的区别
weak 只可以修饰对象，就是指针类型。如果修饰基本数据类型，编译器会报错-“Property with ‘weak’ attribute must be of object type”。weak出现在ARC之后
assign 可修饰对象，和基本数据类型。当需要修饰对象类型时，MRC时代使用unsafe_unretained。当然，unsafe_unretained也可能产生野指针，所以它名字是"unsafe_”。assign出现在ARC之前

2.是否产生野指针的区别
weak 不会产生野指针问题。因为weak修饰的对象释放后（引用计数器值为0），指针会自动被置nil，之后再向该对象发消息也不会崩溃。 weak是安全的。
assign 如果修饰对象，会产生野指针问题；如果修饰基本数据类型则是安全的。修饰的对象释放后，指针不会自动被置空，此时向对象发消息会崩溃。
weak弱引用，所引用对象的计数器不会加一，对象被释放时指针自动被置为nil，避免了循环引用。
assign虽说也可以修饰对象，但是对象被释放时指针并没有被清空，也就是指针没有被置为nil，所以会出现野指针的情况，造成程序奔溃。weak是绝对不可以修饰基本数据类型的，会直接报错。

二、相似

都可以修饰对象类型，但是assign修饰对象会存在问题。它们都是弱引用声明类型

三、总结

assign 适用于基本数据类型如int,float,struct等值类型，不适用于引用类型。因为值类型会被放入栈中，遵循先进后出原则，由系统负责管理栈内存。而引用类型会被放入堆中，需要我们自己手动管理内存或通过ARC管理。
weak 适用于delegate和block等引用类型，不会导致野指针问题，也不会循环引用，非常安全。


深拷贝浅拷贝
在ARC下，我们是不可以对对象调用retain方法修改内存的引用计数的。我们需要先理解一下MRC下的retain、copy和mutableCopy的特点：
retain：始终是浅拷贝，让新对象指针指向原对象，只是原来的内存地址多了一个指针指向，引用计数增加了1（但是系统会进行各种优化，不一定会加，像常量的引用计数就一直保持-1，不会变动，所以对常量string，进行retain也还是不会变）。返回对象是否可变与被复制的对象保持一致。（与ARC中的strong一样） 

copy：对于可变对象为深复制（开辟新内存，与原对象指向的不是一个对象了）;对于不可变对象是浅复制（不开辟新内存，只是原内存地址加了一个新的指针指向，引用计数加1）。返回的对象始终是一个不可变对象。 

mutableCopy：始终是深复制（开辟新内存，与原来对象指向的内存空间不是同一处了）。返回的对象始终是一个可变对象

//主类和多个分类方法调用顺序：
参考链接：
https://blog.csdn.net/appleLg/article/details/79931742

//load方法执行顺序
//打印
//+[TestClass load] [Line 121]
//+[TestClassSon load] [Line 14]
//+[TestClass(method1) load] [Line 13]
//+[TestClass(Method) load] [Line 27]

//Bulid Phases->Compile Sources调整分类的编译顺序后
//打印
//+[TestClass load] [Line 121]
//+[TestClassSon load] [Line 14]
//+[TestClass(Method) load] [Line 27]
//+[TestClass(method1) load] [Line 13]

//结论：
//+load方法的调用是在main() 函数之前,并且不需要主动调用,就是说程序启动会把所有的文件加载
//主类和分类的都会加载调用+load方法
//主类与分类的加载顺序是:主类优先于分类加载,无关编译顺序
//分类间的加载顺序取决于编译的顺序:编译在前则先加载,编译在后则后加载
//规则是：父类优先于子类, 子类优先于分类(父类>子类>分类)

//普通同名方法执行顺序
//打印：
//执行 TestClass (method1) 分类方法
//Bulid Phases->Compile Sources调整分类的编译顺序后
//打印：
//执行 TestClass (method) 分类方法
//结论
//普通的方法中, 分类同名方法会覆盖主类的方法
//多个分类中的同名方法会只执行一个,即后编译的分类里面的方法会覆盖所有前面的同名方法(可以通过调换编译顺序来获得这个结论)
//分类中的方法名和主类方法名一样会报警告,大概就是说分类中实现的方法主类已经实现了（Category is implementing a method which will also be implemented by its primary class）
//可以把声明写在主类, 实现写在分类,这样也能调用到分类里面的代码
//同样可以把声明和实现写在不同的分类文件中,还是能找到的, 不过主类要相同
//普通方法的优先级:分类>子类>父类

探究+ initialize方法的调用
调用子类的+ (void)initialize方法
//当第一次用到类的时候, 如果重写了+ initialize方法,会去调用
//当调用子类的+ initialize方法时候, 先调用父类的,如果父类有分类, 那么分类的+ initialize会覆盖掉父类的, 和普通方法差不多
//父类的+ initialize不一定会调用, 因为分类可能重写了它
//普通方法的优先级:分类>父类>子类


//init和initialize，以及load的区别
initialize不是init
在程序运行过程中，它会在你程序中每个类调用一次initialize。这个调用的时间发生在你的类接收到消息之前，但是在它的父类接收到initialize之后。

//load 和 initialize方法对比
参考链接：http://www.cocoachina.com/ios/20150104/10826.html
load 方法会在加载类的时候就被调用，也就是 ios 应用启动的时候，就会加载所有的类，就会调用每个类的 + load 方法。
在没有对类做任何操作的情况下，+load 方法会被默认执行，并且是在 main 函数之前执行的。程序启动之前会调用



