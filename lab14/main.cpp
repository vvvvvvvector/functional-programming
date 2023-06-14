#include <iostream>
#include <functional>
#include <vector>
#include <algorithm>

using namespace std;

class Succ
{
public:
    int operator()(int x) { return x + 1; }
};

int succ(int x)
{
    return x + 1;
}

class Add
{
private:
    int x;

public:
    Add(int x) : x(x) {}
    int operator()(int y) { return this->x + y; }
};

vector<int> map_vector(const vector<int> &v, std::function<int(int)> f)
{
    vector<int> result;
    for (int i = 0; i < v.size(); i++)
        result.push_back(f(v[i]));
    return result;
}

// seg fault ???
vector<int> map_vector_tr(const vector<int> &v, std::function<int(int)> f)
{
    vector<int> result;

    std::transform(v.cbegin(), v.cend(), result.begin(), f);

    return result;
}

int main()
{
    Add add10(10);

    cout << add10(15) << '\n';

    auto f = [](int n) // std::function<int(int)>
    { return n + 10; };

    vector<int> v = {1, 2, 3, 4, 5};

    vector<int> v1 = map_vector(v, f);

    for (int i = 0; i < v1.size(); i++)
        cout << v1[i] << ' ';

    cout << '\n';

    // vector<int> v2 = map_vector_tr(v, [](int x)
    //                                { return x * 10; });

    // for (int i = 0; i < v2.size(); i++)
    //     cout << v2[i] << ' ';

    return 0;
}