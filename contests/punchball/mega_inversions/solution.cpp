#include<iostream>
#include<vector>
using namespace std;
 
typedef long long ll;
 
ll n;
vector<int> numbers;
 
struct Tree {
  vector<ll> tree;
 
  Tree(ll size)
  {
    tree.assign(size * 4, 0);
  }
 
  ll left_memory(ll position)
  {
    return position * 2;
  }
 
  ll right_memory(ll position)
  {
    return position * 2 + 1;
  }
 
  void add(ll position, ll start, ll end, ll key, ll value) 
  {
    if(start <= key && key <= end) {
      tree[position] += value;
 
      if(end > start) {
        add(left_memory(position), start, (start + end)/2, key, value);
        add(right_memory(position), (start + end)/2+1, end, key, value);
      }
    }
  }
 
  void add(ll key, ll value)
  {
    add(1,1,n,key,value);
  }
 
  ll sum(ll position, ll start, ll end, ll query_start, ll query_end)
  {
    if(query_start <= start && end <= query_end) {
      return tree[position];
    } else if(query_start > end || query_end < start) { 
      return 0;
    } else {
      return sum(left_memory(position), start, (start+end)/2, query_start, query_end) + 
        sum(right_memory(position), (start+end)/2+1,      end, query_start, query_end);
    }
  }
 
  ll sum(ll query_start, ll query_end) 
  {
    return sum(1,1,n,query_start,query_end);
  }
};
 
int main()
{
  scanf("%lld", &n);
  Tree frequency(n);
  Tree sum(n);
 
  numbers.resize(n);
 
  for(ll i = n - 1; i != -1; --i)
    scanf("%d", &numbers[i]);
 
  ll res = 0;
  for(ll i = 0; i < n; ++i) {
    frequency.add(numbers[i], 1);
    ll n_smaller = frequency.sum(1, numbers[i] - 1);
    // printf("Smaller than %d: %d\n", numbers[i], n_smaller);
 
    sum.add(numbers[i], n_smaller);
    ll sum_smaller = sum.sum(1, numbers[i] - 1);
    res += sum_smaller;
    // printf("Sum to %d: %d\n", numbers[i], sum_smaller);
  }
 
  printf("%lld\n", res);
}