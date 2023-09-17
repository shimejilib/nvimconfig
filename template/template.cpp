// Author: Yuya Aoki
//
#include <bits/stdc++.h>
#include <stdio.h>
using namespace std;

// マクロ定義
#define OVERLOAD_REP(_1, _2, _3, name, ...) name
#define REP1(i, n) for (auto i = std::decay_t<decltype(n)>{}; (i) != (n); ++(i))
#define REP2(i, l, r) for (auto i = (l); (i) != (r); ++(i))
#define rep(...) OVERLOAD_REP(__VA_ARGS__, REP2, REP1)(__VA_ARGS__)

#define all(a) (a).begin(), (a).end()

// 引数を取得するマクロ
#define $(idx) (std::get<(idx)>(std::forward_as_tuple(_args...)))
// ラムダ式を短く書くマクロ
#define lambda(...) ([&](auto&&... _args) { return (__VA_ARGS__); })

template<class T, size_t n, size_t idx = 0>
auto make_vec(const size_t (&d)[n], const T& init) noexcept {
    if constexpr (idx < n) return std::vector(d[idx], make_vec<T, n, idx + 1>(d, init));
    else return init;
}

template<class T, size_t n>
auto make_vec(const size_t (&d)[n]) noexcept {
    return make_vec(d, T{});
}

int main(int argc, char *argv[]){

	return 0;
}

int sample() {
	// 2引数にも3引数にも対応
	// [0, 5)
	rep(i, 5) {
		cout << i << '\n';
	}
	// [1, 5)
	rep(i, 1, 5) {
		cout << i << '\n';
	}

	vector<int> a{1, 2, 3};
	// イテレータも回せる
	rep(i, a.begin(), a.end()) {
		cout << *i << '\n';
	}

	vector<int> b{1, 3, 2};
	sort(all(b)); // a.begin(), a.end() を省略
	sort(rall(b)); // a.rbegin(), a.rend() を省略
	// $(0)で第一引数、$(1)で第二引数を取得
	auto func = lambda($(0) * 3 + 1);
	cout << func(2) << '\n';
	// 7



}
