var app = angular.module("books",["ngResource"]);

app.controller("IndexController", function($resource){
  var indexCtrl = this;
  var booksindex = $resource(
    '/books/:verb.json',
    {}
  );
  indexCtrl.books = booksindex.query();
  indexCtrl.show = {
    titleFilter: '',
    authorFilter: '',
    isbnFilter: ''
  };
});

app.controller("FriendController", [ '$resource', '$window' ,function($resource, $window){
  var friendCtrl = this;
  var friendsIndex = $resource(
    '/friends/:verb.json',
    {}
  );
  friendCtrl.friends = friendsIndex.query();

  friendCtrl.addFriend = function(){
    $window.alert('MISTAKES WERE MADE ...'); // implement adding users
  };
}]);

app.controller("TabController", function(){
  var tabCtrl = this;
  tabCtrl.tab = 1;
  tabCtrl.isSet = function(checkTab){
    return tabCtrl.tab === checkTab;
  };

  tabCtrl.setTab = function(setTab){
    tabCtrl.tab = setTab;
  };
});

app.controller("googleBooksHiddenDiv", function(){
  var div = document.getElementById('div-item-data');
});

app.controller("SearchController", function(){
  var searchCtrl = this;
  var searchedIndex = $resource(
    '/books/:verb.json',
    {},
    {search: {method: 'GET', params: {verb: 'search'}}}
  );
  //
  // searchCtrl.search = function(){
  //   searchCtrl.searchedBooks = searchedIndex.query();
  // };
});

// app.controller("TestController", ['$window', '$resource', function($window, $resource){
//   var testCtrl = this;
//   testCtrl.addFriend = function(){
//     $window.alert('Hi');
//   };
// }]);

app.controller("TestController", ['$resource', '$location', function($resource, $location){
  var testCtrl = this;
  var booksindex = $resource(
    '/books/:verb.json',
    {}
  );
  testCtrl.books = booksindex.query();
  // testCtrl.selected = {};
  // testCtrl.titledbooks = [];
  //
  testCtrl.authors = []; //ng-repeat

  testCtrl.getAuthor = function(){

    testCtrl.authors = testCtrl.title.author;
    // angular.forEach(testCtrl.books, function(object){
    //   if(object.title===testCtrl.title){
    //     this.push(object);
    //   }
    // }, testCtrl.authors);
    // return testCtrl.authors;


   // function that updates testCtrl.authors
  };
  // angular.forEach(testCtrl.books, function(key, val){
  //   if(val !== testCtrl.selected.title){
  //
  //   },testCtrl.titledbooks;
  //   return titledbooks;
  // });
}]);

// $scope.filteredCountries = function(){
//     var filteredCountries = [];
//     angular.forEach($scope.countries, function(val, key){
//       if(val !== $scope.selectedCountry){
//         this.push(val);
//       }
//     },filteredCountries);
//     return filteredCountries;
//   };
