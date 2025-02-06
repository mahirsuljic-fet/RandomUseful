#include <functional>
#include <iostream>

// error on call foo(func, 2) (without specifying foo<T>)
template <typename T>
void foo(std::function<void(T)> func, const T& value)
{
  func(value);
}

template <typename T>
struct helper
{
    typedef T type;
};

template <typename T>
void foo(typename helper<std::function<void(T)>>::type func, const T& value)
{
  func(value);
}

int main()
{
  auto func = [](int value) { std::cout << value << std::endl; };
  foo(func, 2);

  return 0;
}
