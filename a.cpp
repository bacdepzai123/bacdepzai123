#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <unordered_map>
#include <queue>
#include <stack>
#include <numeric>
#include <cmath>
#include <algorithm>
#include <string>
#include <cstring>
#include <iomanip>
#include <array>
#include <cassert>
#include <chrono>
#include <random>
#include <bitset>
#include <ctime>

using namespace std;
#define ar array
#define ld long double
#define sza(x) ((int)x.size())
#define all(a) (a).begin(), (a).end()
#define endl "\n" 
#define ll long long 
#define vi vector<int>
#define TIME (1.0 * clock() / CLOCKS_PER_SEC)


const int MAX_N = 1e6 + 5;
const ll MOD = 1e9 + 7;
const ll INF = 1e9;
const ld EPS = 1e-9;

void out_vec(vi& v) {for(int i : v) {cout << i << " ";}}
void in_vec(vi& v) {for(int &i : v) {cin >> i;}}
template<typename A, typename B> ostream& operator<<(ostream &os, const pair<A, B> &p) { return os << '(' << p.first << ", " << p.second << ')'; }
template<typename T_container, typename T = typename enable_if<!is_same<T_container, string>::value, typename T_container::value_type>::type> ostream& operator<<(ostream &os, const T_container &v) { os << '{'; string sep; for (const T &x : v) os << sep << x, sep = ", "; return os << '}'; }
void dbg_out() { cerr << endl; }
template<typename Head, typename... Tail> void dbg_out(Head H, Tail... T) { cerr << ' ' << H; dbg_out(T...); }
#ifdef LOCAL
#define dbg(...) cerr << "(" << #__VA_ARGS__ << "):", dbg_out(__VA_ARGS__)
#else
#define dbg(...)
#endif

void run_case(int testcase) {
    int n;cin >> n;
    string s;cin >> s;
    int low = 0,up = 0;
    for(int i = 0; i < n;i++) {
        if(low > 0 && up > 0) { 
            cout << "YES";
            return;
        }
        else if(int(s[i]) >= 65 && int(s[i]) <= 90) { 
            low++;
        }
        else up++;
    }
    cout << "NO";
    //cout << "Case #" << testcase << ": ";
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    int test_case = 1;
    int i = 1;
    //cin >> test_case;
    while(test_case--) {
        run_case(i);
        i++;
    }
    return (0^0);
}
